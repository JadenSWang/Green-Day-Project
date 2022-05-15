import { getDataExample } from "@controllers/get-example.controllers";
import { Router } from "express";

const ingestRouter = Router();

ingestRouter.get('/entry', getDataExample)

export default ingestRouter