const express = require("express");
const router = express.Router();
const { createNewUser, authenticateUser } = require("./controller");
const auth = require("./../../middleware/auth");
const {sendVerificationOTPEmail} = require("./../email_verification/controller");


//güvenli route
router.get("/private_data",auth,(req,res) => {
    res.status(200).send(`Bu maile sahip kullanıcının özel alındasın : ${req.currentUser.email}`)
})


//Giriş yapma
router.post("/", async (req,res) => {
    try {
        console.log(req.body);
        let{email,password} =req.body;
        email = email?.trim();
        password = password?.trim();

        if(!(email && password)){
            throw Error("Mail veya Şifre girilmedi! ")
        }

        const authenticatedUser = await authenticateUser ({email,password});

        res.status(200).json(authenticatedUser);

    } catch (error) {
        res.status(400).send(error.message);
    }
});


//Kayıt Olma
router.post("/signup",async (req,res) =>{
    try{
        let {name, email, password} = req.body;
        name = name?.trim();
        email = email?.trim();
        password = password?.trim();

        if (!name) {
            throw Error("Isim girilmedi");
        } else if (!email) {
            throw Error("Email girilmedi");
        } else if (!password) {
            throw Error("Şifre girilmedi");
        }else if (!/^[a-zA-Z]*$/.test(name)){
            throw Error("Yanlış isim girildi");
        }else if (!/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email)){
            throw Error("Mail yanlış girildi");
        } else if (password.length < 8) {
            throw Error("Şifre en az 8 karakterli olmalıdır")
        }else {
            const newUser = await createNewUser({
                name,
                email,
                password,
            });
            await sendVerificationOTPEmail(email);
            res.status(200).json(newUser);
        }
        console.log(2);
    } catch(error){
        console.log(error);
        res.status(400).send(error.message);
    }
});

module.exports = router;