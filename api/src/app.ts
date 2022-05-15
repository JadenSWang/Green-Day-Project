import express, { application } from "express";
import cors from "cors";
import { json } from "body-parser"
import ingestRouter from "@routes/ingest.routes";
import exgestRouter from "@routes/exgest.routes"
import logger from "morgan"

// Set up the express app
const app = express();
app.use(json());
app.use(cors());
app.use(logger('dev'))

// api version
app.get('/api/versions', (req, res) => {
  res.send("SDF")
})
app.get("/api/version", (_, res) => {
  res.send("0.0.2");
});

app.use("/ingest", ingestRouter)
app.use('/exgest', exgestRouter)

export default app;