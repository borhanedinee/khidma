const express = require('express');
const { addApplicant, deleteApplicant, fetchApplicants } = require('../controllers/applicantsController');

const applicationRouter = express.Router();



applicationRouter.post('/api/application/add' , addApplicant),
applicationRouter.delete('/api/application/delete' , deleteApplicant),
applicationRouter.get('/api/application/fetchbyuser/:userid' , fetchApplicants),





module.exports = applicationRouter