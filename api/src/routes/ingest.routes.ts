import { putPowerPlantController } from "@controllers/elqb-insert-powerplant-controller";
import { putCountryController } from "@controllers/put-country.controllers";
import { Router } from "express";

const ingestRouter = Router();

ingestRouter.put('/country', putCountryController)
ingestRouter.put('/powerplant', putPowerPlantController)

export default ingestRouter