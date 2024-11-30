const { query } = require("express");
const db = require("../config/db");

const addApplicant = (req, res, next) => {
    try {
        
        const {job_id, applicant_id, expected_salary, applicant_fullname, applicant_email, applicant_phone, applicant_resume } = req.body;
        const sql = 'INSERT INTO `applicants`(`job`, `applicant`, `expected_salary`, `applicant_fullname`, `applicant_email`, `applicant_phone`, `applicant_resume`) VALUES (?,?,?,?,?,?,?)'
        db.query(sql, [job_id, applicant_id, expected_salary, applicant_fullname, applicant_email, applicant_phone, applicant_resume], (err, result) => {
            if (err) {
                next(err)
                return;
            }
            console.log('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
            
            res.status(201).json({
                message: 'Application was successfully submitted'
            })
        })
    } catch (error) {
        next(error)
    }
}
const deleteApplicant = (res, req, next) => { }
const updateApplicant = (res, req, next) => { }
const fetchApplicants = (res, req, next) => { }


module.exports = { addApplicant, updateApplicant, fetchApplicants, deleteApplicant }