import { getExampleController } from "@controllers/example.controllers";
import { Router } from "express";

const exampleRouter = Router();
exampleRouter.get('/get-example', getExampleController)

export default exampleRouter