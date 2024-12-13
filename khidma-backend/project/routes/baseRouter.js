const express = require('express')
const authRouter = require('./authRouter')
const jobsRouter = require('./jobsRouter')
const jobRequirementsRouter = require('./jobRequirementsRouter')
const bookmarksRouter = require('./bookmarksRouter')
const uploadRouter = require('./uploadFilesRouter')
const applicationRouter = require('./applicationRouter')
const conversationsRouter = require('./conversationsRouter')
const messagesRouter = require('./messagesRouter')
const skillsRouter = require('./skillsRouter')

const baseRouter = express.Router()

baseRouter.use(authRouter)
baseRouter.use(jobsRouter)
baseRouter.use(jobRequirementsRouter)
baseRouter.use(bookmarksRouter)
baseRouter.use(uploadRouter)
baseRouter.use(applicationRouter)
baseRouter.use(conversationsRouter)
baseRouter.use(messagesRouter)
baseRouter.use(skillsRouter)




module.exports = baseRouter