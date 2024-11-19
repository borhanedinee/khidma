const express = require('express')
const { fetchJob, fetchJobs, addJob, deleteJob, updateJob } = require('../controllers/jobsController')

const jobsRouter = express.Router()

jobsRouter.get('/api/jobs/fetch/:jobID', fetchJob)
jobsRouter.get('/api/jobs/fetch', fetchJobs)
jobsRouter.post('/api/jobs/add', addJob)
jobsRouter.delete('/api/jobs/delete', deleteJob)
jobsRouter.post('/api/jobs/update', updateJob)


module.exports = jobsRouter;