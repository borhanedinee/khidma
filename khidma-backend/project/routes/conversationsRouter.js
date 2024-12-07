const express = require('express')
const { fetchConversation, addConversation, updateConversation } = require('../controllers/conversationsController')

const conversationsRouter = express.Router()


conversationsRouter.get('/api/conversations/fetch/:userid' , fetchConversation)
conversationsRouter.post('/api/conversations/add' , addConversation)
conversationsRouter.post('/api/conversations/update' , updateConversation)

module.exports = conversationsRouter
1