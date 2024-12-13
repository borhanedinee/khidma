const http = require('http');
const { Server } = require('socket.io');
const app = require('./app'); // Import the Express app
const { addMessage } = require('./controllers/messagesController');

// Create an HTTP server with the Express app
const server = http.createServer(app);


const userToSocketMap = new Map();

// Initialize Socket.IO
const io = new Server(server);

io.on('connection', (socket) => {


    socket.on('connectuserid', (data) => {
        console.log(data);
        

        // adding user socket and user id to the in-memory data
        // so data i can use the valid socket id
        const userid = data.userid
        console.log('user with id ' + userid + ' connected');

        userToSocketMap[userid] = socket.id;

    })


    socket.on('message', async (data) => {
        try {

            // Insert message to the database
            const result = await addMessage(data)



            if (result.success) {


                // Fetch the receiver's socket ID
                const receiverSocketId = userToSocketMap[data.recieverid];
                console.log(userToSocketMap);


                // Notify the receiver if they're online
                if (receiverSocketId) {
                    io.to(receiverSocketId).emit('recievemessage', data);
                } else {
                    console.log('TODO: HANDLE CASHING MESSAGE IF RECIEVER USER IS OFFLINE');
                }



                // Notify the sender of success
                socket.emit('message-status', { success: true, message: 'Message sent successfully.', conversationlastmsg: result.conversationlastmsg, conversationid: result.conversationid, tempid: result.tempid, realid: result.insertedId, sentat: data.sentat });
            } else {
                // Notify the sender of failure
                socket.emit('message-status', { success: false, error: result.error, tempid: result.tempid, });
            }
        } catch (error) {
            // Handle unexpected errors
            console.error('Error handling message event:', error);
            socket.emit('message-status', { success: false, error: 'An unexpected error occurred.', tempid: result.tempid });
        }
    });


    // update typing status
    socket.on('typing', (data) => {
        const receiverSocketId = userToSocketMap[data.recieverid];
        console.log(data);

        io.to(receiverSocketId).emit('recievetyping', data);
    })


    socket.on('disconnect', () => {
        // Iterate through the object to find the key associated with the socket ID
        for (const user in userToSocketMap) {
            if (userToSocketMap[user] === socket.id) {
                delete userToSocketMap[user]; // Remove the key-value pair from the object
                console.log('User disconnected:', user, socket.id);
                break; // Exit the loop once the entry is found and deleted
            }
        }
    });


});

// Start the combined HTTP and WebSocket server
const PORT = process.env.PORT || 3000;
server.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running http://localhost:${PORT}`);
});
