/* Script de criacao do ifmobile */
/* Alunos: */
-- Yohanna de Oliveira Cavalcanti - 20191370003 
-- Ana Júlia Oliveira Lins - 20191370002
-- Gabriel Xavier Silva - 20191370025

-- Criação do DB (Faça essa parte primeiro)

CREATE DATABASE ifmobile
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;



-- Criação das Tabelas

CREATE TABLE estado
(
  uf       char(2)          NOT NULL,
  nome     varchar(40)      NOT NULL,
  ddd   int                  NOT NULL,
  CONSTRAINT PK_uf          PRIMARY KEY (uf),
  CONSTRAINT AK_estado_ddd UNIQUE (ddd),
  CONSTRAINT CK_estado_uf   CHECK (LENGTH(uf)=2)
);

CREATE TABLE cidade 
(
  idCidade SERIAL             NOT NULL,
  nome     varchar(50)      NOT NULL,
  uf       char(2)         NOT NULL,
  CONSTRAINT PK_cidade      PRIMARY KEY (idCidade),
  CONSTRAINT CK_cidade_uf   CHECK (LENGTH(uf)=2),
  CONSTRAINT FK_cidade_uf FOREIGN KEY (uf) REFERENCES estado(uf)
);

CREATE TABLE cliente
(
  idCliente SERIAL                NOT NULL,
  nome      varchar(50)        NOT NULL,
  endereco  varchar(60)        NOT NULL,
  bairro  varchar(30)             NOT NULL,
  idCidade  int                NOT NULL,
  dataCadastro date             NOT NULL,
  cancelado char(1)        DEFAULT('N')     NOT NULL, 
  CONSTRAINT PK_cliente        PRIMARY KEY (idCliente),
  CONSTRAINT FK_cliente_cidade FOREIGN KEY (idCidade) REFERENCES cidade(idCidade),
  CONSTRAINT CK_cliente_cancelado  CHECK (cancelado = 'S' OR cancelado = 'N' )
);


CREATE TABLE cobertura
(
 uf     char(2)     NOT NULL,
 ddd    int         NOT NULL,
 CONSTRAINT PK_uf_cobertura   PRIMARY KEY (uf),
 CONSTRAINT AK_cobertura_ddd UNIQUE (ddd),
 CONSTRAINT FK_cobertura_uf FOREIGN KEY (uf) REFERENCES estado(uf)
);

CREATE TABLE tarifa
(
  idTarifa    SERIAL           NOT NULL,
  descricao     varchar(50)   NOT NULL,
  valor decimal   DEFAULT(0)  NOT NULL,
  CONSTRAINT PK_tarifa PRIMARY KEY (idTarifa)
);


CREATE TABLE plano
(
  idPlano SERIAL         NOT NULL,
  descricao     varchar(50)        NOT NULL,
  fminIn  int      DEFAULT (0)      NOT NULL,
  fminOut  int      DEFAULT (0)      NOT NULL,
  addLigacao int                   NOT NULL,
  roaming int   NOT NULL,
  valor decimal NOT NULL,
  CONSTRAINT PK_plano     PRIMARY KEY (idPlano),
  CONSTRAINT FK_plano_tarifa FOREIGN KEY (addLigacao) REFERENCES tarifa(idTarifa),
  CONSTRAINT FK_plano_tarifa2 FOREIGN KEY (roaming) REFERENCES tarifa(idTarifa)
);

CREATE TABLE chip(
  idNumero   char(11)        NOT NULL,
  idPlano int                NOT NULL,
  ativo char(1)              DEFAULT('S')      NOT NULL,
  disponivel char(1)         DEFAULT('S')      NOT NULL,
  CONSTRAINT CK_idNumero CHECK ((idNumero ~ ('^[1-9]{2}'||'985'||'[1-2]{1}[0-9]{5}')) AND  (idNumero !~ ('^[1-9]{2}'||'985'||'[1-2]{1}[0-9]{1}[0]{4}'))),
  CONSTRAINT CK_idNumero2 CHECK (LENGTH(idNumero) = 11),
  CONSTRAINT PK_chip      PRIMARY KEY (idNumero), 
  CONSTRAINT FK_chip_plano FOREIGN KEY (idPlano) REFERENCES plano(idPlano),
  CONSTRAINT CK_chip_ativo  CHECK (ativo = 'S' OR ativo = 'N' ),
  CONSTRAINT CK_chip_disponivel  CHECK (disponivel = 'S' OR disponivel = 'N' )
);



CREATE TABLE ligacao
(
  data timestamp                    NOT NULL,
  chip_emissor    char(11)           NOT NULL,
  ufOrigem    char(2)           NOT NULL,
  chip_receptor char(11)                   NOT NULL,
  ufDestino char(2)             NOT NULL,
  duracao time                   NOT NULL,
  CONSTRAINT PK_ligacao      PRIMARY KEY (data), 
  CONSTRAINT FK_ligacao_chip FOREIGN KEY (chip_emissor) REFERENCES chip(idNumero),
  CONSTRAINT FK_ligacao_estado FOREIGN KEY (ufOrigem) REFERENCES estado,
  CONSTRAINT FK_ligacao_estado2 FOREIGN KEY (ufDestino) REFERENCES estado,
  CONSTRAINT CK_ligacao_ufEmissor  CHECK (LENGTH(ufOrigem)=2),
  CONSTRAINT CK_ligacao_ufReceptor  CHECK (LENGTH(ufDestino)=2)
);

CREATE TABLE fatura
(
  referencia date                      NOT NULL,
  idNumero     char(11)                NOT NULL,
  valor_plano    numeric                NOT NULL,
  tot_min_int int                          NOT NULL,
  tot_min_ext int                          NOT NULL,
  tx_min_exced numeric                 NOT NULL,
  tx_roaming numeric                   NOT NULL,
  total numeric                        NOT NULL,
  pago char(1) DEFAULT ('N')           NOT NULL, 
  CONSTRAINT PK_fatura      PRIMARY KEY (referencia, idNumero),
  CONSTRAINT FK_fatura_chip FOREIGN KEY (idNumero) REFERENCES chip(idNumero),
  CONSTRAINT CK_fatura_pago  CHECK (pago = 'S' OR pago = 'N')
);


CREATE TABLE auditoria
(
  idNumero char(11)                    NOT NULL,
  idCliente   int                      NOT NULL,
  dataInicio date                      NOT NULL,
  dataTermino date                     NOT NULL,
  CONSTRAINT PK_auditoria      PRIMARY KEY (idNumero, idCliente, dataInicio),
  CONSTRAINT FK_auditoria_chip FOREIGN KEY (idNumero) REFERENCES chip(idNumero),
  CONSTRAINT FK_auditoria_cliente FOREIGN KEY (idCliente) REFERENCES cliente
);


CREATE TABLE cliente_chip
(
  idNumero char(11)                    NOT NULL,
  idCliente   int                      NOT NULL,
  CONSTRAINT PK_cliente_chip      PRIMARY KEY ( idCliente, idNumero),
  CONSTRAINT FK_cliente_chip_chip FOREIGN KEY (idNumero) REFERENCES chip(idNumero),
  CONSTRAINT FK_cliente_chip_cliente FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);




