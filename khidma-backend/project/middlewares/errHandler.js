const errHandler = (err, req, res, next) => {
    console.log('err handler triggered');
    res.status(500).json(
        {
            status: 'error' ,
            message: err.message
        }
    );
    
}

module.exports = errHandler;