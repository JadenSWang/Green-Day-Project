"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var express_1 = __importDefault(require("express"));
var cors_1 = __importDefault(require("cors"));
var body_parser_1 = require("body-parser");
var ingest_routes_1 = __importDefault(require("@routes/ingest.routes"));
// Set up the express app
var app = (0, express_1.default)();
app.use((0, body_parser_1.json)());
// open cors to everyone
app.use((0, cors_1.default)());
// api version
app.get("/api/version", function (_, res) {
    res.send("0.0.1");
});
// put the example router at path domain/example/...
// try localhost:3000/example/get-example?id=123
app.use("/ingest", ingest_routes_1.default);
exports.default = app;
//# sourceMappingURL=app.js.map