var mensagemUsuarioModel = require("../models/mensagemUsuarioModel");

function buscarUltimasMensagens(req, res) {
    mensagemUsuarioModel.buscarUltimasMensagens(req)
        .then(resultado => {
            res.status(200).json(resultado);
        })
        .catch(erro => {
            console.error(erro);
            res.status(500).json(erro.sqlMessage);
        });
}


module.exports = {
    buscarUltimasMensagens
}