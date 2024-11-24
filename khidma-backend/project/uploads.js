const multer = require('multer');


// uploading files from flutter app
// Configure storage
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        console.log('yeeeeeeeeeeeeeeeea');
        
        // Specify the directory to save uploaded files
        cb(null, './uploads/cvs');
    },
    filename: (req, file, cb) => {
        // Generate a unique name for the file
        const uniqueSuffix = 'resume' + Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, `${uniqueSuffix}-${file.originalname}`);
    }
});

// Initialize multer
const upload = multer({
    storage: storage,
});

module.exports = upload