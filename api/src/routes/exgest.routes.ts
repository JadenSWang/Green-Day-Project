import { getDataExample } from "@controllers/get-example.controllers";
import { Router } from "express";

const exgestRouter = Router();

// localhost:3000/exgest/entry/somefieldhere/someotherfieldhere
exgestRouter.get('/entry/:field1/:field2', getDataExample)

export default exgestRouter