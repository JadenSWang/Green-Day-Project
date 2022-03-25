"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var example_controllers_1 = require("@controllers/example.controllers");
var express_1 = require("express");
var exampleRouter = (0, express_1.Router)();
exampleRouter.get('/get-example', example_controllers_1.getExampleController);
exports.default = exampleRouter;
//# sourceMappingURL=example.routes.js.map