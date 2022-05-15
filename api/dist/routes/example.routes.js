"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var example_controllers_1 = require("@controllers/example.controllers");
var get_hello_world_controller_1 = require("@controllers/get-hello-world.controller");
var place_information_controller_1 = require("@controllers/place-information.controller");
var express_1 = require("express");
var exampleRouter = (0, express_1.Router)();
exampleRouter.get('/get-example', example_controllers_1.getExampleController);
exampleRouter.get('/get-hello-world', get_hello_world_controller_1.getHelloWorldController);
exampleRouter.put('/place-information', place_information_controller_1.placeInformation);
exports.default = exampleRouter;
//# sourceMappingURL=example.routes.js.map