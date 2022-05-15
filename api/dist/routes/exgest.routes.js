"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var get_example_controllers_1 = require("@controllers/get-example.controllers");
var express_1 = require("express");
var exgestRouter = (0, express_1.Router)();
// localhost:3000/exgest/entry/somefieldhere/someotherfieldhere
exgestRouter.get('/entry/:field1/:field2', get_example_controllers_1.getDataExample);
exports.default = exgestRouter;
//# sourceMappingURL=exgest.routes.js.map