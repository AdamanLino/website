var database = require("../database/config");

function buscarUltimasPostagens() {

    var instrucaoSql = `
    SELECT t.assunto, count(m.comentario) AS total_mensagens
    FROM topico t
    LEFT JOIN mensagem m ON t.id = m.fktopico
    GROUP BY t.id, t.assunto
    HAVING total_mensagens <= 5;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasPostagens
};
