var database = require("../database/config");

function buscarUltimasMensagens() {

    var instrucaoSql = `
    SELECT u.nome,
	    count(m.comentario) as total_comentarios
    from usuario u
    inner join mensagem m on u.id = m.fkusuario
    group by u.nome
    order by total_comentarios desc;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMensagens
};
