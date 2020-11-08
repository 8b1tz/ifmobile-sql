CREATE OR REPLACE PROCEDURE geraFatu(mes int, ano int)
AS $$
DECLARE
cursorFat refcursor;
rec RECORD;

refe date = ano || '-' || mes || '-25';
tot_min_int int = 0;
tot_min_ext int = 0;
tx_min_exced numeric(5,2) := 0;
tx_roaming numeric(5,2) := 0;
total numeric(7,2);
pago char(1);

auxVal numeric;
auxTar int;
auxRoam int;

Roam int := 0;
RecRoam RECORD; 

BEGIN
-- Resgata as informações principais dos números para a 
-- geração da fatura.
OPEN cursorFat NO SCROLL FOR SELECT chipe.lamen as idNum, 
									valor.valor as valorPlan,
									valor.fminin,
									valor.fminout,
									chipe.idplano,
									chipe.idregiao,
									chipe.cli as idcliente
									FROM (SELECT *, ch.idnumero as lamen, cl.idcliente as cli FROM chip ch 
								JOIN cliente_chip clch ON ch.idnumero = clch.idnumero 
								JOIN cliente cl ON cl.idcliente = clch.idcliente 
								JOIN cidade ci ON cl.idcidade = ci.idcidade
								JOIN estado es ON ci.uf = es.uf
								WHERE cl.cancelado = 'N' AND ch.disponivel = 'N') as chipe
								JOIN (SELECT pl.valor, pl.fminin, pl.fminout, ch.idnumero as valorid  FROM plano pl 
										JOIN chip ch ON ch.idplano = pl.idplano 
										) as valor ON valor.valorid = chipe.lamen;
    -- Loop para resgatar numero por numero, usando o cursor.
    LOOP 
        FETCH cursorFat  INTO rec;
        EXIT WHEN NOT FOUND;
		
		/* Aqui iremos pegar os minutos de duracao do chip emissor da vez (no cursor) 
		na data de referencia. Será feito tanto para ligações internas quanto para externas,
		e no final, caso não tenha ocorrido minutos de chamadas, entrarão no IF e trocarão
		o valor NULL pelo 0.
		*/
		tot_min_int = TRUNC(EXTRACT(EPOCH FROM SUM(duracao)::INTERVAL)/60) FROM ligacao 
						WHERE chip_emissor = rec.idNum 
						AND SUBSTR(chip_receptor, 4, 2) = SUBSTR(chip_emissor, 4, 2)
						AND EXTRACT(YEAR FROM data) = ano
						AND EXTRACT(MONTH FROM data) = mes;
		IF tot_min_int IS NULL THEN
			tot_min_int = 0;
		END IF;
		
		tot_min_ext =  TRUNC(EXTRACT(EPOCH FROM SUM(duracao)::INTERVAL)/60) FROM ligacao 
						WHERE chip_emissor = rec.idNum 
						AND SUBSTR(chip_receptor, 4, 2) != SUBSTR(chip_emissor, 4, 2)
						AND EXTRACT(YEAR FROM data) = ano
						AND EXTRACT(MONTH FROM data) = mes;
		IF tot_min_ext IS NULL THEN
			tot_min_ext = 0;
		END IF;
						
		-- Se auxTar estiver NULL, significa q o plano não tem tal tarifa, então não entrará no IF !
        --Taxa para minutos de numeros da mesma operadora
		tx_min_exced = 0;
		auxTar = idtarifa FROM plano_tarifa WHERE idplano = rec.idplano AND idtarifa = 2 limit 1;
		IF rec.fminin < tot_min_int AND auxTar = 2 THEN
			auxVal = valor FROM tarifa WHERE idtarifa = 2;
			tx_min_exced = tx_min_exced + ((tot_min_int - rec.fminin) * auxVal);
		END IF;
		
        --Taxa para minutos de numeros de outras operadoras
		auxTar =  idtarifa FROM plano_tarifa WHERE idplano = rec.idplano AND idtarifa = 3 limit 1;
		IF rec.fminout < tot_min_ext AND auxTar = 3 THEN
			auxVal = valor FROM tarifa WHERE idtarifa = 3;
			tx_min_exced = tx_min_exced + ((tot_min_ext - rec.fminout) * auxVal);
		END IF;
		
        -- Resgate da quantidade de vezes que foi feito algum tipo de interação
        -- em roaming para aquele numero usando cursor em for, já que é inviável
        -- usar utilizando no primeiro cursor pela quantidade de linhas.
		Roam = 0;
		FOR RecRoam IN SELECT chip_emissor, chip_receptor FROM ligacao 
			WHERE chip_emissor = rec.idNum 
			AND EXTRACT(YEAR FROM data) = ano
			AND EXTRACT(MONTH FROM data) = mes
			LOOP
			auxRoam = idregiao from estado where ddd = SUBSTR(RecRoam.chip_receptor, 4, 2)::int;
			IF auxRoam = rec.idregiao THEN
				Roam = Roam + 1;
			END IF;
		END LOOP;

		
		/* Se auxTar estiver NULL, significa q o plano não tem tal tarifa roaming, então não entrará no IF !*/
		auxTar = idtarifa FROM plano_tarifa WHERE idplano = rec.idplano AND idtarifa = 1;
		IF auxTar = 1 THEN
			auxVal = valor FROM tarifa WHERE idtarifa = 1;
			tx_roaming = Roam *  auxVal;

		END IF;
		
		total = ((rec.valorPlan + tx_min_exced) + tx_roaming);
		
		pago = 'N';

        --Insere na tabela.
		insert into  fatura (referencia, idNumero, valor_plano, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago) 
		values (refe, rec.idNum, rec.valorPlan, tot_min_int, tot_min_ext, tx_min_exced, tx_roaming, total, pago);
	END LOOP;

CLOSE cursorFat;
END; $$
LANGUAGE 'plpgsql';


/*
BEGIN;
CALL  geraFatu(8,2025);
CALL geraFatu(9,2026);
COMMIT;

*/
--   SELECT * from fatura order by referencia desc;
	 --CALL geraLig(9, 2026)
	 --Select * from fatura ORDER BY DATA DESC
--   DELETE FROM fatura WHERE EXTRACT(YEAR FROM referencia) = 2022

