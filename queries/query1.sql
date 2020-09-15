SELECT li.chip_emissor, li.chip_receptor, li.duracao, li.data FROM 
ligacao li JOIN auditoria au 
ON au.idnumero = li.chip_emissor 
WHERE li.data = (SELECT MAX(data) FROM ligacao WHERE (chip_emissor LIKE '83985112345'))
