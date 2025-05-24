var novoModel = require("../models/novasMensagensModel");

function buscarNovasMensagens(req, res) {
    novoModel.buscarNovasMensagens(req)
        .then(resultado => {
            res.status(200).json(resultado);
        })
        .catch(erro => {
            console.error(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    buscarNovasMensagens
}