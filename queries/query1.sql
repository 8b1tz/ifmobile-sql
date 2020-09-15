SELECT li.data, li.chip_emissor, li.duracao
FROM ligacao li 
JOIN auditoria au 
ON au.idnumero = li.chip_emissor
WHERE (chip_emissor LIKE '83985112345')AND au.dataInicio <  li.data
AND au.dataTermino > li.data
ORDER BY li.data ASC;
