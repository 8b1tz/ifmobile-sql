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