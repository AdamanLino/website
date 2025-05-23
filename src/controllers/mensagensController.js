var mensagensModel = require("../models/mensagensModel");

// function buscarUltimasPostagens(req, res) {

//     var id = req.params.id;
//     console.log(`Recuperando as ultimas medidas`);

//     mensagensModel.buscarUltimasPostagens(id).then(function (resultado) {
//         if (resultado.length > 0) {
//             res.status(200).json(resultado);
//         } else {
//             res.status(204).send("Nenhum resultado encontrado!")
//         }
//     }).catch(function (erro) {
//         console.log(erro);
//         console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
//         res.status(500).json(erro.sqlMessage);
//     });
// }

function buscarUltimasPostagens(req, res) {
    var id = req.params.id;
    mensagensModel.buscarUltimasPostagens(id)
        .then(resultado => {
            res.status(200).json(resultado);
        })
        .catch(erro => {
            console.error(erro);
            res.status(500).json(erro.sqlMessage);
        });
}


module.exports = {
    buscarUltimasPostagens,
}