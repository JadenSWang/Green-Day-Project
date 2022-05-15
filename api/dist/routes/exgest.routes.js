"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var get_example_controllers_1 = require("@controllers/get-example.controllers");
var express_1 = require("express");
var ingestRouter = (0, express_1.Router)();
ingestRouter.get('/entry', get_example_controllers_1.getDataExample);
exports.default = ingestRouter;
//# sourceMappingURL=exgest.routes.js.map