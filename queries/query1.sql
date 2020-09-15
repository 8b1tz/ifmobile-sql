SELECT li.data as data_da_ligacao, li.chip_receptor as número_de_destino, li.duracao as duração
FROM ligacao li 
JOIN chip chi
ON li.chip_emissor = chi.idnumero join
auditoria au ON au.idnumero = chi.idnumero
WHERE (chip_emissor LIKE '83985112345')AND au.dataInicio <  li.data
AND au.dataTermino > li.data
ORDER BY li.data ASC;
