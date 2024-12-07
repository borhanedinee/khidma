const express = require('express')
const { fetchMessages, addMessage, deleteMessage, updateMessage, markAllMessagesAsRead } = require('../controllers/messagesController')
const { updateConversation } = require('../controllers/conversationsController')

const messagesRouter = express.Router()


messagesRouter.get('/api/messages/fetch/:conversationid' , fetchMessages )
messagesRouter.post('/api/messages/markallmessagesasread' , markAllMessagesAsRead )
messagesRouter.post('/api/messages/add' , addMessage )
messagesRouter.post('/api/messages/update' , updateMessage )
messagesRouter.delete('/api/messages/delete/:messageid' , deleteMessage )

module.exports = messagesRouter