var database = require("../database/config");

function buscarNovasMensagens() {

    var instrucaoSql = `
    SELECT 
        DATE_FORMAT(dtCriacao, '%H:00') AS hora,
        COUNT(*) AS total_mensagens
    FROM mensagem m
    GROUP BY hora
    ORDER BY hora;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarNovasMensagens
};
