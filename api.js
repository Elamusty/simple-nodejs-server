require("dotenv").config();

const express = require("express");
const morgan = require("morgan");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware

app.use((req, res, next) => {
  console.log(
    "Request Received: ",
    new Date().toLocaleString("en-US", {
      timeZone: "Asia/Calcutta",
    })
  );
  next();
});

app.use(morgan("dev"));
app.use(express.json());

//Routes

app.get("/", (req, res) => {
  res.json([
    {
      method: "GET",
      path: "/query",
    },
    {
      method: "POST",
      path: "/body",
    },
    {
      method: "GET",
      path: "/ping",
    },
  ]);
});

app.get("/query", (req, res) => {
  res.send(req.query);
});

app.post("/body", (req, res) => {
  res.json(req.body);
});

app.get("/ping", (req, res) => {
  res.send("pong");
});

//Error Handling

app.use((req, res, next) => {
  const error = new Error("Not Found");
  error.status = 404;
  next(error);
});

//Server Config

var server = app.listen(PORT, () => {
  console.log(`Listening At ${PORT} ...`);
});
