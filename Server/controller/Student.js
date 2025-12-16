const connectDB = require('../config/database');
const moment = require('moment-timezone');





//function to add a leave application in the db
exports.pdfileGenerateFunction= async (req,res)=>{

    try{
        const {  formData } = req.body;
        // console.log("printing the formdata",formData);
        // Get the database connection
        const db = await connectDB();

        const query = "select name, roll_no, u_id, dept_name from users INNER JOIN departments ON users.dept_id=departments.dept_id where email= ?";
        const [results] = await db.execute(query,[req.user.email]);

        const query3 = `insert into leave_applications(u_id,no_of_days,from_date,to_date,l_id,reason,address_during_leave,
                        mobile_no,pdf_file) values(?,?,?,?,?,?,?,?,?)`;
        const [results3] = await db.execute(query3,[results[0].u_id,formData.apply_leave_days,formData.apply_leave_start_date,
                            formData.apply_leave_end_date,formData.nature_of_leave,formData.reason_of_leave,formData.address_during_leave,
                            formData.mobile_no,null]);
       

        return res.status(200).json({
            success: true,
            message: `Leave application submitted successfully`,
          }); 
    } catch(error){
        console.log("Error in submitting leave application:", error);
        return res.status(401).json({
            success: false,
            message: `some error in submitting leave application: ${error.message || error}`, 
          });
    }
}




//function to add a leave application in the db and generating pdf file
exports.natureOfLeave= async (req,res)=>{

    try{

        // Get the database connection
        const db = await connectDB();

        const query = " select * from leave_nature";
        const [results] = await db.execute(query);

        console.log("printing the leave nature data", results);
       

        return res.status(200).json({
            success: true,
            data : results,
            message: `data fetched successfully`,
          }); 
    } catch(error){
        return res.status(401).json({
            success: false,
            message: `some error in fetching data ${error}`,  
          });
    }
}




//function to add a leave application in the db and generating pdf file
exports.AllLeavesOfUser= async (req,res)=>{

    try{

        const { userID } = req.body;
        // Get the database connection
        const db = await connectDB();

        const query = `select application_id, l_nature, status ,submission_date ,no_of_days from leave_applications INNER JOIN 
                        leave_nature ON leave_applications.l_id=leave_nature.l_id where u_id= ? order by submission_date desc`;
        const [results] = await db.execute(query,[userID]);

        results.forEach((result) => {
            result.submission_date = result.submission_date ? moment.tz(result.submission_date, "Asia/Kolkata").format('YYYY-MM-DD') : null;
          });

        // console.log("printing the leave nature data", results);
       

        return res.status(200).json({
            success: true,
            data : results,
            message: `data fetched successfully`,
          }); 
    } catch(error){
        return res.status(401).json({
            success: false,
            message: `some error in fetching data ${error}`, 
          });
    }
}




//function to add a leave application in the db and generating pdf file
exports.LeavesOfUserDetails= async (req,res)=>{

    try{

        const { application_id } = req.body;
        // Get the database connection
        const db = await connectDB();

        const query = `select application_id, no_of_days, from_date ,to_date ,l_nature, reason, address_during_leave, mobile_no, 
                        accepted_days, accepted_from, accepted_to, status, submission_date, resolved_date, pdf_file from 
                        leave_applications INNER JOIN leave_nature ON leave_applications.l_id=leave_nature.l_id where application_id= ?`;
        const [results] = await db.execute(query,[application_id]);

        results.forEach((result) => {
            result.submission_date = result.submission_date ? moment.tz(result.submission_date, "Asia/Kolkata").format('YYYY-MM-DD') : null;
            result.from_date = result.from_date ? moment.tz(result.from_date, "Asia/Kolkata").format('YYYY-MM-DD') : null;
            result.to_date = result.to_date ? moment.tz(result.to_date, "Asia/Kolkata").format('YYYY-MM-DD') : null;
            result.accepted_from = result.accepted_from ? moment.tz(result.accepted_from, "Asia/Kolkata").format('YYYY-MM-DD') : null;
            result.accepted_to = result.accepted_to ? moment.tz(result.accepted_to, "Asia/Kolkata").format('YYYY-MM-DD') : null;
            result.resolved_date = result.resolved_date ? moment.tz(result.resolved_date, "Asia/Kolkata").format('YYYY-MM-DD') : null;
          });

        console.log("printing the leave Details", results);
       

        return res.status(200).json({
            success: true,
            data : results,
            message: `data fetched successfully`,
          }); 
    } catch(error){
        return res.status(401).json({
            success: false,
            message: `some error in fetching data ${error}`, 
          });
    }
}