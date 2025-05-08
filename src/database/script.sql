create database sonicfansite;

use sonicfansite;

create table permissao (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    tipo varchar(45),
    constraint chk_tipo check (tipo in ('administrador', 'moderador', 'membro'))
);

insert into permissao (tipo)
values('administrador');

create table usuario (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome varchar(80),
    email varchar(80),
    senha varchar(80),
    dtCriacao datetime,
    fkpermissao INT,
    FOREIGN KEY (fkpermissao) references permissao(id)
);

create table topico (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    email varchar(80),
    assunto varchar(100),
	comentario varchar (280),
    dtCriacao datetime,
    fkusuario INT,
    FOREIGN KEY (fkusuario) references usuario(id)
);

create table mensagem (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    email varchar(80),
    assunto varchar(100),
	comentario varchar (280),
    dtCriacao datetime,
    fktopico INT,
    fkpermissao INT,
    FOREIGN KEY (fktopico) references topico(id)
);

create table quiz (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    pergunta varchar(280),
    personagemFavorito varchar(280),
    jogoFavorito varchar(280),
    fkusuario INT,
    FOREIGN KEY (fkusuario) references usuario(id)
);