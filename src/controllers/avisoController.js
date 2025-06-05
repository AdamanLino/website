var avisoModel = require("../models/avisoModel");

function listar(req, res) {
    avisoModel.listar().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os avisos: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function listarPorUsuario(req, res) {
    var idUsuario = req.params.idUsuario;

    avisoModel.listarPorUsuario(idUsuario)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "Houve um erro ao buscar os avisos: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function pesquisarDescricao(req, res) {
    var descricao = req.params.descricao;

    avisoModel.pesquisarDescricao(descricao)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao buscar os avisos: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function publicar(req, res) {
    var titulo = req.body.titulo;
    var descricao = req.body.descricao;
    var idUsuario = req.params.idUsuario;

    if (titulo == undefined) {
        res.status(400).send("O título está indefinido!");
    } else if (descricao == undefined) {
        res.status(400).send("A descrição está indefinido!");
    } else if (idUsuario == undefined) {
        res.status(403).send("O id do usuário está indefinido!");
    } else {
        avisoModel.publicar(titulo, descricao, idUsuario)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            )
            .catch(
                function (erro) {
                    console.log(erro);
                    console.log("Houve um erro ao realizar o post: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function editar(req, res) {
    var novaDescricao = req.body.descricao;
    var idAviso = req.params.idAviso;

    avisoModel.editar(novaDescricao, idAviso)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar o post: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );

}

function deletar(req, res) {
    var idAviso = req.params.idAviso;

    avisoModel.deletar(idAviso)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao deletar o post: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function listarUsuarios(req, res) {
    var situacao = req.query.situacao || 'ativo';

    usuarioModel.listarUsuarios(situacao)
        .then(resultado => {
            if (resultado.length > 0) {
                const membros = [];
                const banidos = [];
                const moderadores = [];

                resultado.forEach(usuario => {
                    if (usuario.situacao === "ativo") {
                        if (usuario.tipo === "membro") {
                            membros.push(usuario.nome);
                        }
                        if (usuario.tipo === "moderador") {
                            moderadores.push(usuario.nome);
                        }
                    } else if (usuario.situacao === "banido") {
                        banidos.push(usuario.nome);
                    }
                });

                res.json({ membros, banidos, moderadores });
            } else {
                res.status(204).send("Nenhum usuário encontrado.");
            }
        })
        .catch(erro => {
            console.log("Erro ao listar usuários: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

function listarPorTopico(req, res) {
    var idTopico = req.params.idTopico;

    avisoModel.listarPorTopico(idTopico)
        .then(resposta => {
            if (resposta.length > 0) {
                res.status(200).json(resposta);
            } else {
                res.status(204).send("Nenhuma mensagem encontrada.");
            }
        })
        .catch(erro => {
            console.error("Erro ao listar mensagens por tópico:", erro.sqlMessage);
            res.status(500).json({ erro: erro.sqlMessage });
        });
}

module.exports = {
    listar,
    listarPorUsuario,
    listarPorTopico,
    pesquisarDescricao,
    publicar,
    editar,
    deletar,
    listarUsuarios
}