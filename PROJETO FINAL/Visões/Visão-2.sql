insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) values ('2019-02-03 11:32:09', '83985112345', 305, 77, 416, 22, 92, 263, 'S');

CREATE VIEW faturamento AS
(SELECT EXTRACT(YEAR FROM f.referencia) AS ano, 
 EXTRACT(MONTH FROM f.referencia) AS mes,
 COUNT(f.idnumero) AS numClientes, 
 SUM(f.total) AS faturamento
 FROM fatura f 
 GROUP BY (ano, mes)
 ORDER BY (faturamento) DESC );