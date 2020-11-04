CREATE OR REPLACE PROCEDURE geraLig(mes int, ano int)
AS $$
DECLARE
varNum  int ;
quantIn int ;
quantEx int ;
n int ;

cursorChip refcursor;
rec RECORD;

cursorData date := ano || '-' || mes || '-01';
horaLiga timestamp;

chipRecVar char(11);
ufDest char(2);
ufOrig char(2);
BEGIN
OPEN cursorChip  NO SCROLL FOR SELECT cc.idNumero from cliente_chip cc 
													join chip chi on chi.idnumero = cc.idnumero 
													where chi.ativo = 'S' group by cc.idNumero;
    LOOP -- Loop para cada numero
        FETCH cursorChip  INTO rec;
        EXIT WHEN NOT FOUND;
        LOOP -- Loop para os dias do mes
            horaLiga = cursorData + interval '10 second';
            EXIT WHEN (EXTRACT(MONTH FROM cursorData)::int) != mes;
			varNum  = round(random() * (9) +1); -- quantidade de ligações
			quantIn = round(random() * varNum); -- quantidade de ligações internas ( mesma op)
			quantEx = varNum - quantIn; -- quantidade de ligações exeternas ( op diferentes)
			n = 0;
			--raise notice 'varNum = % / quantIn = % / quantEx = %',varNum,quantIn,quantEx;
			
            LOOP  
				EXIT WHEN n = varNum ;
			    IF  quantIn > 0 THEN
					chipRecVar = cc.idNumero from cliente_chip cc -- vai receber o número 
					join chip chi on chi.idnumero = cc.idnumero   -- que recebeu a ligação
								where cc.idNumero != rec.idnumero and chi.ativo = 'S' 
								and SUBSTR(rec.idnumero, 4, 2) = SUBSTR(cc.idNumero, 4, 2)
								LIMIT 1 OFFSET FLOOR(random() * ((SELECT COUNT(*) FROM cliente_chip )-1));	
					IF chipRecVar IS NULL THEN 
						n = n + quantIn;
						quantIn = 0 ;  
					ELSE
						ufDest = uf from estado where ddd = SUBSTR(chipRecVar, 0, 3)::INTEGER; 
						ufOrig = uf from estado where ddd = SUBSTR(rec.idnumero, 0, 3)::INTEGER;	 
						insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) 
						 values (horaLiga, rec.idnumero, ufOrig, chipRecVar, ufDest, ('0:' || LPAD(round(random() * (19)+1)::text, 2, '0') || ':00')::time);
						n = n + 1;
						quantIn = quantIn - 1;
						horaLiga = horaLiga + interval '1 hour';	
					END IF;
				END IF;
				IF quantEx > 0 THEN
					chipRecVar = cc.idNumero from cliente_chip cc  --vai pegar o número que recebeu a ligação
								join chip chi on chi.idnumero = cc.idnumero 
								where cc.idNumero != rec.idnumero and chi.ativo = 'S' 
								and SUBSTR(rec.idnumero, 4, 2) != SUBSTR(cc.idNumero, 4, 2)
								LIMIT 1 OFFSET FLOOR(random() * ((SELECT COUNT(*) FROM cliente_chip )-1));
					IF chipRecVar IS NULL THEN 
						n = n + quantEx; 
						quantEx = 0 ; 
					ELSE
						ufDest = uf from estado where ddd = SUBSTR(chipRecVar, 0, 3)::INTEGER;
						ufOrig = uf from estado where ddd = SUBSTR(rec.idnumero, 0, 3)::INTEGER;	
						insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) 
						values (horaLiga, rec.idnumero, ufOrig, chipRecVar, ufDest, ('0:' || LPAD(round(random() * (19)+1)::text, 2, '0') || ':00')::time);
						quantEx = quantEx - 1;
						n = n + 1;
						horaLiga = horaLiga + interval '1 hour';
    				END IF;
    		    END IF;
            END LOOP;
            cursorData = cursorData + interval '1 day';
            n = 0;
        END LOOP;
        n = 0;
        cursorData = ano || '-' || mes || '-01';
        horaLiga = cursorData + interval '1 second';
    END LOOP;
CLOSE cursorChip;
END; $$
LANGUAGE 'plpgsql';


-- CALL geraLig(2,2022);
-- DELETE FROM LIGACAO WHERE extract(year from data) = 2022;
-- DELETE FROM LIGACAO WHERE chip_emissor = '21993801113'
-- select * from ligacao ORDER by data DESC;

-- select SUBSTR(chip_emissor, 4, 2),SUBSTR(chip_receptor, 4, 2) from ligacao order by SUBSTR(chip_emissor, 4, 2);

-- select * from ligacao where SUBSTR(chip_emissor, 4, 2) = SUBSTR(chip_receptor, 4, 2);
-- select * from cliente_chip