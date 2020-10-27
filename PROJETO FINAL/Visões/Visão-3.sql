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