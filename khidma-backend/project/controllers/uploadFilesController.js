const db = require("../config/db");

const uploadResume = (req, res, err) => {
    try {


        res.status(200).json({
            message: 'File uploaded successfully!',
        })

    } catch (error) {
        res.status(500).json({ message: 'File upload failed', error: error.message });
    }
}

const deleteResume = (req , res , next) => {
    try {
        const userID = req.params.userID
        const sql = 'UPDATE `users` SET `resume`=? WHERE users.id = ?'
        db.query(sql , ['none' , userID] , (err , result)=>{
            if (err) {
                next(err)
                return;
            }
            res.status(200).json({
                message: 'Resume deleted successfully'
            })
        })
    } catch (error) {
        next(error)
    }
}




module.exports = {uploadResume , deleteResume};