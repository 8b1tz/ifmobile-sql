CREATE OR REPLACE FUNCTION verif_chistatus()
RETURNS TRIGGER AS $$
DECLARE 
    ativoEmi char(1); 
    ativoRec char(1);
BEGIN
ativoEmi = ativo from chip where idnumero = new.chip_emissor;  --guarda se o emissor está ativo ou não
ativoRec = ativo from chip where idnumero = new.chip_receptor; --guarda se o receptor está ativo ou não

IF ativoEmi = 'N' OR ativoRec = 'N' THEN --se não estiver ativo o receptor ou o emissor 
    RAISE EXCEPTION '%', 'Chip emissor ou receptor inativo !' ; --irá aparecer na tela a exceção
END IF;

RETURN NEW ;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER chipstatus 
BEFORE INSERT  ON ligacao -- trigger será ativado antes da inserção
FOR EACH ROW  --para cara linha será executada a função verif_chistatus 
EXECUTE PROCEDURE verif_chistatus();

select * from ligacao

insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) 
values ('2001-06-29 14:11:00', '83985212346', 'PB', 83985212345, 'PB', '2:52:06');

insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) 
values ('2001-07-27 14:11:00', '98985212345', 'PB', 83985212345, 'PB', '2:52:06');