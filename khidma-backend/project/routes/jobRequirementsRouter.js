const express = require('express')
const { fetchRequirements, addRequirement, deleteRequirement, updateRequirement } = require('../controllers/jobRecquiremintsController')

const jobRequirementsRouter = express.Router()

jobRequirementsRouter.get('/api/jobRequirements/fetch/:id' , fetchRequirements)
jobRequirementsRouter.post('/api/jobRequirements/add' , addRequirement)
jobRequirementsRouter.delete('/api/jobRequirements/delete' , deleteRequirement)
jobRequirementsRouter.post('/api/jobRequirements/update' , updateRequirement)

module.exports = jobRequirementsRouter