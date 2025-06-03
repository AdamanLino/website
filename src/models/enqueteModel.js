var database = require("../database/config");

function buscarUltimosVotos() {
    var instrucaoSql = `
    SELECT e.pergunta, a.texto,
	    COUNT(ue.fkusuario) AS total_votos
    FROM alternativa a
    INNER JOIN enquete e ON a.fkenquete = e.id
    LEFT JOIN usuarioEnquete ue ON a.id = ue.fkalternativa
    WHERE a.fkenquete = 2
    GROUP BY a.id, a.texto;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function salvarVotos(idUsuario, idAlternativa) {
    console.log(idAlternativa);

    var instrucaoSql = `
    INSERT INTO usuarioEnquete (fkusuario, fkalternativa)
    VALUES (${idUsuario}, ${idAlternativa[0]}),
    (${idUsuario}, ${idAlternativa[1]}),
    (${idUsuario}, ${idAlternativa[2]});
    `;
    return database.executar(instrucaoSql, [idUsuario, idAlternativa]);

}

module.exports = {
    buscarUltimosVotos,
    salvarVotos
};
