/* Alunos: */
-- Yohanna de Oliveira Cavalcanti - 20191370003 

-- Ponto 2.1)
/* Uma query para retornar todas as ligações efetuadas por um número específico 
(exemplo: 83 98880-0505) que está em auditoria (se não estiver em auditoria, não será exibido resultado).
As ligações monitoradas são referentes ao período em que a auditoria foi configurada 
(datas de início e término da auditoria) . Como resultado, você deve apresentar 3 informações:

data da ligação, número de destino, duração da chamada

Se houver mais de uma auditoria, considere apenas a mais recente.
 */
SELECT 
    li.data AS data_da_ligacao, 
    li.chip_receptor AS numero_de_destino, 
    li.duracao AS duracao

FROM ligacao li 
JOIN chip AS chi
ON li.chip_emissor = chi.idnumero
JOIN auditoria AS au 
ON au.idnumero = chi.idnumero

WHERE (chip_emissor LIKE '83985112345') 
    AND (au.dataInicio <  li.data) 
    AND (au.dataTermino > li.data)
ORDER BY li.data;

-- Ponto 2.2)

/* Uma query para retornar o somatório da duração (hora/minuto/segundo) 
das chamadas que um determinado número telefônico realizou com subtotais por dia, mês e ano, 
independentemente do tempo em que o cliente está na operadora. */

SELECT 
    EXTRACT (YEAR FROM li."data") AS ano, 
    EXTRACT (MONTH FROM li."data") AS mes,
    EXTRACT (DAY FROM li."data") AS dia , 
    SUM(li.duracao) AS duracaoTotal

FROM cliente AS cli
JOIN cliente_chip AS clichi
ON cli.idcliente = clichi.idcliente
JOIN chip
ON clichi.idnumero = chip.idnumero
JOIN ligacao AS li
ON li.chip_emissor = chip.idnumero

WHERE li.chip_emissor LIKE '95985212345'
GROUP BY ROLLUP (ano, mes, dia)
