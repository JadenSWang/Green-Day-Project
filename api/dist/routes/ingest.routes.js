"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var elqb_insert_powerplant_controller_1 = require("@controllers/elqb-insert-powerplant-controller");
var put_country_controllers_1 = require("@controllers/put-country.controllers");
var express_1 = require("express");
var ingestRouter = (0, express_1.Router)();
ingestRouter.put('/country', put_country_controllers_1.putCountryController);
ingestRouter.put('/powerplant', elqb_insert_powerplant_controller_1.putPowerPlantController);
exports.default = ingestRouter;
//# sourceMappingURL=ingest.routes.js.map