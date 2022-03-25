"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("module-alias/register");
var _app_1 = __importDefault(require("@app"));
var port = process.env.PORT || 3000;
_app_1.default.listen(port);
//# sourceMappingURL=server.js.map