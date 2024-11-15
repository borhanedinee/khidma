const express = require('express')
const authRouter = require('./authRouter')

const baseRouter = express.Router()

baseRouter.use(authRouter)




module.exports = baseRouter