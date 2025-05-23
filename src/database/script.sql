-- criação da database
create database sonicfansite;
use sonicfansite;

-- criação das tabelas
create table permissao (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    tipo varchar(45) NOT NULL,
    constraint chk_tipo check (tipo in ('administrador', 'moderador', 'membro'))
);

-- insere as permissões na tabela
insert into permissao (tipo) 
	values('administrador'),
	      ('moderador'),
		  ('membro');

create table usuario (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome varchar(80) NOT NULL,
    email varchar(80) NOT NULL,
    senha varchar(80) NOT NULL,
    dtCriacao datetime NOT NULL DEFAULT(now()),
    fkpermissao INT NOT NULL DEFAULT 3,
    FOREIGN KEY (fkpermissao) references permissao(id)
);

create table topico (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    email varchar(80),
    assunto varchar(100),
	comentario varchar (280),
    dtCriacao datetime not null default(now()),
    fkusuario INT NOT NULL,
    FOREIGN KEY (fkusuario) references usuario(id)
);

select * from topico;
select * from sonicfansite.usuario;
select * from sonicfansite.topico;
create table mensagem (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    email varchar(80),
    assunto varchar(100),
	comentario varchar (280),
    dtCriacao datetime,
    fktopico INT NOT NULL,
    fkusuario INT NOT NULL,
    FOREIGN KEY (fktopico) references topico(id),
    FOREIGN KEY (fkusuario) references usuario(id)
);

create table enquete (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    pergunta varchar(280),
    alternativas varchar(280),
    dtCriacao datetime,
    fkusuario INT NOT NULL,
    FOREIGN KEY (fkusuario) references usuario(id)
);

-- inserts
insert into usuario (nome, email, senha, dtCriacao, fkpermissao) 
	values('admin', 'admin@admin.com', 'admin', now(), 1), -- administrador
		  ('TailsFan', 'tailsfan@outlook.com', 'senhaMariana123', now(), 2), -- moderador
		  ('Gabriel Echidna', 'gabriel@gmail.com', 'senhaGabrie123', now(), 3), -- membro
		  ('Ana Rose', 'ana@protonmail.me', 'senhaAna123', now(), 3), -- membro
		  ('Rafael ShadowX', 'rafael@gmail.com', 'senhaRafael23', now(), 3); -- membro

insert into topico (assunto, comentario, dtCriacao, fkusuario) 
	values ('Melhor fase do Sonic?', 'Na minha opinião, Green Hill Zone é a melhor fase até hoje!', now(), 1),
		   ('Como derrotar o Dr. Eggman?', 'Alguém tem dicas de estratégias contra o Eggman no Sonic Adventure?', now(), 2),
		   ('Super Sonic ou Hyper Sonic?', 'Qual a melhor forma do Sonic e por quê?', now(), 4);

insert into mensagem (comentario, dtCriacao, fktopico, fkusuario) 
	values('Concordo! A melhor fase do Sonic até hoje é a Green Hill Zone ela é lendária!', now(), 1, 2),
		  ('Use o homing attack na hora certa e desvie rápido dos mísseis.', now(), 2, 3),
		  ('Eu prefiro o Hyper Sonic, mas ele não é canônico e só aparece no Sonic 3 & Knuckles.', now(), 3, 5),
		  ('Super Sonic é mais clássico e fácil de conseguir.', now(), 3, 1);

insert into enquete (pergunta, alternativas, dtCriacao, fkusuario) 
	values('Qual a sua fase favorita do Sonic?', 'Green Hill Zone; Chemical Plant Zone; Sky Sanctuary; Stardust Speedway', now(), 1),
		  ('Qual seu personagem preferido da franquia Sonic?', 'Sonic; Tails; Knuckles; Shadow; Amy; Dr. Eggman', now(), 2),
		  ('Qual a sua super forma do Sonic favorita?', 'Super Sonic; Hyper Sonic; Werehog', now(), 3);

-- selects
-- mostra os dados dos usuários e seus cargos
select * 
from usuario usu
inner join permissao per
on per.id = usu.fkpermissao;

-- mostra os tópicos e seus respectivos criadores
select top.assunto Assunto, usu.nome as 'Postador Original'
from topico top
inner join usuario usu
on usu.id = top.fkusuario;

-- mostra os tópicos e suas menssagems
select top.assunto, top.comentario, men.comentario
from topico top
inner join mensagem men
on top.id = men.fktopico;

-- mostra as enquetes
select * from enquete;