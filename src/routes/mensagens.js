var express = require("express");
var router = express.Router();

var mensagensController = require("../controllers/mensagensController");

router.get("/ultimas", function (req, res) {
    mensagensController.buscarUltimasPostagens(req, res);
});

module.exports = router;