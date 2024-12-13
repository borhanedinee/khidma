const express = require('express');
const { fetchSkills, deleteSkill, addSkill, updateSkill } = require('../controllers/skillsController');

const skillsRouter = express.Router();


skillsRouter.get('/api/skills/fetch/:userid', fetchSkills)
skillsRouter.post('/api/skills/add', addSkill)
skillsRouter.post('/api/skills/update', updateSkill)
skillsRouter.delete('/api/skills/delete/:userid', deleteSkill)


module.exports = skillsRouter