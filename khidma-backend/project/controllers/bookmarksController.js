const db = require("../config/db")

const addBookmark = (req, res, next) => {
    try {
        const { userID, jobID } = req.body
        const sql = "INSERT INTO bookmarks (user, job) VALUES (?,?)"
        db.query(sql, [userID, jobID], (err, result) => {
            if (err) {
                next(err)
                return;
            }
            res.status(201).json({
                message: "Bookmark added successfully",
                bookmarkID: result.insertId,
            })
        })
    } catch (error) {
        next(error)
    }
}
const deleteBookmark = (req, res, next) => {
    try {
        const { userID, jobID } = req.body
        const sql = "DELETE FROM bookmarks WHERE user =? AND job =?"
        db.query(sql, [userID, jobID], (err, result) => {
            if (err) {
                next(err)
                return;
            }
            if (result.affectedRows === 0) {
                return res.status(404).json({ message: "Bookmark not found" })
            }
            res.status(200).json({ message: "Bookmark deleted successfully" })
        })
    } catch (error) {
        next(error)
    }
}
const fetchBookmarks = (req, res, next) => {
    try {
        const userID = req.params.userID
        const sql = `
        SELECT 
        bookmarks.id as bookmarkID , bookmarks.job as jobID , bookmarks.user as userID , users.* , jobs.*
        from 
        bookmarks 
        JOIN 
        jobs 
        ON 
        bookmarks.job = jobs.id 
        JOIN 
        users 
        ON 
        bookmarks.user = users.id 
        WHERE users.id = 1
        `
        db.query(sql, [userID], (err, results) => {
            if (err) {
                next(err);
                return;
            }
            console.log(results);
            
            const transformedData = results.map(item => {
                
                return ({
                    bookmarkID: item.bookmarkID,
                    user: {
                        id: item.userID,
                        email: item.email,
                        password: item.password,
                        fullname: item.fullname,
                        avatar: item.avatar,
                        isRecruiter: item.isrecruiter,
                    },
                    job: {
                        id: item.jobID,
                        title: item.title,
                        type: item.type,
                        company: item.company,
                        companylogo: item.companylogo,
                        salary: item.salary,
                        description: item.description,
                        recruiter: item.recruiter,
                    }
                })
            },);
            res.status(200).json(transformedData);
        })
    } catch (error) {
        next(error);
    }
}

module.exports = {
    addBookmark,
    deleteBookmark,
    fetchBookmarks,
}