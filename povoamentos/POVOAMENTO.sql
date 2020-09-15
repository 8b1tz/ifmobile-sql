
-- TABELA: Estados

INSERT INTO estado (uf, nome, ddd) VALUES ('AC', 'Acre', 68);
INSERT INTO estado (uf, nome, ddd) VALUES ('AL', 'Alagoas', 82);
INSERT INTO estado (uf, nome, ddd) VALUES ('AM', 'Amazonas', 92);
INSERT INTO estado (uf, nome, ddd) VALUES ('AP', 'Amapá', 96);
INSERT INTO estado (uf, nome, ddd) VALUES ('BA', 'Bahia', 71);
INSERT INTO estado (uf, nome, ddd) VALUES ('CE', 'Ceará', 85 );
INSERT INTO estado (uf, nome, ddd) VALUES ('DF', 'Distrito Federal', 61 );
INSERT INTO estado (uf, nome, ddd) VALUES ('ES', 'Espírito Santo', 27 );
INSERT INTO estado (uf, nome, ddd) VALUES ('GO', 'Goiás', 62 );
INSERT INTO estado (uf, nome, ddd) VALUES ('MA', 'Maranhão', 98);
INSERT INTO estado (uf, nome, ddd) VALUES ('MG', 'Minas Gerais', 31 );
INSERT INTO estado (uf, nome, ddd) VALUES ('MS', 'Mato Grosso do Sul', 67);
INSERT INTO estado (uf, nome, ddd) VALUES ('MT', 'Mato Grosso',65 );
INSERT INTO estado (uf, nome, ddd) VALUES ('PA', 'Pará', 91);
INSERT INTO estado (uf, nome, ddd) VALUES ('PB', 'Paraíba', 83 );
INSERT INTO estado (uf, nome, ddd) VALUES ('PE', 'Pernambuco', 81);
INSERT INTO estado (uf, nome, ddd) VALUES ('PI', 'Piauí', 86);
INSERT INTO estado (uf, nome, ddd) VALUES ('PR', 'Paraná', 41);
INSERT INTO estado (uf, nome, ddd) VALUES ('RJ', 'Rio de Janeiro', 21);
INSERT INTO estado (uf, nome, ddd) VALUES ('RN', 'Rio Grande do Norte', 84);
INSERT INTO estado (uf, nome, ddd) VALUES ('RO', 'Rondônia', 69);
INSERT INTO estado (uf, nome, ddd) VALUES ('RR', 'Roraima', 95);
INSERT INTO estado (uf, nome, ddd) VALUES ('RS', 'Rio Grande do Sul', 51 );
INSERT INTO estado (uf, nome, ddd) VALUES ('SC', 'Santa Catarina', 47);
INSERT INTO estado (uf, nome, ddd) VALUES ('SE', 'Sergipe', 79);
INSERT INTO estado (uf, nome, ddd) VALUES ('SP', 'São Paulo', 11);
INSERT INTO estado (uf, nome, ddd) VALUES ('TO', 'Tocantins', 63);

-- TABELA: cobertura

INSERT INTO cobertura (uf, ddd) VALUES ('PB', 83);
INSERT INTO cobertura (uf, ddd) VALUES ('PE', 81);
INSERT INTO cobertura (uf, ddd) VALUES ('RN', 84);
INSERT INTO cobertura (uf, ddd) VALUES ('SP', 11);
INSERT INTO cobertura (uf, ddd) VALUES ('RJ', 21);
INSERT INTO cobertura (uf, ddd) VALUES ('MG', 31);



-- TABELA: cidade

-- código do professor Alex

-- TABELA: cliente

insert into cliente (idCliente, nome, endereco, bairro, idCidade, dataCadastro, cancelado) values (1, 'Alyda Hollyard', '559 Granby Point', 'Granby', 8, '9/10/2019', 'N');
insert into cliente (idCliente, nome, endereco, bairro, idCidade, dataCadastro, cancelado) values (2, 'Wilona Crosby', '18 Doe Crossing Avenue', 'Doe', 7, '1/3/2020', 'N');
insert into cliente (idCliente, nome, endereco, bairro, idCidade, dataCadastro, cancelado) values (3, 'Mel Whitehall', '89546 Springview Place', 'Springview', 6, '2/9/2020', 'N');
insert into cliente (idCliente, nome, endereco, bairro, idCidade, dataCadastro, cancelado) values (4, 'Kathe Tinker', '304 Summer Ridge Parkway', 'Summer', 5, '1/7/2020', 'N');
insert into cliente (idCliente, nome, endereco, bairro, idCidade, dataCadastro, cancelado) values (5, 'Bail Robert', '62 Lyons Drive', 'Lyons', 4, '10/11/2019', 'N');
insert into cliente (idCliente, nome, endereco, bairro, idCidade, dataCadastro, cancelado) values (6, 'Deana Foskett', '6 Basil Junction', 'Basil', 4, '12/11/2019', 'S');
insert into cliente (idCliente, nome, endereco, bairro, idCidade, dataCadastro, cancelado) values (7, 'Rae Speight', '449 Del Mar Alley', 'Del', 6, '9/2/2019', 'N');
insert into cliente (idCliente, nome, endereco, bairro, idCidade, dataCadastro, cancelado) values (8, 'Brenn Eivers', '8 Alpine Crossing', 'Alpine', 2, '2/9/2020', 'N');
insert into cliente (idCliente, nome, endereco, bairro, idCidade, dataCadastro, cancelado) values (9, 'Donetta Yokley', '197 Red Cloud Alley', 'Red ', 1, '4/5/2020', 'S');
insert into cliente (idCliente, nome, endereco, bairro, idCidade, dataCadastro, cancelado) values (10, 'Elna Kellart', '992 Dryden Parkway', 'Dryden', 3, '4/2/2020', 'N');

-- TABELA: tarifa

insert into tarifa (idTarifa, descricao, valor) values (1, 'cliente com desconto (10%)', 194);
insert into tarifa (idTarifa, descricao, valor) values (2, 'cliente comum', 332);
insert into tarifa (idTarifa, descricao, valor) values (3, 'cliente com desconto (25%)', 167);
insert into tarifa (idTarifa, descricao, valor) values (4, 'cliente comum', 260);
insert into tarifa (idTarifa, descricao, valor) values (5, 'cliente comum', 336);
insert into tarifa (idTarifa, descricao, valor) values (6, 'cliente comum', 349);
insert into tarifa (idTarifa, descricao, valor) values (7, 'cliente comum', 286);
insert into tarifa (idTarifa, descricao, valor) values (8, 'cliente com desconto (20%)', 236);
insert into tarifa (idTarifa, descricao, valor) values (9, 'cliente comum', 266);
insert into tarifa (idTarifa, descricao, valor) values (10, 'cliente com desconto (30%)', 176);

-- TABELA: plano

insert into plano (idPlano, descricao, fminIn, fminout, addLigacao, roaming, valor) values (1, 'cliente com desconto (30%),', 568, 38, 5, 8, 110);
insert into plano (idPlano, descricao, fminIn, fminout, addLigacao, roaming, valor) values (2, 'cliente comum', 41, 23, 5, 8, 194);
insert into plano (idPlano, descricao, fminIn, fminout, addLigacao, roaming, valor) values (3, 'cliente com desconto (20%)', 856, 314, 5, 2, 175);
insert into plano (idPlano, descricao, fminIn, fminout, addLigacao, roaming, valor) values (4, 'cliente comum', 986, 85, 3, 2, 200);
insert into plano (idPlano, descricao, fminIn, fminout, addLigacao, roaming, valor) values (5, 'cliente com desconto (25%)', 593, 360, 4, 7, 148);
insert into plano (idPlano, descricao, fminIn, fminout, addLigacao, roaming, valor) values (6, 'cliente comum', 546, 35, 3, 7, 177);
insert into plano (idPlano, descricao, fminIn, fminout, addLigacao, roaming, valor) values (7, 'cliente com desconto (35%)', 723, 405, 1, 4, 106);
insert into plano (idPlano, descricao, fminIn, fminout, addLigacao, roaming, valor) values (8, 'cliente comum', 530, 75, 5, 6, 219);
insert into plano (idPlano, descricao, fminIn, fminout, addLigacao, roaming, valor) values (9, 'cliente com desconto (15%)', 587, 427, 4, 5, 124);
insert into plano (idPlano, descricao, fminIn, fminout, addLigacao, roaming, valor) values (10, 'cliente comum', 86, 32, 2, 2, 269);

-- TABELA: chip


insert into chip (idNumero, idPlano, ativo, disponivel) values ('83985112345', 1, 'S', 'N');
insert into chip (idNumero, idPlano, ativo, disponivel) values ('21985112346', 2, 'S', 'N');
insert into chip (idNumero, idPlano, ativo, disponivel) values ('95985212345', 3, 'S', 'N');
insert into chip (idNumero, idPlano, ativo, disponivel) values ('85985112346', 3, 'S', 'N');
insert into chip (idNumero, idPlano, ativo, disponivel) values ('63985212345', 4, 'S', 'N');
insert into chip (idNumero, idPlano, ativo, disponivel) values ('85985112345', 5, 'S', 'N');
insert into chip (idNumero, idPlano, ativo, disponivel) values ('83985212346', 6, 'N', 'S');
insert into chip (idNumero, idPlano, ativo, disponivel) values ('84985112345', 4, 'S', 'N');
insert into chip (idNumero, idPlano, ativo, disponivel) values ('83985212345', 8, 'N', 'N');
insert into chip (idNumero, idPlano, ativo, disponivel) values ('98985212345', 9, 'S', 'S');

-- TABELA: ligacao

insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2001-06-26 14:11:00', '83985112345', 'PB', 83985212345, 'PB', '2:52:06');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2013-10-07 16:12:51', '83985112345', 'PB', 21929499307, 'RJ', '5:37:54');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2016-04-15 16:23:27', '98985212345', 'MA', 21031165578, 'RJ', '1:09:04');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2019-12-22 12:48:20', '21985112346', 'RJ', 95985201267, 'RR', '0:22:03');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2020-08-09 05:42:36', '95985212345', 'RR', 98985212345, 'MA', '0:13:18');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2015-12-29 17:25:36', '83985212345', 'PB', 71985144850, 'BA', '1:21:09');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2020-04-08 16:16:51', '63985212345', 'TO', 83836655595, 'PB', '1:38:06');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2013-04-30 14:13:16', '85985112345', 'CE', 85011547922, 'CE', '2:43:26');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2017-12-10 15:15:27', '83985212346', 'PB', 83985112345, 'PB', '1:19:06');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2009-01-13 15:38:26', '84985112345', 'RN', 71142303971, 'BA', '5:17:18');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2012-05-11 14:48:18', '83985212345', 'PB', 84984804629, 'RN', '0:02:52');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2001-12-25 05:00:29', '85985112345', 'CE', 83797387503, 'PB', '3:22:11');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2009-05-17 04:01:10', '95985212345', 'RR', 61984212346, 'DF', '0:13:37');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2018-01-13 17:39:56', '83985212346', 'PB', 63985212345, 'TO', '0:00:43');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2004-01-06 22:47:47', '63985212345', 'TO', 98985212345, 'MA', '4:17:07');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2018-02-02 13:51:19', '95985212345', 'RR', 47984386997, 'SC', '3:22:44');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2017-06-16 21:16:19', '83985212345', 'PB', 95985212345, 'RR', '5:35:03');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2015-04-09 03:35:29', '83985112345', 'PB', 47543366047, 'SC', '2:48:10');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2007-03-30 03:42:31', '95985212345', 'RR', 21985112346, 'RJ', '3:07:46');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2015-10-11 00:53:28', '21985112346', 'RJ', 83985112345, 'PB', '5:01:15');

insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2007-03-29 10:42:31', '95985212345', 'RR', 21985112346, 'RJ', '0:07:00');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2007-03-28 13:42:31', '95985212345', 'RR', 21985112346, 'RJ', '1:03:26');
insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2007-02-28 13:42:31', '95985212345', 'RR', 21985112346, 'RJ', '3:03:26');

-- TABELA: fatura

  
insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2009-08-03 11:32:09', '83985112345', 305, 77, 416, 22, 92, 263, 'S');
insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2017-10-02 09:08:13', '98985212345', 439, 55, 203, 35, 98, 166, 'N');
insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2003-08-07 17:24:56', '21985112346', 271, 475, 118, 92, 94, 170, 'N');
insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2019-02-04 00:33:02', '95985212345', 326, 225, 328, 95, 26, 343, 'S');
insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2010-06-25 17:15:42', '85985112346', 433, 139, 423, 88, 23, 287, 'S');
insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2014-09-01 01:13:24', '63985212345', 370, 288, 46, 85, 27, 201, 'N');
insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2006-09-14 14:23:00', '85985112345', 337, 248, 34, 57, 26, 229, 'N');
insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2007-03-17 21:11:19', '83985212346', 500, 248, 182, 12, 79, 136, 'S');
insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2000-03-12 12:52:27', '84985112345', 424, 252, 323, 73, 69, 135, 'N');
insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2004-06-07 10:48:28', '83985212345', 287, 255, 400, 86, 87, 204, 'N');

-- TABELA: auditoria

insert into auditoria (idCliente, idNumero, dataInicio, dataTermino) values (1, 21985112346, '25/8/2009', '27/9/2013');
insert into auditoria (idCliente, idNumero, dataInicio, dataTermino) values (2, 83985112345, '29/7/2008', '26/12/2016');
insert into auditoria (idCliente, idNumero, dataInicio, dataTermino) values (3, 98985212345, '30/12/2001', '8/3/2008');
insert into auditoria (idCliente, idNumero, dataInicio, dataTermino) values (4, 84985112345, '10/4/2003', '10/8/2009');
insert into auditoria (idCliente, idNumero, dataInicio, dataTermino) values (5, 98985212345, '25/1/2002', '5/4/2008');
insert into auditoria (idCliente, idNumero, dataInicio, dataTermino) values (6, 98985212345, '28/3/2016', '4/1/2020');
insert into auditoria (idCliente, idNumero, dataInicio, dataTermino) values (7, 85985112345, '6/5/2013', '6/3/2019');
insert into auditoria (idCliente, idNumero, dataInicio, dataTermino) values (8, 63985212345, '8/3/2006', '11/6/2010');
insert into auditoria (idCliente, idNumero, dataInicio, dataTermino) values (9, 85985112346, '18/7/2001', '25/12/2009');
insert into auditoria (idCliente, idNumero, dataInicio, dataTermino) values (10, 21985112346, '9/8/2002', '11/12/2008');

-- TABELA: cliente_chip

insert into cliente_chip (idNumero, idCliente) values ('83985112345', 1);
insert into cliente_chip (idNumero, idCliente) values ('21985112346', 2);
insert into cliente_chip (idNumero, idCliente) values ('95985212345', 3);
insert into cliente_chip (idNumero, idCliente) values ('85985112346', 4);
insert into cliente_chip (idNumero, idCliente) values ('63985212345', 10);
insert into cliente_chip (idNumero, idCliente) values ('85985112345', 9);
insert into cliente_chip (idNumero, idCliente) values ('83985212346', 8);
insert into cliente_chip (idNumero, idCliente) values ('84985112345', 7);
insert into cliente_chip (idNumero, idCliente) values ('83985212345', 6);
insert into cliente_chip (idNumero, idCliente) values ('98985212345', 5);



