const User = require("./../user/model");
const {sendOTP,verifyOTP, deleteOTP} = require("./../otp/controller");

const verifyUserEmail = async({email, otp})=>{
    try {
        const validOTP = await verifyOTP({email,otp});

        if(!validOTP){
            throw Error("Yanlış kod. Lütfen Mailinizi tekrar kontrl ediniz");

        }
        // kullanıcı hesabını güncelleyip doğrulandığını onaylama
        await User.updateOne({email},{verified:true});
        
        await deleteOTP(email);
        return;
    } catch (error) {
        throw error;
    }
};

const sendVerificationOTPEmail = async (email) =>{
    try {
        //böyle bir kullanıcı kayıtlı mı
        const existingUser = await User.findOne({email});
        if(!existingUser){
            throw Error("Bu maile kayıtlı bir hesap bulunmamaktadır");

        }

        const otpDetails = {
            email,
            subject: "Mail Doğrulama",
            message: "Maili aşşağıda bulunan kod ile doğrulayın.",
            duration: 1,
        };
        const createdOTP = await sendOTP(otpDetails);
        return createdOTP;
    } catch (error) {
        throw error;        
    }
}

module.exports = {sendVerificationOTPEmail, verifyUserEmail};