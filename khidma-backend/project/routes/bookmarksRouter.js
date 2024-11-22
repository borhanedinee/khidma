const express = require('express')
const { fetchBookmarks, addBookmark, deleteBookmark } = require('../controllers/bookmarksController')

const bookmarksRouter = express.Router()

bookmarksRouter.get('/api/bookmarks/fetch/:userID', fetchBookmarks)
bookmarksRouter.post('/api/bookmarks/add/', addBookmark)
bookmarksRouter.post('/api/bookmarks/delete/', deleteBookmark)

module.exports = bookmarksRouter