var express = require("express");
var router = express.Router();

var novoController2 = require("../controllers/novasMensagensController");

router.get("/novas", function (req, res) {
    novoController2.buscarNovasMensagens(req, res);
});

module.exports = router;