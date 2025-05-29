create database EcoDrain;
use EcoDrain;

CREATE TABLE logradouro (
	idLogradouro INT NOT NULL ,
    estado CHAR(2) NOT NULL ,
    cidade VARCHAR(25) NOT NULL ,
    PRIMARY KEY (idlogradouro));

CREATE TABLE empresa (
    idEmpresa INT NOT NULL  AUTO_INCREMENT,
    nome VARCHAR(45)   ,
    cnpj CHAR(14)   ,
    email VARCHAR(64)   ,
    num_tel CHAR(11)   ,
    num_cel CHAR(11)   ,
    fklogradouro INT NOT NULL ,
    PRIMARY KEY (idEmpresa),
    CONSTRAINT fk_empresa_logradouro1 FOREIGN KEY (fklogradouro) REFERENCES logradouro (idlogradouro)
  );

CREATE TABLE endereco (
	idEndereco INT NOT NULL AUTO_INCREMENT,
    fkEmpresa INT NOT NULL ,
    cep CHAR(8),
    nome_rua VARCHAR(100),
    bairro VARCHAR(45),
    zonas int NOT NULL check( zonas in(1, 2, 3, 4)),
    PRIMARY KEY (idEndereco),
    CONSTRAINT fk_endereco_empresa1 FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa),
    CONSTRAINT fk_endereco_endereco1 FOREIGN KEY (zonas) REFERENCES endereco (idEndereco)
  );

CREATE TABLE bueiro (
	idBueiro INT NOT NULL AUTO_INCREMENT,
    tamanho DECIMAL(5,2) NOT NULL ,
    fkEndereco INT NOT NULL ,
    PRIMARY KEY (idBueiro),
    INDEX fkEndereco (fkEndereco ASC) VISIBLE,
    CONSTRAINT bueiro_ibfk_1 FOREIGN KEY (fkEndereco) REFERENCES endereco (idEndereco)
  );

CREATE TABLE sensor (
	idSensor INT NOT NULL  AUTO_INCREMENT,
    data_instalacao DATE,
    fkBueiro INT NOT NULL,
    PRIMARY KEY (idSensor),
    CONSTRAINT fk_sensor_bueiro1 FOREIGN KEY (fkBueiro) REFERENCES bueiro (idBueiro)
  );

CREATE TABLE lotacao (
    idLotacao INT NOT NULL  AUTO_INCREMENT,
    fkSensor INT,
    altura_lixo DECIMAL(10,2)   ,
    data_monitoramento TIMESTAMP   ,
    PRIMARY KEY (idLotacao, fkSensor),
	FOREIGN KEY (fkSensor) REFERENCES sensor (idSensor)
  );

CREATE TABLE usuario (
    idUsuario INT NOT NULL  AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    senha VARCHAR(12) NOT NULL,
    email VARCHAR(64) NOT NULL,
    fkEmpresa INT,
    PRIMARY KEY (idUsuario),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
  );

CREATE TABLE alerta (
	idAlerta INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL ,
    alertacol VARCHAR(45) ,
    fkLotacao INT NOT NULL ,
    fkSensor INT,
    PRIMARY KEY (idalerta, fkLotacao, fkSensor),
    CONSTRAINT fk_alerta_lotacao1 FOREIGN KEY (fkLotacao , fkSensor) REFERENCES lotacao (idLotacao , fkSensor)
  );

-- SELECTS PARA A DASHBOARD
-- SELECT DO GRÁFICO DO NÍVEL DO LIXO
SELECT  b.idBueiro, l.altura_lixo, l.data_monitoramento, e.nome_rua
FROM lotacao l
INNER JOIN sensor s ON l.fkSensor = s.idSensor
INNER JOIN bueiro b ON s.fkBueiro = b.idBueiro
INNER JOIN endereco e ON b.fkEndereco = e.idEndereco;

-- DESABILITA A FOREIGN KEY E DÁ UM TRUNCATE NA TABELA
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE lotacao;
SET FOREIGN_KEY_CHECKS = 1;

-- INSERTS PARA TESTE
-- 1. Inserir logradouro
INSERT INTO logradouro (idLogradouro, estado, cidade)
VALUES (1, 'SP', 'São Paulo');

-- 2. Inserir empresa
INSERT INTO empresa (idEmpresa, nome, cnpj, email, num_tel, num_cel, fklogradouro)
VALUES (1, 'Empresa Exemplo', '12345678000199', 'empresa@exemplo.com', '1133445566', '11988887777', 1);

-- 3. Inserir endereco
INSERT INTO endereco (idEndereco, fkEmpresa, cep, nome_rua, bairro, zonas)
VALUES (1, 1, '12345678', 'Rua Exemplo', 'Centro', 1);

-- 4. Inserir bueiro
INSERT INTO bueiro (idBueiro, tamanho, fkEndereco)
VALUES (1, 50.00, 1);

-- 5. Inserir sensor
INSERT INTO sensor (idSensor, data_instalacao, fkBueiro)
VALUES (1, '2024-06-10', 1);

-- 6. Inserir lotacao
INSERT INTO lotacao (idLotacao, fkSensor, altura_lixo, data_monitoramento)
VALUES (1, 1, 30, CURRENT_TIMESTAMP);

-- 7. Inserir alerta vinculado à lotacao e sensor
INSERT INTO alerta (idAlerta, descricao, alertacol, fkLotacao, fkSensor)
VALUES (1, 'Nível de lixo alto', 'vermelho', 1, 1);
-- INSERINDO MAIS DADOS NA TABELA LOTACAO
INSERT INTO lotacao (idLotacao, fkSensor, altura_lixo, data_monitoramento)
VALUES 
(2, 1, 25.75, CURRENT_TIMESTAMP),
(3, 1, 10.25, '2025-05-25 08:30:00'),
(4, 1, 15.50, '2025-05-25 12:00:00'),
(5, 1, 20.75, '2025-05-26 09:15:00'),
(6, 1, 28.00, '2025-05-26 13:45:00'),
(7, 1, 35.25, '2025-05-27 07:00:00'),
(8, 1, 40.00, '2025-05-27 10:30:00'),
(9, 1, 45.75, '2025-05-27 14:00:00'),
(10, 1, 48.50, '2025-05-28 06:45:00');