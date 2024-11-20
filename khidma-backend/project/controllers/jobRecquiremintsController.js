const db = require("../config/db")

const fetchRequirements = (req , res , next) => {
    try {
        const jobID = req.params.id
        const sql = 'SELECT * FROM jobrequirements WHERE job = ? '
        db.query(sql, [jobID], (err, result) => {
            if (err) {
                next(err)
                return;
            }
            res.status(200).json(result);
        });
        
    } catch (error) {
        next(error);
    }
}
const addRequirement = (req , res , next) => {}
const updateRequirement = (req , res , next) => {}
const deleteRequirement = (req , res , next) => {}


module.exports = {
  fetchRequirements,
  addRequirement,
  updateRequirement,
  deleteRequirement
};