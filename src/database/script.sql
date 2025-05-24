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
    assunto varchar(100) NOT NULL,
	comentario varchar (280) NOT NULL,
    dtCriacao datetime not null default(now()),
    fkusuario INT NOT NULL,
    FOREIGN KEY (fkusuario) references usuario(id)
);
    
create table mensagem (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    email varchar(80),
	comentario varchar (280) NOT NULL,
    dtCriacao datetime not null default(now()),
    fktopico INT NOT NULL,
    fkusuario INT NOT NULL,
    FOREIGN KEY (fktopico) references topico(id),
    FOREIGN KEY (fkusuario) references usuario(id)
);

create table enquete (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    pergunta varchar(280) NOT NULL,
    dtCriacao datetime not null default(now())
);

create table alternativa (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  texto varchar(280),
  fkenquete int,
  foreign key (fkenquete) references enquete(id)
);

create table usuarioEnquete (
	fkusuario int NOT NULL,
    fkalternativa int NOT NULL,
    primary key(fkusuario, fkalternativa),
    foreign key (fkusuario) references usuario(id),
    foreign key (fkalternativa) references alternativa(id),
    unique (fkusuario, fkalternativa) -- somente um usuario pode votar na enquete
);

-- inserts
insert into usuario (nome, email, senha, dtCriacao, fkpermissao) 
	values('admin', 'admin@admin.com', 'admin', now(), 1), -- administrador
		  ('TailsFan', 'tailsfan@outlook.com', 'senhaMariana123', now(), 2), -- moderador
		  ('Gabriel Echidna', 'gabriel@gmail.com', 'senhaGabrie123', now(), 3), -- membro
		  ('Ana Rose', 'ana@protonmail.me', 'senhaAna123', now(), 3), -- membro
		  ('Rafael ShadowX', 'rafael@gmail.com', 'senhaRafael23', now(), 3), -- membro
          ('SonicN1Fan', 'sonic@gmail.com', '123', now(), 3); -- membro

insert into topico (assunto, comentario, dtCriacao, fkusuario) 
	values ('Melhor fase do Sonic?', 'Na minha opinião, Green Hill Zone é a melhor fase até hoje!', now(), 1),
		   ('Como derrotar o Dr. Eggman?', 'Alguém tem dicas de estratégias contra o Eggman no Sonic Adventure?', now(), 2),
		   ('Super Sonic ou Hyper Sonic?', 'Qual a melhor forma do Sonic e por quê?', now(), 4);

insert into mensagem (comentario, dtCriacao, fktopico, fkusuario) 
	values('Concordo! A melhor fase do Sonic até hoje é a Green Hill Zone ela é lendária!', now(), 1, 2),
		  ('Use o homing attack na hora certa e desvie rápido dos mísseis.', now(), 2, 3),
		  ('Eu prefiro o Hyper Sonic, mas ele não é canônico e só aparece no Sonic 3 & Knuckles.', now(), 3, 5),
		  ('Super Sonic é mais clássico e fácil de conseguir.', now(), 3, 1);

insert into enquete (pergunta) 
	values ('Qual a sua fase favorita do Sonic?'),
		   ('Qual seu personagem preferido da franquia Sonic?'),
		   ('Qual a sua super forma do Sonic favorita?');

insert into alternativa (texto, fkenquete) 
	values ('Green Hill Zone', 1),
		   ('Chemical Plant Zone', 1),
		   ('Sky Sanctuary', 1),
		   ('Stardust Speedway', 1);

insert into alternativa (texto, fkenquete) 
	values ('Sonic', 2),
		   ('Tails', 2),
		   ('Knuckles', 2),
		   ('Shadow', 2),
		   ('Amy', 2),
		   ('Dr. Eggman', 2);

insert into alternativa (texto, fkenquete) 
	values ('Super Sonic', 3),
		   ('Hyper Sonic', 3),
		   ('Werehog', 3);

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

-- selects da dashboard
-- gráfico de total de postagens por tópico
SELECT t.assunto, count(m.comentario) AS total_mensagens
FROM topico t
LEFT JOIN mensagem m ON t.id = m.fktopico
GROUP BY t.id, t.assunto
having total_mensagens <= 5;

-- gráfico de total de mensagens por usuário
SELECT u.nome,
	count(m.comentario) as total_comentarios
from usuario u
inner join mensagem m on u.id = m.fkusuario
group by u.nome
order by total_comentarios desc;

-- grafico de novas postagens
select t.assunto, t.dtCriacao
from topico t;

-- TESTES
/*
select * from topico;
select * from mensagem;
insert into topico(assunto, comentario, fkusuario)
	values ('Assuntos variados', 'Comentario top', 4);

select * from usuario;
insert into mensagem (comentario, dtCriacao, fktopico, fkusuario) 
	values('TESTE DE RESPOSTA', now(), 4, 5);