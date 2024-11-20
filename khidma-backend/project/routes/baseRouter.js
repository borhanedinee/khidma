const express = require('express')
const authRouter = require('./authRouter')
const jobsRouter = require('./jobsRouter')
const jobRequirementsRouter = require('./jobRequirementsRouter')

const baseRouter = express.Router()

baseRouter.use(authRouter)
baseRouter.use(jobsRouter)
baseRouter.use(jobRequirementsRouter)




module.exports = baseRouter