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
    situacao ENUM('ativo', 'banido') NOT NULL DEFAULT 'ativo',
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


-- para banir um usuário diretamente do BD
update usuario set situacao = 'banido' where id = 4;

select * from enquete;
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
HAVING total_mensagens <= 5;

-- gráfico de total de mensagens por usuário
SELECT u.nome,
	count(m.comentario) as total_comentarios
from usuario u
inner join mensagem m on u.id = m.fkusuario
group by u.nome
order by total_comentarios desc;

-- grafico de novas postagens
SELECT t.assunto,
    DATE_FORMAT(dtCriacao, '%H:00') AS hora,
    COUNT(*) AS total_posts
FROM topico t
GROUP BY hora;

-- gráfico de novas mensagens
SELECT m.comentario,
    DATE_FORMAT(dtCriacao, '%H:00') AS hora,
    COUNT(*) AS total_mensagens
FROM mensagem m
GROUP BY hora;

-- gráfico do total de votos na enquete
SELECT a.texto,
	COUNT(ue.fkusuario) AS total_votos
FROM alternativa a
LEFT JOIN usuarioEnquete ue ON a.id = ue.fkalternativa
WHERE a.fkenquete = 2
GROUP BY a.id, a.texto;

select * from usuario;
SELECT 
    e.id AS enquete_id,
    e.pergunta AS pergunta,
    a.texto AS alternativa,
    COUNT(ue.fkusuario) AS total_votos
FROM 
    enquete e
LEFT JOIN 
    alternativa a ON e.id = a.fkenquete
LEFT JOIN 
    usuarioEnquete ue ON a.id = ue.fkalternativa
WHERE 
    e.id = 1
GROUP BY 
    e.id, e.pergunta, a.id, a.texto;

-- TESTES
-- Votos dos usuários na enquete 2
INSERT INTO usuarioEnquete (fkusuario, fkalternativa) VALUES
(1, 5), -- admin vota em Sonic
(2, 6), -- TailsFan vota em Tails
(3, 7), -- Gabriel vota em Knuckles
(4, 5), -- Ana vota em Sonic
(5, 8), -- Rafael vota em Shadow
(6, 5); -- SonicN1Fan vota em Sonic

-- Inserções de mensagens em horários diferentes para popular o gráfico
INSERT INTO mensagem (comentario, dtCriacao, fktopico, fkusuario) VALUES
('Concordo com tudo que foi dito!', STR_TO_DATE('2025-05-24 08:10:00', '%Y-%m-%d %H:%i:%s'), 1, 2),
('Realmente, o design dessa fase é impecável.', STR_TO_DATE('2025-05-24 08:45:00', '%Y-%m-%d %H:%i:%s'), 1, 3),
('Nunca tinha pensado por esse lado.', STR_TO_DATE('2025-05-24 09:15:00', '%Y-%m-%d %H:%i:%s'), 2, 4),
('Alguém já jogou Sonic Battle?', STR_TO_DATE('2025-05-24 10:30:00', '%Y-%m-%d %H:%i:%s'), 3, 5),
('Sim! E é muito bom!', STR_TO_DATE('2025-05-24 10:55:00', '%Y-%m-%d %H:%i:%s'), 3, 1),
('Vale a pena usar escudo elemental?', STR_TO_DATE('2025-05-24 11:20:00', '%Y-%m-%d %H:%i:%s'), 2, 6),
('Minha fase favorita é a Stardust Speedway!', STR_TO_DATE('2025-05-24 12:05:00', '%Y-%m-%d %H:%i:%s'), 1, 3),
('O final do Sonic Adventure é emocionante!', STR_TO_DATE('2025-05-24 13:45:00', '%Y-%m-%d %H:%i:%s'), 2, 4),
('Hyper Sonic deveria voltar!', STR_TO_DATE('2025-05-24 14:15:00', '%Y-%m-%d %H:%i:%s'), 3, 2);

-- Inserções manuais com horários diferentes
INSERT INTO topico (assunto, comentario, dtCriacao, fkusuario)
VALUES 
('Melhor jogo 2D do Sonic?', 'Sonic CD é muito estiloso.', STR_TO_DATE('2025-05-24 08:15:00', '%Y-%m-%d %H:%i:%s'), 3),
('Vale a pena jogar Sonic Forces?', 'Achei divertido, mas meio fácil.', STR_TO_DATE('2025-05-24 09:30:00', '%Y-%m-%d %H:%i:%s'), 4),
('OST favorita?', 'A trilha sonora do Sonic Rush é absurda!', STR_TO_DATE('2025-05-24 10:45:00', '%Y-%m-%d %H:%i:%s'), 5),
('Sonic Generations ou Unleashed?', 'Ambos são ótimos, mas prefiro Generations.', STR_TO_DATE('2025-05-24 10:55:00', '%Y-%m-%d %H:%i:%s'), 2),
('Curiosidades sobre o Knuckles', 'Sabia que ele foi criado como rival?', STR_TO_DATE('2025-05-24 12:05:00', '%Y-%m-%d %H:%i:%s'), 3),
('Melhor vilão?', 'O Metal Sonic é o mais icônico.', STR_TO_DATE('2025-05-24 13:20:00', '%Y-%m-%d %H:%i:%s'), 6),
('Sonic Frontiers é bom?', 'Gameplay diferente, mas muito bom!', STR_TO_DATE('2025-05-24 13:50:00', '%Y-%m-%d %H:%i:%s'), 1),
('Preferem jogos 2D ou 3D?', 'Sinto que o 2D tem mais charme!', STR_TO_DATE('2025-05-24 14:00:00', '%Y-%m-%d %H:%i:%s'), 4);
/*
select * from topico;
select * from mensagem;
insert into topico(assunto, comentario, fkusuario)
	values ('Assuntos variados', 'Comentario top', 4);

select * from usuario;
insert into mensagem (comentario, dtCriacao, fktopico, fkusuario) 
	values('TESTE DE RESPOSTA', now(), 4, 5);