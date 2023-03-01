const User = require("./model");
const { hashData, verifyHashedData} = require("./../../util/hashData");
const createToken = require("./../../util/createToken");

const authenticateUser = async (data) => {
    try {

        const { email, password} = data;

        const fetchedUser = await User.findOne({
            email
        });

        if(!fetchedUser){
            throw Error("Böyle bir mail bulunmamakta");
        }
        if(!fetchedUser.verified){
            throw Error("Mail daha doğrulanamabı. Lütfen gelen kutusun kontrol ediniz");
            
        }

        const hashedPassword = fetchedUser.password;
        const passwordMatch = await verifyHashedData(password,hashedPassword);

        if(!passwordMatch){
            throw Error ("Yanlış Şifre girildi!");
        }

        //user token oluşturma
        const tokenData = {userId: fetchedUser._id, email};
        const token = await createToken(tokenData);

        //kullanıcı token atama
        fetchedUser.token = token;
        return fetchedUser;
        
    } catch (error) {
        throw error;
    }
};

const createNewUser = async (data) => {
    try{
        const { name,email,password} = data;

        const existingUser = await User.findOne({ email});

        if (existingUser){
            throw Error("Bu mail halizırda kulllanılmaktadır");
        }
        const hashedPassword = await hashData(password);
        const newUser = new User({
            name,
            email,
            password: hashedPassword,
        });
        const createdUser = await newUser.save();
        return createdUser;
    } catch (error){
        throw error;
    }
};

module.exports = {createNewUser, authenticateUser}