const nodemailler = require("nodemailer");

const {AUTH_EMAIL,AUTH_PASS} =process.env;

let transporter = nodemailler.createTransport({
    host: "smtp-mail.outlook.com",
    auth:{
        user: AUTH_EMAIL,
        pass: AUTH_PASS,
    },
});

//Transporter testi

transporter.verify((error,success)=>{
    if(error){
        console.log(error);
    }else{
        console.log("Mesj Atmaya Hazır");
        console.log(success);
    }
});

const sendEmail = async(mailOptions) => {
    try {
        await transporter.sendMail(mailOptions);
        return;
    } catch (error) {
        throw error;
    }
};

module.exports = sendEmail;