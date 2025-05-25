var mensagemUsuarioModel = require("../models/enqueteModel");

function buscarUltimosVotos(req, res) {
    mensagemUsuarioModel.buscarUltimosVotos(req)
        .then(resultado => {
            res.status(200).json(resultado);
        })
        .catch(erro => {
            console.error(erro);
            res.status(500).json(erro.sqlMessage);
        });
}


module.exports = {
    buscarUltimosVotos
}