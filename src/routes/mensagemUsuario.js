var express = require("express");
var router = express.Router();

var mensagemUsuarioController = require("../controllers/mensagemUsuarioController");

router.get("/ultimas", function (req, res) {
    mensagemUsuarioController.buscarUltimasMensagens(req, res);
});

module.exports = router;