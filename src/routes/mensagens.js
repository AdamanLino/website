var express = require("express");
var router = express.Router();

var mensagensController = require("../controllers/mensagensController");

router.get("/ultimas", function (res) {
    mensagensController.buscarUltimasPostagens(res);
});

module.exports = router;