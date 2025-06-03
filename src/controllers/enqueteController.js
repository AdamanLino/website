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

function votar(req, res) {
    console.log("Achei!")
    var id = req.body.id;
    var alternativa =  req.body.respostasSelecionadas;

    if (!id || !alternativa) {
        return res.status(400).json({ erro: "Dados incompletos." });
    }

    mensagemUsuarioModel.salvarVotos(id, alternativa)
        .then(() => {
            res.status(200).json({ mensagem: "Voto registrado com sucesso." });
        })
        .catch(erro => {
            console.error("Erro ao salvar voto:", erro);
            res.status(500).json({ erro: "Erro ao registrar voto." });
        });
}

module.exports = {
    buscarUltimosVotos,
    votar
}