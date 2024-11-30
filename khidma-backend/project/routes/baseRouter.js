const express = require('express')
const authRouter = require('./authRouter')
const jobsRouter = require('./jobsRouter')
const jobRequirementsRouter = require('./jobRequirementsRouter')
const bookmarksRouter = require('./bookmarksRouter')
const uploadRouter = require('./uploadFilesRouter')
const applicationRouter = require('./applicationRouter')

const baseRouter = express.Router()

baseRouter.use(authRouter)
baseRouter.use(jobsRouter)
baseRouter.use(jobRequirementsRouter)
baseRouter.use(bookmarksRouter)
baseRouter.use(uploadRouter)
baseRouter.use(applicationRouter)




module.exports = baseRouter