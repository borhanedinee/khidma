const express = require('express')
const { uploadResume, deleteResume } = require('../controllers/uploadFilesController')

const upload = require('../uploads')

const uploadRouter = express.Router()

uploadRouter.post('/api/uploadresume', upload.single('resume'), uploadResume)
uploadRouter.delete('/api/deleteresume/:userID', deleteResume)


module.exports = uploadRouter