const express = require('express')
const authRouter = require('./authRouter')
const jobsRouter = require('./jobsRouter')

const baseRouter = express.Router()

baseRouter.use(authRouter)
baseRouter.use(jobsRouter)




module.exports = baseRouter