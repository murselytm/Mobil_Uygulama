const jwt = require("jsonwebtoken");

const{ TOKEN_KEY} = process.env;

const verifyToken = async(req,res,next) =>{
    const token =
    req.body.token || req.query.token || req.headers["x-access-token"];
    
    //token verildimi diye kontrol etme
    if(!token){
        return res.status(403).send("Authentication Token'i gerekli")
    }

    //Token Doğrulama
    try {
        const decodedToken = await jwt.verify(token,TOKEN_KEY);
        req.currentUser = decodedToken;
    } catch (error) {
        return res.status(401).send("Yanlış Token Yollandı");
    }

    //İstediği gerçekleştirme
    return next();
};

module.exports = verifyToken;
