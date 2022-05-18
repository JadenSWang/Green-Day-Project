"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var express_1 = __importDefault(require("express"));
var cors_1 = __importDefault(require("cors"));
var body_parser_1 = require("body-parser");
var ingest_routes_1 = __importDefault(require("@routes/ingest.routes"));
var exgest_routes_1 = __importDefault(require("@routes/exgest.routes"));
var morgan_1 = __importDefault(require("morgan"));
// Set up the express app
var app = (0, express_1.default)();
app.use((0, body_parser_1.json)());
app.use((0, cors_1.default)());
app.use((0, morgan_1.default)('dev'));
// api version
app.get('/api/versions', function (req, res) {
    res.send("SDF");
});
app.get("/api/version", function (_, res) {
    res.send("0.0.2");
});
app.use("/ingest", ingest_routes_1.default);
app.use('/exgest', exgest_routes_1.default);
exports.default = app;
//# sourceMappingURL=app.js.map