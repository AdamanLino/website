var novoModel = require("../models/novasPostagensModel");

function buscarNovasPostagens(req, res) {
    novoModel.buscarNovasPostagens(req)
        .then(resultado => {
            res.status(200).json(resultado);
        })
        .catch(erro => {
            console.error(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    buscarNovasPostagens
}