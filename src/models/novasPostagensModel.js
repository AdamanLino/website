var database = require("../database/config");

function buscarNovasPostagens() {

    var instrucaoSql = `
    SELECT 
        DATE_FORMAT(dtCriacao, '%H:00') AS hora,
        COUNT(*) AS total_posts
    FROM topico
    GROUP BY hora
    ORDER BY hora;
;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarNovasPostagens
};
