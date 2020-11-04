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

-- Cria a trigger para inserir o idnumero na criação antes do insert no chip
CREATE TRIGGER insereNum
BEFORE INSERT  ON chip
FOR EACH ROW
EXECUTE PROCEDURE insere_Num();

-- Para observar o resultado use as linhas abaixo
SELECT * FROM chip
INSERT INTO chip (idOperadora, idPlano, ativo, disponivel) VALUES ( 1, 1, 'N', 'S');
INSERT INTO chip (idOperadora, idPlano, ativo, disponivel)  VALUES ( 2, 1, 'S', 'N');
DELETE FROM CHIP WHERE IDPLANO = 1 AND ATIVO ='N'
DELETE FROM CHIP WHERE IDPLANO = 1 AND IDOPERADORA = 2


