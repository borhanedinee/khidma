// const mysql = require('mysql');
// require('dotenv').config();

// const db = mysql.createConnection({
//     // host: process.env.DB_HOST,
//     // user: process.env.DB_USER,
//     // password: process.env.DB_PASS,
//     // database: process.env.DB_NAME,
    
//     host: 'localhost',
//     user: 'root',
//     password: '',
//     database: 'khidma',
// });

// module.exports = db;


const mysql = require('mysql');
require('dotenv').config();

const db = mysql.createConnection({
    host: process.env.DB_HOST || '172.30.179.233',  // OpenShift MySQL Host
    port: process.env.DB_PORT || '3306',  // MySQL Port
    user: process.env.DB_USER || 'myuser',  // Database Username
    password: process.env.DB_PASS || 'mypassword',  // Database Password
    database: process.env.DB_NAME || 'khidma',  // Database Name
});

db.connect((err) => {
    if (err) {
        console.error('❌ Database connection failed:', err);
        process.exit(1); // Exit if the connection fails
    } else {
        console.log('✅ Connected to the database');
    }
});

module.exports = db;
