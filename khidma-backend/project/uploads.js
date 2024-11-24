const multer = require('multer');
const db = require('./config/db');


// uploading files from flutter app
// Configure storage
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        // Specify the directory to save uploaded files

        cb(null, './uploads/cvs');
    },
    filename: (req, file, cb) => {
        // Generate a unique name for the file
        const uniqueSuffix = 'resume' + Date.now() + '-' + Math.round(Math.random() * 1E9);
        const resumePointerInDatabase = `${uniqueSuffix}-${file.originalname}`;
        console.log('ccc');


        cb(null, resumePointerInDatabase);

        // ADING USER RESUME TO DATABASE
        const sql = `
                UPDATE users
                SET resume = ?
                WHERE id = ?;
                `
        db.query(sql, [resumePointerInDatabase, req.body.userid], (err, result) => {
            if (err) {
                console.log(err);

                return;
            }
            console.log('User resume updated successfully');
        })


    }
});

// Initialize multer
const upload = multer({
    storage: storage,
});

module.exports = upload