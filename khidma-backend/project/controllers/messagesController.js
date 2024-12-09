const db = require("../config/db");

async function addMessage(data) {
    const { message, conversationid, senderid, tempid } = data;

    return new Promise((resolve, reject) => {
        // Start the transaction
        db.beginTransaction((transactionErr) => {
            if (transactionErr) {
                return resolve({ success: false, error: 'Failed to start transaction', tempid: tempid });
            }

            // Insert the message
            const insertMessageSql = 'INSERT INTO `messages`(`conversationid`, `senderid`, `content`) VALUES (?, ?, ?)';
            db.query(insertMessageSql, [conversationid, senderid, message], (err, result) => {
                if (err) {
                    return db.rollback(() => {
                        resolve({ success: false, error: err.message, tempid: tempid });
                    });
                }

                const insertedId = result.insertId;

                // Update the last message in the conversations table
                const updateConversationSql = `
                    UPDATE \`conversations\` 
                    SET \`lastmsg\` = ?, \`lastmsgsentat\` = NOW() 
                    WHERE \`id\` = ?
                `;
                db.query(updateConversationSql, [message, conversationid], (err, result) => {
                    if (err) {
                        return db.rollback(() => {
                            resolve({ success: false, error: err.message, tempid: tempid });
                        });
                    }

                    // Commit the transaction
                    db.commit((commitErr) => {
                        if (commitErr) {
                            return db.rollback(() => {
                                resolve({ success: false, error: 'Failed to commit transaction', tempid: tempid });
                            });
                        }

                        // Transaction successful
                        resolve({
                            success: true,
                            insertedId: insertedId,
                            conversationlastmsg: message,
                            conversationid: conversationid,
                            tempid: tempid,
                        });
                    });
                });
            });
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