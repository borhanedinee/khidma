const db = require("../config/db")

const addConversation = (req, res, next) => { }
const fetchConversation = (req, res, next) => {
    try {
        const userid = req.params.userid
        const sql = `
       SELECT 
            c.id as convoid, 
            c.lastmsg as convoLastMsg, 
            c.lastmsgsentat as convoLastMsgSentAt, 
            c.createdat as convoCreatedAt, 
            sender.id as senderId, 
            sender.email as senderEmail, 
            sender.phone as senderPhone, 
            sender.fullname as senderFullname, 
            sender.avatar as senderAvatar, 
            sender.resume as senderResume, 
            sender.password as senderPassword, 
            sender.isrecruiter as senderIsRecruiter, 
            reciever.id as recieverId, 
            reciever.email as recieverEmail, 
            reciever.phone as recieverPhone, 
            reciever.fullname as recieverFullname, 
            reciever.avatar as recieverAvatar,
            reciever.resume as recieverResume,
            reciever.password as recieverPassword,
            reciever.isrecruiter as recieverIsRecruiter,
            (
            SELECT COUNT(*) 
            FROM messages as m 
            WHERE m.conversationid = c.id 
              AND m.senderid != ? 
              AND m.ismsgread = 0
              ) as unreadMessagesCount
        FROM conversations as c 
        JOIN users as sender ON sender.id = c.usera
        JOIN users as reciever ON reciever.id = c.userb
        WHERE c.usera = ? OR c.userb = ?
        ORDER BY c.lastmsgsentat DESC
        `
        db.query(sql, [userid, userid , userid], (err, result) => {
            if (err) {
                next(err)
                return;
            }
            const formattedResult = result.map(convo => ({
                convoid: convo.convoid,
                convoLastMsg: convo.convoLastMsg,
                convoLastMsgSentAt: convo.convoLastMsgSentAt,
                convoCreatedAt: convo.convoCreatedAt,
                usera: {
                    id: convo.senderId,
                    email: convo.senderEmail,
                    phone: convo.senderPhone,
                    fullname: convo.senderFullname,
                    avatar: convo.senderAvatar,
                    resume: convo.senderResume,
                    password: convo.senderPassword,
                    isRecruiter: convo.senderIsRecruiter
                },
                userb: {
                    id: convo.recieverId,
                    email: convo.recieverEmail,
                    phone: convo.recieverPhone,
                    fullname: convo.recieverFullname,
                    avatar: convo.recieverAvatar,
                    resume: convo.recieverResume,
                    password: convo.recieverPassword,
                    isRecruiter: convo.recieverIsRecruiter
                },
                unreadMessagesCount: convo.unreadMessagesCount
            }),);
            res.status(200).json(formattedResult)
        })
    } catch (error) {
        next(error)
    }
}
const updateConversation = (req, res, next) => { }


module.exports = {
    addConversation,
    fetchConversation,
    updateConversation,
}