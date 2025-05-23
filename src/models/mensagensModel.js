var database = require("../database/config");

function buscarUltimasPostagens() {

    var instrucaoSql = `
    SELECT t.assunto, (count(m.fktopico))
    FROM topico t
    INNER JOIN mensagem m
    ON t.id = m.fktopico
    GROUP BY t.assunto;`
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasPostagens
};
