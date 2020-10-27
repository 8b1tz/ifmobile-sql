/*VISÃO 1*/
CREATE VIEW rankPlan AS
(SELECT p.idplano,
        p.descricao,
        COUNT(c.*) AS quant, 
        SUM(p.valor) AS total 
FROM plano p 
JOIN chip c 
ON p.idplano = c.idplano AND ativo = 'S'
GROUP BY p.idplano
ORDER BY quant DESC);

/*VISÃO 2*/
insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2019-02-03 11:32:09', '83985112345', 305, 77, 416, 22, 92, 263, 'S');

CREATE VIEW faturamento AS
(SELECT EXTRACT(YEAR FROM f.referencia) AS ano, 
 EXTRACT(MONTH FROM f.referencia) AS mes,
 COUNT(f.idnumero) AS numClientes, 
 SUM(f.total) AS faturamento
 FROM fatura f 
 GROUP BY (ano, mes)
 ORDER BY (faturamento) DESC );

/*VISÃO 3*/
CREATE VIEW fidelidade AS
(SELECT     cli.idcliente, 
        cli.nome, 
        ci.uf, 
        clichi.idnumero, 
        chip.idplano, 
extract('year' from age(CURRENT_DATE,cli.datacadastro)) || ' ano(s) ' || extract('month' from age(CURRENT_DATE,cli.datacadastro)) || ' mes(es) '  AS tempoFiel
FROM cliente cli 
JOIN cidade ci 
ON cli.idcidade = ci.idcidade 
JOIN cliente_chip clichi 
ON cli.idcliente = clichi.idcliente 
JOIN chip 
ON clichi.idnumero = chip.idnumero AND chip.ativo = 'S';)