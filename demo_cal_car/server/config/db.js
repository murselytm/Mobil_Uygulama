require("dotenv").config();
const mongoose = require("mongoose");

const {MONGODB_URI} = process.env;

const connectToDB = async () => {
    try {
        await mongoose.connect(MONGODB_URI, {
            useNewUrlParser: true,
            //useUnifedTopology: true, stable cvonnection yoksa hata veriyor illa lüzümü yok
        });
        console.log("DB CONNECTED")
    } catch (error) {
        console.log(error);
    }
};

connectToDB();