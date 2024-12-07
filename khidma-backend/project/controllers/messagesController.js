const db = require("../config/db");

const addMessage = (req, res, next) => { }
const updateMessage = (req, res, next) => { }
const deleteMessage = (req, res, next) => { }
const markAllMessagesAsRead = (req, res, next) => { 
    try {
        const {conversationid , senderid} = req.body
        const sql = 'UPDATE messages SET ismsgread = 1 WHERE conversationid = ? AND senderid = ? '
        db.query(sql , [conversationid , senderid] , (err , results) => {
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

        db.query(sql , [conversationid] , (err , results) => {
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