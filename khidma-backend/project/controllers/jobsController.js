const db = require("../config/db")

const addJob = (req, res, next) => { }
const updateJob = (req, res, next) => { }
const deleteJob = (req, res, next) => { }
const fetchJob = (req, res, next) => { }
const fetchJobForRecruiter = (req, res, next) => {
    try {

        const recruiterid = req.params.recruiterId

        const sql = 'SELECT * FROM jobs WHERE recruiter = ?'
        db.query(sql, [recruiterid], (err, results) => {
            if (err) {
                next(err)
                return;
            }
            res.status(200).json(results);
        })
    } catch (error) {
        next(error)
    }
}

const fetchJobsByCategory = (req, res, next) => {
    try {
        const selectedCategory = req.params.cat; // Ensure this matches your route parameter name
        const searchTerm = `%${selectedCategory}%`; // Use wildcards for partial matches

        // Query with multiple LIKE conditions
        const sql = `
            SELECT * FROM jobs 
            WHERE category LIKE ? 
            OR title LIKE ? 
            OR description LIKE ? 
            OR company LIKE ?
        `;

        const values = [searchTerm, searchTerm, searchTerm, searchTerm];

        db.query(sql, values, (err, results) => {
            if (err) {
                next(err);
                return;
            }

            if (results.length === 0) {
                res.status(404).json({ message: 'No jobs match the criteria.' });
                return;
            }

            res.status(200).json(results);
        });
    } catch (error) {
        next(error);
    }
};



const fetchJobs = (req, res, next) => {
    try {


        const sql = 'SELECT * FROM jobs'
        db.query(sql, (err, results) => {


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




module.exports = { fetchJobsByCategory , addJob, updateJob, deleteJob, fetchJob, fetchJobs, fetchJobForRecruiter, }