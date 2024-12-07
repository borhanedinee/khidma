const http = require('http');
const { Server } = require('socket.io');
const app = require('./app'); // Import the Express app

// Create an HTTP server with the Express app
const server = http.createServer(app);


const userToSocketMap = {};

// Initialize Socket.IO
const io = new Server(server);

io.on('connection', (socket) => {

    const userid = socket.handshake.query.userId
    userToSocketMap[userid] = socket.id;


    console.log(userToSocketMap);
    

    socket.on('message', (data) => {
        console.log('Message received:', data);
        socket.broadcast.emit('message', data);
    });

    socket.on('disconnect', () => {
        console.log('User disconnected:', socket.id);
    });
});

// Start the combined HTTP and WebSocket server
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Server is running http://localhost:${PORT}`);
});
