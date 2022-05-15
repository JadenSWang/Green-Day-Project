"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var put_country_controllers_1 = require("@controllers/put-country.controllers");
var express_1 = require("express");
var ingestRouter = (0, express_1.Router)();
ingestRouter.put('/country', put_country_controllers_1.putCountryController);
exports.default = ingestRouter;
//# sourceMappingURL=ingest.routes.js.map