const uploadResume = (req, res, err) => {
    try {
        // Access the file information via req.file
        console.log('Uploaded file:', req.body);

        res.status(200).json({
            message: 'File uploaded successfully!',
        })

    } catch (error) {
        res.status(500).json({ message: 'File upload failed', error: error.message });
    }
}




module.exports = {uploadResume};