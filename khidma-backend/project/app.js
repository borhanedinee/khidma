const express = require('express');
const baseRouter = require('./routes/baseRouter');
const db = require('./config/db');
const errHandler = require('./middlewares/errHandler');

const app = express()


// uploads
const path = require('path');

// Make the uploads folder accessible
app.use('/uploads/logos', express.static(path.join(__dirname, '../uploads/logos')));
app.use('/uploads/cvs', express.static(path.join(__dirname, '../uploads/cvs')));






// Middleware to parse JSON request bodies

app.use(express.json())

// Middleware to log request and response details

app.use((req, res, next) => {
  next();
});


// Connect to MySQL
// Connect to MySQL
db.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL database:');
    return;  // Stop further execution if connection fails
  }
  console.log('Connected to MySQL database successfully!');
});




app.use(baseRouter)
app.use(errHandler)





module.exports = app;

