var express = require("express");
var router = express.Router();

const respostaController = require("../controllers/respostaController");

router.post("/publicar/:idUsuario", respostaController.publicar);

module.exports = router;