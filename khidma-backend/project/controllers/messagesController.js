const db = require("../config/db");
async function addMessage(data) {
    console.log(data);

    const { message, conversationid, senderid, tempid, recieverid } = data;

    return new Promise((resolve, reject) => {
        // Start the transaction
        db.beginTransaction((transactionErr) => {
            if (transactionErr) {
                return resolve({ success: false, error: 'Failed to start transaction', tempid: tempid });
            }



            // Function to insert the message and update the conversation
            const insertMessageAndUpdateConversation = (convId) => {
                const insertMessageSql = 'INSERT INTO `messages`(`conversationid`, `senderid`, `content`) VALUES (?, ?, ?)';
                db.query(insertMessageSql, [convId, senderid, message], (err, result) => {
                    if (err) {
                        return db.rollback(() => {
                            resolve({ success: false, error: err.message, tempid: tempid });
                        });
                    }

                    const insertedId = result.insertId;

                    const updateConversationSql = `
                        UPDATE \`conversations\` 
                        SET \`lastmsg\` = ?, \`lastmsgsentat\` = NOW() 
                        WHERE \`id\` = ?
                    `;
                    db.query(updateConversationSql, [message, convId], (err, result) => {
                        if (err) {
                            return db.rollback(() => {
                                resolve({ success: false, error: err.message, tempid: tempid });
                            });
                        }

                        db.commit((commitErr) => {
                            if (commitErr) {
                                return db.rollback(() => {
                                    resolve({ success: false, error: 'Failed to commit transaction', tempid: tempid });
                                });
                            }

                            resolve({
                                success: true,
                                insertedId: insertedId,
                                conversationlastmsg: message,
                                conversationid: convId,
                                tempid: tempid,
                            });
                        });
                    });
                });
            };

            if (!conversationid) {

                // Check if a conversation between usera and userb already exists
                const checkConversationSql = `
                        SELECT * FROM conversations 
                        WHERE (usera = ? AND userb = ?) OR (usera = ? AND userb = ?)
                        `;

                db.query(checkConversationSql, [senderid, recieverid, recieverid, senderid], (err, result) => {
                    if (err) {
                        console.log(senderid, recieverid, message);
                        console.log(err);
                        return db.rollback(() => {
                            resolve({ success: false, error: err.message, tempid: tempid });
                        });
                    }

                    // If a conversation exists, no need to insert a new one
                    if (result.length > 0) {
                        // Conversation already exists, resolve or handle accordingly
                        console.log("Conversation already exists.");
                        insertMessageAndUpdateConversation(result[0].id);
                        return;

                    }

                    // Insert a new conversation if none exists
                    const insertConversationSql = `
                        INSERT INTO conversations(usera, userb, lastmsg) 
                        VALUES (?, ?, ?)
                    `;
                    db.query(insertConversationSql, [senderid, recieverid, message], (err, result) => {
                        if (err) {
                            console.log(senderid, recieverid, message);
                            console.log(err);
                            return db.rollback(() => {
                                resolve({ success: false, error: err.message, tempid: tempid });
                            });
                        }

                        const newConversationId = result.insertId;

                        // Now insert the message
                        insertMessageAndUpdateConversation(newConversationId);
                    });
                });

            } else {
                // Insert the message into the existing conversation
                insertMessageAndUpdateConversation(conversationid);
            }
        });
    });
}


const updateMessage = (req, res, next) => { }
const deleteMessage = (req, res, next) => { }
const markAllMessagesAsRead = (req, res, next) => {
    try {
        const { conversationid, senderid } = req.body
        const sql = 'UPDATE messages SET ismsgread = 1 WHERE conversationid = ? AND senderid = ? '
        db.query(sql, [conversationid, senderid], (err, results) => {
            if (err) {
                next(err);
                return;
            }
            res.status(200).json(results);
        })
    } catch (error) {
        next(error);
    }
}
const fetchMessages = (req, res, next) => {
    try {
        const conversationid = req.params.conversationid;

        const sql = 'SELECT * FROM messages WHERE conversationid = ? '

        db.query(sql, [conversationid], (err, results) => {
            if (err) {
                next(err);
                return;
            }
            res.json(results);
        })
    } catch (error) {
        next(error);
    }

}



module.exports = {
    addMessage,
    fetchMessages,
    markAllMessagesAsRead,
    updateMessage,
    deleteMessage,
}