const express = require('express')
const { uploadResume } = require('../controllers/uploadFilesController')

const upload = require('../uploads')

const uploadRouter = express.Router()

uploadRouter.post('/api/uploadresume', upload.single('resume'), uploadResume)


module.exports = uploadRouter