// import{createRequire} from 'module';
// const require = createRequire(import.meta.url);
const  app = require("./app");
const { PORT } = process.env;

const starApp = () => {
    app.listen(PORT, () => {
        console.log(`Auth Backend Runing on port ${PORT}`)
    });
};

starApp();