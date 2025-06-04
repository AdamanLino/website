var database = require("../database/config");

function buscarUltimosVotos() {
    var instrucaoSql = `
    SELECT 
        e.id AS enquete_id,
        e.pergunta AS pergunta,
        a.texto AS alternativa,
        COUNT(ue.fkusuario) AS total_votos
    FROM enquete e
    LEFT JOIN alternativa a ON e.id = a.fkenquete
    LEFT JOIN usuarioEnquete ue ON a.id = ue.fkalternativa
    WHERE 
    e.id = 1
        GROUP BY 
    e.id, e.pergunta, a.id, a.texto;
    `

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function salvarVotos(idUsuario, idAlternativa) {
    console.log(idAlternativa);

    var instrucaoSql = `
    INSERT INTO usuarioEnquete (fkusuario, fkalternativa)
    VALUES (${idUsuario}, ${idAlternativa});
    `;
    return database.executar(instrucaoSql, [idUsuario, idAlternativa]);

}

module.exports = {
    buscarUltimosVotos,
    salvarVotos
};
