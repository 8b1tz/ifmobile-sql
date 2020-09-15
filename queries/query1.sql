SELECT li.data, li.chip_receptor, li.duracao
FROM ligacao li 
JOIN chip
ON li.chip_emissor = chip.idnumero
JOIN auditoria au 
ON au.idnumero = chip.idnumero
WHERE date_part('year',age(au.dataTermino, au.dataInicio)) = (SELECT MAX(date_part('year',age(au.dataTermino, au.dataInicio))) 
                                                              FROM auditoria au
                                                              JOIN chip
                                                              ON au.idnumero = chip.idnumero
                                                              JOIN ligacao li
                                                              ON li.chip_emissor = chip.idnumero
                                                              WHERE (chip_emissor LIKE '83985112345'));
