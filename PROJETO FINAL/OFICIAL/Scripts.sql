-- REQUISITO 1 --
-- Criando função para gerar numero aleatorio de forma prática
CREATE OR REPLACE FUNCTION random_between(low INT ,high INT) 
   RETURNS INT AS
$$
BEGIN
   RETURN floor(random()* (high-low + 1) + low);
END;
$$ language 'plpgsql' STRICT;

--Função de geração de numeros
CREATE OR REPLACE FUNCTION insere_Num()
RETURNS TRIGGER AS $$
DECLARE 
	numero char(11);
	numdupli char(11);
    num char(11);
    opera char(2);
    subnum char(11);
    random char;
	uf char(4);
	cursorNum refcursor;
	rec RECORD;
	dupli int;
	idrandom int;
BEGIN
num = '00000000000';
subnum =  SUBSTR (num, 7, 4); 
idrandom = random_between(1,7);
uf =  ddd FROM estado WHERE idregiao = idrandom LIMIT 1;
random = FLOOR((random()*2)+1);
dupli = 0;

-- CASE para adicionar o ddd da operadora pelo id dela
CASE NEW.idoperadora
    WHEN  1 THEN opera = '83';
    WHEN  2 THEN opera =  '85';
    WHEN  3 THEN opera =  '91';
    WHEN  4 THEN opera =  '95';
    WHEN  5 THEN opera =  '94';
    WHEN  6 THEN opera =  '89';
    WHEN  7 THEN opera =  '86';
    WHEN  8 THEN opera =  '71';
    WHEN  9 THEN opera = '80';
    WHEN  10 THEN opera =  '93';
    ELSE opera = '82';
END CASE;
LOOP 
	-- LOOP para garantir que o numero não acababe com 0000 e que não seja duplicado
    EXIT WHEN subnum != '0000' AND dupli = 0 ;
        num =  random_between(0,9)|| LPAD(random_between(1,9999)::text, 4, '0');
		dupli = 0;
        subnum =  SUBSTR (num, 7);
		numdupli = uf || '9' || opera || random || num;
		
		-- Cursor para verificar se já existe o número na tabela
		OPEN cursorNum NO SCROLL FOR SELECT idnumero FROM chip;
		LOOP
			FETCH cursorNum INTO rec;
			EXIT WHEN NOT FOUND OR dupli = 1;
			IF rec.idnumero = numdupli THEN
				dupli = 1;
			END IF;
		END LOOP;
		CLOSE cursorNum;
END LOOP;
-- Concatena as partes do numero
numero = uf || '9' || opera || random || num;

NEW.idnumero = numero;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- REQUISITO 2 --

CREATE OR REPLACE FUNCTION verInativNum ()
RETURNS TABLE (idnumeroF char(11), ativoF char(1), disponivelF char(1))
AS $$
DECLARE
BEGIN
-- aqui iremos retornar uma tabela que mostra chip que estão disponiveis para o uso e que não tem problemas técnicos;
-- disponiveis -> disponivel ='S' e sem problemas -> ativo = 'S'
RETURN QUERY SELECT idnumero, ativo,disponivel 
					FROM chip 
					WHERE ativo = 'S' AND disponivel ='S' 
					LIMIT 5 OFFSET FLOOR(random() * ((SELECT COUNT(*) FROM chip WHERE ativo = 'S' AND disponivel ='S')-1)) ;
END; $$
LANGUAGE 'plpgsql';


-- REQUISITO 3 --

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




-- REQUISITO 4 --

CREATE OR REPLACE FUNCTION verif_chistatus()
RETURNS TRIGGER AS $$
DECLARE 
    isAtivoE char(1);
    isDispE  char(1);
    isAtivoR char(1);
    isDispR  char(1);
BEGIN
isAtivoE = ativo from chip where idnumero = new.chip_emissor;
isDispE = disponivel from chip where idnumero = new.chip_emissor;
isAtivoR = ativo from chip where idnumero = new.chip_receptor;
isDispR = disponivel from chip where idnumero = new.chip_receptor;

IF NOT ((isDispR = 'N' AND isAtivoR = 'S') AND (isDispE = 'N' AND isAtivoE = 'S' )) THEN
    RAISE EXCEPTION '%', 'Não possivel concluir ligacao !' ;
END IF;

RETURN NEW ;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER chipstatus
BEFORE INSERT  ON ligacao
FOR EACH ROW
EXECUTE PROCEDURE verif_chistatus();


-- REQUISITO 5 --