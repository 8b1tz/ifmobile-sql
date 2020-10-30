CREATE OR REPLACE PROCEDURE geraLig(mes int, ano int)
AS $$
DECLARE
varNum int := round(random() * (9) +1);
porcIn float := random();
n int := 0;
cursorChip refcursor;
cursorData date := ano || '-' || mes || '-01';
horaLiga timestamp;
rec RECORD;
BEGIN
OPEN cursorChip NO SCROLL FOR SELECT idnumero from chip;
    LOOP -- Loop para cada numero
        FETCH cursorChip INTO rec;
        EXIT WHEN NOT FOUND;
        LOOP -- Loop para os dias do mes
            horaLiga = cursorData + interval '10 second';
            EXIT WHEN (EXTRACT(MONTH FROM cursorData)::int) != mes;
            WHILE n != varNum LOOP -- Loop para a quantidade aleatoria de ligações
                insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) 
                values (horaLiga, rec.idnumero, 'PB', 83985212345, 'PB', ('0:' || LPAD(round(random() * (19)+1)::text, 2, '0') || ':00')::time);
                n = n + 1;
                horaLiga = horaLiga + interval '1 hour';
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

CALL geraLig(3,2021);

select * from ligacao order by data;