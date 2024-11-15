const loginUser = (req , res , next)=> {
    console.log('finally');
    const err = Error('this is a custom error');
    next(err)
    
} 
const signupUser = (req , res , next)=> {} 
const forgotPass = (req , res , next)=> {}
const updateUser = (req , res , next)=> {}
const deleteUser = (req , res , next)=> {}


module.exports = {loginUser , signupUser , forgotPass , updateUser , deleteUser}