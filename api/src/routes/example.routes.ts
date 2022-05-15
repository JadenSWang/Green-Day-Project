import { getExampleController } from "@controllers/example.controllers";
import { getHelloWorldController } from "@controllers/get-hello-world.controller"; 
import { placeInformation } from "@controllers/place-information.controller";
import { Router } from "express";

const exampleRouter = Router();

exampleRouter.get('/get-example', getExampleController)
exampleRouter.get('/get-hello-world', getHelloWorldController)
exampleRouter.put('/place-information', placeInformation)

export default exampleRouter