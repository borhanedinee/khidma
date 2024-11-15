const express = require('express')
const { loginUser, signupUser, forgotPass } = require('../controllers/authController')

const authRouter = express.Router()

authRouter.post('/api/auth/login', loginUser)
authRouter.post('/api/auth/signup', signupUser)
authRouter.post('/api/auth/forgotpassword', forgotPass)


module.exports = authRouter;