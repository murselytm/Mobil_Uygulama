const OTP =require("./model");
const generateOTP = require("./../../util/generateOTP");
const sendEmail = require("./../../util/sendEmail");
const{hashData, verifyHashedData} = require("./../../util/hashData");
const {AUTH_EMAIL} = process.env;

const verifyOTP = async({email,otp})=> {
    try {
        if(!(email&& otp)){
            throw Error ("Mail için değer sağlayın, otp");
        }

        //otp'nin var olduğuna dair doğrulama
        const matchedOTPRecord = await OTP.findOne({
            email,
        });
        if(!matchedOTPRecord){
            throw Error("Böyle bir otp bulunmamaktadır.");
        }

        const {expiresAt} = matchedOTPRecord;

        // zamanı geçmiş mi diye kontrol
        if(expiresAt <Date.now()){
            await OTP.deleteOne({email});
            throw Error("Kodun ömrü doldu. Lütfen yeni kod talep ediniz");
        }

        //zamanı geçmemişse doğrula
        const hashedOTP = matchedOTPRecord.otp;
        const validOTP = await verifyHashedData(otp,hashedOTP);
        return validOTP;

    } catch (error) {
        throw error;
    }
};

const sendOTP = async({email,subject,message,duration = 1}) => {
    try {
        if(!(email && subject && message)){
            throw Error("Lütfen mail,konu ve mesaj giriniz");
        }

        //Eski kayıtları silme
        await OTP.deleteOne({email});

        //pin üretme
        const generatedOTP = await generateOTP();

        //mail yollama
        const mailOptions = {
            from: AUTH_EMAIL,
            to: email,
            subject,
            html:`<p>${message}</p><p style="color:tomato;font-size:25px;letter-spacing:2px;">
            <b>${generatedOTP}</b>
            </p><p> Bu kod <b> ${duration} saat sonra geçersiz olacaktır </b></p>`,
        };
        await sendEmail(mailOptions);

        //otp kayıtlarını kaydetme
        const hashedOTP = await hashData(generatedOTP);
        const newOTP = await new OTP({
            email,
            otp: hashedOTP,
            createdAt: Date.now(),
            expiresAt: Date.now() + 3600000* +duration,
        });

        const createdOTPRecord = await newOTP.save();
        return createdOTPRecord;

    } catch (error) {
        throw error;
    }
};

const deleteOTP = async(email)=>{
    try {
        await OTP.deleteOne({email});
    } catch (error) {
        throw error;
    }
};

module.exports = {sendOTP,verifyOTP,deleteOTP};