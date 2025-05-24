var express = require("express");
var router = express.Router();

var novoController = require("../controllers/novasPostagensController");

router.get("/novas", function (req, res) {
    novoController.buscarNovasPostagens(req, res);
});

module.exports = router;
