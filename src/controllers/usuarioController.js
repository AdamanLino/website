var usuarioModel = require("../models/usuarioModel");
// var aquarioModel = require("../models/aquarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {
        usuarioModel.autenticar(email, senha)
            .then(function (resultadoAutenticar) {
                if (resultadoAutenticar.length == 1) {
                    res.json({
                        id: resultadoAutenticar[0].id,
                        email: resultadoAutenticar[0].email,
                        nome: resultadoAutenticar[0].nome,
                        fkpermissao: resultadoAutenticar[0].fkpermissao
                    });
                } else {
                    res.status(403).send("Email e/ou senha inválido(s)");
                }
            }).catch(function (erro) {
                res.status(500).json(erro.sqlMessage);
            });
    }
}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, email, senha)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function listarUsuarios(req, res) {
    usuarioModel.listarUsuarios()
        .then(resultado => {
            res.status(200).json(resultado);
        }).catch(erro => {
            res.status(500).json(erro.sqlMessage);
        });
}

function listarKpi(req, res) {
    usuarioModel.listarUsuarios()
        .then(resultado => {
            const membros = [];
            const moderadores = [];

            resultado.forEach(usuario => {
                if (usuario.tipo == 'moderador') {
                    moderadores.push(usuario.nome);
                } else if (usuario.situacao !== 'banido') {
                    membros.push(usuario.nome);
                }
            });
            res.json({
                membros,
                moderadores
            });
        })
        .catch(erro => {
            console.error(erro);
            res.status(500).json({ erro: erro.sqlMessage });
        });
}
module.exports = {
    autenticar,
    cadastrar,
    listarKpi,
    listarUsuarios
}