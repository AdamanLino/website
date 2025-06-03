var express = require("express");
var router = express.Router();

var votosController = require("../controllers/enqueteController");

router.get("/ultimos", function (req, res) {
    votosController.buscarUltimosVotos(req, res);
});

router.post("/votar", function (req, res) {
    votosController.votar(req, res);
});
module.exports = router;