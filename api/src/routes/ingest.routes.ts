import { putCountryController } from "@controllers/put-country.controllers";
import { Router } from "express";

const ingestRouter = Router();

ingestRouter.put('/country', putCountryController)

export default ingestRouter