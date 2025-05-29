var database = require("../database/config");

function publicar(comentario, fktopico, fkusuario, email) {
    var instrucaoSql = `
        INSERT INTO mensagem (comentario, dtCriacao, fktopico, fkusuario, email)
            VALUES ('${comentario}', now(), ${fktopico}, ${fkusuario}, '${email}');`;
    return database.executar(instrucaoSql);
}

module.exports = {
    publicar
};