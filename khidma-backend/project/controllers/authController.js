const db = require("../config/db");

const loginUser = (req, res, next) => {
    try {
        console.log(req.body);

        const { email, password } = req.body;
        const sql = 'SELECT * FROM users WHERE email = ? AND password = ?'
        db.query(sql, [email, password], (err, result) => {
            if (err) {

                next(err);
                return;
            }
            if (result.length > 0) {
                res.status(200).json(
                    {
                        status: 'success',
                        message: 'Logged in successfully',
                        user: result[0]
                    }
                );
            } else {
                res.status(401).json(
                    {
                        status: 'fail',
                        message: 'Invalid credentials'
                    }
                );
            }
        })
    } catch (err) {
        next(err);
    }
}
const signupUser = (req, res, next) => { }
const forgotPass = (req, res, next) => { }
const updateUser = (req, res, next) => { }
const deleteUser = (req, res, next) => { }


module.exports = { loginUser, signupUser, forgotPass, updateUser, deleteUser }