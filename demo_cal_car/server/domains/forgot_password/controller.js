const User = require("./../user/model");
const {sendOTP, verifyOTP, deleteOTP} = require("./../otp/controller");
const {hashData} = require("./../../util/hashData");


const resetUserPassword = async ({email,otp,newPassword}) => {
  
    try {
        const validOTP = await verifyOTP({email,otp});
        if(!validOTP){
            throw Error("Yanlış kod. Lüften mailinizi kontrol ediniz.")

        }

        //yeni şifre ile kullanıcı kaydını güncelle

        if(newPassword.lenght < 8){
            throw Error("Şifre en az  8 karakterli olmalı");
        }
        const hashedNewPassword = await hashData(newPassword);
        await User.updateOne({email},{password:hashedNewPassword});
        await deleteOTP(email);
    } catch (error) {
        throw error;
    }
};

const sendPasswordResetOTPEmail = async (email) =>{
    try {
        // kullanıcı var mı diye kontol etme
        const existingUser = await User.findOne({email});
        if(!existingUser){
            throw Error("Bu maile kayıtlı hesap bulunmamaktadır");       
        }

        if(!existingUser.verified){
            throw Error("Mail onaylanmadı.Lütfen gelen kutsunu kontol ediniz");

        }

        const otpDetails = {
            email,
            subject: "Şifre Resetleme",
            message: "Şifreyi resetlemek için alttaki kodu giriniz.",
            duration:1,
        };

        const createdOTP = await sendOTP(otpDetails);
        return createdOTP;

    } catch (error) {
        throw error;
    }
}

module.exports = {sendPasswordResetOTPEmail,resetUserPassword};