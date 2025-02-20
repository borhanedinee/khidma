const { query } = require("express");
const db = require("../config/db");

const addApplicant = (req, res, next) => {
    try {

        const { job_id, applicant_id, expected_salary, applicant_fullname, applicant_email, applicant_phone, applicant_resume } = req.body;
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
const deleteApplicant = (req, res, next) => { }
const fetchJobApplicants = (req, res, next) => {
    try {
        const jobid = req.params.jobid;
        const sql = `
        SELECT a.* , u.avatar as applicantAvatar FROM applicants as a
        JOIN users as u ON u.id = a.applicant 
        WHERE a.job = ?
        `
        db.query(sql, [jobid], (err, result) => {
            if (err) {
                next(err)
                return;
            }

            res.status(200).json(
                result
            )
        })
    } catch (error) {
        next(error)
    }
}
const updateApplicant = (req, res, next) => {
    try {
        console.log('ffffff');

        const { application_id, expected_salary, applicant_fullname, applicant_email, applicant_phone } = req.body;
        console.log(req.body);

        const sql = 'UPDATE `applicants` SET `applicant_fullname` = ?, `applicant_email` = ?,`applicant_phone` = ?, `expected_salary` = ? WHERE `id` = ?';
        db.query(sql, [applicant_fullname, applicant_email, applicant_phone, expected_salary, application_id,], (err, result) => {
            if (err) {
                console.log('errrrrrrrrr');

                next(err)
                return;
            }

            res.status(200).json({
                message: 'Application was successfully updated'
            })
        })

    } catch (error) {
        next(error);
    }
}
const fetchApplicants = (req, res, next) => {
    try {

        const userID = req.params.userid;
        const sql = `
            SELECT 
            a.id AS application_id,
            a.expected_salary AS application_expected_salary,
            a.created_at AS application_created_at,
            a.applicant_resume AS application_resume,
            a.applicant_fullname AS application_fullname,
            a.applicant_email AS application_email,
            a.applicant_phone AS application_phone,
            
            u.id AS user_id,
            u.email AS user_email,
            u.phone AS user_phone,
            u.fullname AS user_fullname,
            u.password AS user_password,
            u.avatar AS user_avatar,
            u.isrecruiter AS user_isrecruiter,
            u.resume AS user_resume,
            
            j.id AS job_id,
            j.title AS job_title,
            j.type AS job_type,
            j.location AS job_location,
            j.category AS job_category,
            j.company AS job_company,
            j.companylogo AS job_companylogo,
            j.salary AS job_salary,
            j.description AS job_description,
            j.recruiter AS job_recruiter,
            j.posted_at AS job_postedat

            FROM 
                applicants AS a
            INNER JOIN 
                users AS u ON a.applicant = u.id
            INNER JOIN 
                jobs AS j ON a.job = j.id
            WHERE a.applicant = ?
            ORDER BY a.created_at DESC;

        `
        db.query(sql, [userID], (err, results) => {
            if (err) {
                next(err)
                return;
            }
            const transformedData = results.map(item => {
                return {
                    application_id: item.application_id,
                    application_expectedSalary: item.application_expected_salary,
                    application_createdAt: item.application_created_at,
                    application_resume: item.application_resume,
                    application_fullname: item.application_fullname,
                    application_email: item.application_email,
                    applicant_phone: item.application_phone,
                    user: {
                        id: item.user_id,
                        email: item.user_email,
                        phone: item.user_phone,
                        fullname: item.user_fullname,
                        password: item.user_password,
                        avatar: item.user_avatar,
                        isrecruiter: item.user_isrecruiter,
                        resume: item.user_resume
                    },
                    job: {
                        id: item.job_id,
                        title: item.job_title,
                        type: item.job_type,
                        category: item.job_category,
                        location: item.job_location,
                        posted_at: item.job_postedat,
                        company: item.job_company,
                        companylogo: item.job_companylogo,
                        salary: item.job_salary,
                        description: item.job_description,
                        recruiter: item.job_recruiter
                    }
                };
            });

            res.status(200).json(transformedData)
        })
    } catch (error) {
        next(error)
    }
}

const fetchApplicationInfo = (req, res, next) => {
    try {
        const applicationID = req.params.applicationid;
        const sql = `
            SELECT 
            a.id AS application_id,
            a.expected_salary AS application_expected_salary,
            a.created_at AS application_created_at,
            a.applicant_resume AS application_resume,
            a.applicant_fullname AS application_fullname,
            a.applicant_email AS application_email,
            a.applicant_phone AS application_phone,
            
            u.id AS user_id,
            u.email AS user_email,
            u.phone AS user_phone,
            u.fullname AS user_fullname,
            u.password AS user_password,
            u.avatar AS user_avatar,
            u.isrecruiter AS user_isrecruiter,
            u.resume AS user_resume,
            
            j.id AS job_id,
            j.title AS job_title,
            j.type AS job_type,
            j.location AS job_location,
            j.category AS job_category,
            j.company AS job_company,
            j.companylogo AS job_companylogo,
            j.salary AS job_salary,
            j.description AS job_description,
            j.recruiter AS job_recruiter,
            j.posted_at AS job_postedat


            FROM 
                applicants AS a
            INNER JOIN 
                users AS u ON a.applicant = u.id
            INNER JOIN 
                jobs AS j ON a.job = j.id
            WHERE a.id = ?;

        `
        db.query(sql, [applicationID], (err, result) => {
            if (err) {
                next(err)
                return;
            }

            const transformedData = result.map(item => {
                return {
                    application_id: item.application_id,
                    application_expectedSalary: item.application_expected_salary,
                    application_createdAt: item.application_created_at,
                    application_resume: item.application_resume,
                    application_fullname: item.application_fullname,
                    application_email: item.application_email,
                    applicant_phone: item.application_phone,
                    user: {
                        id: item.user_id,
                        email: item.user_email,
                        phone: item.user_phone,
                        fullname: item.user_fullname,
                        password: item.user_password,
                        avatar: item.user_avatar,
                        isrecruiter: item.user_isrecruiter,
                        resume: item.user_resume
                    },
                    job: {
                        id: item.job_id,
                        title: item.job_title,
                        type: item.job_type,
                        company: item.job_company,
                        companylogo: item.job_companylogo,
                        category: item.job_category,
                        location: item.job_location,
                        posted_at: item.job_postedat,
                        salary: item.job_salary,
                        description: item.job_description,
                        recruiter: item.job_recruiter
                    }
                };
            });


            res.status(200).json(transformedData)
        })
    } catch (error) {
        next(error)
    }
}


module.exports = { addApplicant, updateApplicant, fetchApplicants, deleteApplicant, fetchApplicationInfo, fetchJobApplicants }