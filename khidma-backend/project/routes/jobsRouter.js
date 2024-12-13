const express = require('express')
const { fetchJob, fetchJobs, addJob, deleteJob, updateJob, fetchJobForRecruiter, fetchJobsByCategory } = require('../controllers/jobsController')

const jobsRouter = express.Router()

jobsRouter.get('/api/jobs/fetch/:jobID', fetchJob)
jobsRouter.get('/api/jobs/fetch', fetchJobs)
jobsRouter.get('/api/jobs/fetchjobscat/:cat', fetchJobsByCategory)
jobsRouter.get('/api/jobs/fetchjobsforrecruiter/:recruiterId', fetchJobForRecruiter)
jobsRouter.post('/api/jobs/add', addJob)
jobsRouter.delete('/api/jobs/delete', deleteJob)
jobsRouter.post('/api/jobs/update', updateJob)


module.exports = jobsRouter;