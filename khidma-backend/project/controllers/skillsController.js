const db = require("../config/db");

const addSkill = (req , res , next) => {
    try {
        const {skill , userid} = req.body;
        const sql = 'INSERT INTO skills (skill , userid) VALUES (?,?)'
        db.query(sql , [skill , userid] , (err , results)=>{
            if (err) {
                next(err);
                return;
            }
            res.status(201).json({message: 'Skill added successfully'})
        })
    } catch (error) {
        next(error);
    }
}
const deleteSkill = (req , res , next) => {}
const updateSkill = (req , res , next) => {}
const fetchSkills = (req , res , next) => {
    try {
        const userid = req.params.userid;
        const sql = 'SELECT * FROM skills WHERE userid = ?'
        db.query(sql , [userid] , (err , results)=>{
            if (err) {
                next(err);
                return;
            }
            res.status(200).json(results)
        })
    } catch (error) {
        next(error)
    }
}


module.exports = {
    fetchSkills,
    addSkill,
    deleteSkill,
    updateSkill,
}