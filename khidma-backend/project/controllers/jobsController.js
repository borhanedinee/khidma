const db = require("../config/db")

const addJob = (req, res, next) => { }
const updateJob = (req, res, next) => { }
const deleteJob = (req, res, next) => { }
const fetchJob = (req, res, next) => { }
const fetchJobs = (req, res, next) => {
    try {
        console.log('u here');

        const sql = 'SELECT * FROM jobs'
        db.query(sql, (err, results) => {
            console.log(results);
            
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




module.exports = { addJob, updateJob, deleteJob, fetchJob, fetchJobs }