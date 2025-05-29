var mensagensModel = require("../models/respostaModel");

function publicar(req, res) {
    var comentario = req.body.comentario;
    var fktopico = req.body.fktopico;
    var email = req.body.email;
    var fkusuario = req.params.idUsuario;
    
    if (!comentario || !fktopico || !fkusuario) {
        res.status(400).send("Campos obrigatórios não informados");
        return;
    }

    mensagensModel.publicar(comentario, fktopico, fkusuario, email)
        .then(resultado => res.status(200).json(resultado))
        .catch(erro => res.status(500).json(erro));
}

module.exports = {
    publicar
}