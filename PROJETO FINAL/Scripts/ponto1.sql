-- Cria função para inserir em  chip
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
idrandom = floor(random()* (27) + 1);
uf =  ddd FROM estado WHERE idregiao = idrandom LIMIT 1;
random = FLOOR((random()*2)+1);
dupli = 0;

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
    EXIT WHEN subnum != '0000' AND dupli = 0 ;
        num =  round(random()* 9)::text|| LPAD(round((random() * 9998) + 1)::text, 4, '0');
        dupli = 0;
        subnum =  SUBSTR (num, 7);
        numdupli = uf || '9' || opera || random || num;
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

numero = uf || '9' || opera || random || num;

NEW.idnumero = numero;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Cria a trigger
CREATE TRIGGER insereNum
BEFORE INSERT  ON chip
FOR EACH ROW
EXECUTE PROCEDURE insere_Num();

-- Para observar o resultado use as linhas abaixo
SELECT * FROM chip
order by chip.idnumero
INSERT INTO chip (idOperadora, idPlano, ativo, disponivel) VALUES ( 1, 1, 'N', 'S');
INSERT INTO chip (idOperadora, idPlano, ativo, disponivel)  VALUES ( 2, 1, 'S', 'N');