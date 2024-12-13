const express = require('express');
const { addApplicant, deleteApplicant, fetchApplicants, updateApplicant, fetchApplicationInfo, fetchJobApplicants } = require('../controllers/applicantsController');

const applicationRouter = express.Router();



applicationRouter.post('/api/application/add' , addApplicant),
applicationRouter.post('/api/application/edit' , updateApplicant),
applicationRouter.delete('/api/application/delete' , deleteApplicant),
applicationRouter.get('/api/application/fetchbyuser/:userid' , fetchApplicants),
applicationRouter.get('/api/application/fetchapplicationinfo/:applicationid' , fetchApplicationInfo),
applicationRouter.get('/api/application/fetchjobapplicants/:jobid' , fetchJobApplicants),





module.exports = applicationRouter