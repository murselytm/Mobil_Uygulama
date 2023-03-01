require("./config/db");

const express = require("express");
const bodyParser = require("body-parser")
const cors = require("cors");
const routes = require("./routes");

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());
app.use(cors());
app.use("/api/v1",routes);

module.exports = app;