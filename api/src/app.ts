import express, { application } from "express";
import cors from "cors";
import { json } from "body-parser"
import exampleRouter from "@routes/example.routes";

// Set up the express app
const app = express();
app.use(json());

// open cors to everyone
app.use(cors());

// api version
app.get("/api/version", (_, res) => {
  res.send("0.0.1");
});

// put the example router at path domain/example/...
// try localhost:3000/example/get-example?id=123
app.use("/example", exampleRouter)

export default app;