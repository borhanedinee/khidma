const errHandler = (err, req, res, next) => {
    console.log('borhaan');
    console.log(err.message);
    
}

module.exports = errHandler;