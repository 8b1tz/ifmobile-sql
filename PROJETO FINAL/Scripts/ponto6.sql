CREATE OR REPLACE FUNCTION verif_clienteLiberaNum()
RETURNS TRIGGER AS $$
DECLARE 
    isCancelado char(1); 
    Num char(11);
    cursorVer refcursor;
    rec RECORD;
BEGIN
isCancelado = new.cancelado;  

IF isCancelado = 'S'  THEN -- Verifica se o cliente está como cancelado
OPEN cursorVer NO SCROLL FOR select chi.idnumero from chip chi -- Abre um cursor com os numeros que pertencia ao cliente
               join cliente_chip clichi on chi.idnumero = clichi.idnumero 
               join cliente cli on clichi.idcliente = cli.idcliente and cli.idcliente = old.idcliente;
    LOOP
        FETCH cursorVer INTO rec;
        EXIT WHEN NOT FOUND;
        /* Deixará o número disponível e desativado na tabela chip, 
        e deletará o vínculo do antigo cliente na tabela cliente_chip*/
        UPDATE chip SET disponivel = 'S', ativo = 'N' WHERE chip.idnumero = rec.idnumero;
        DELETE FROM cliente_chip WHERE cliente_chip.idnumero = rec.idnumero;
    END LOOP;
CLOSE cursorVer;
END IF;

RETURN NEW ;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER clienteCancel
BEFORE UPDATE  ON cliente --Logo após o cliente ser cancelado, ele disparará
FOR EACH ROW  
EXECUTE PROCEDURE verif_clienteLiberaNum();

-- Queries usadas para testes
/*
select * from cliente WHERE idcliente = 1
select * from cliente_chip WHERE idcliente = 1
select chi.* from  chip chi 
    join cliente_chip clichi on chi.idnumero = clichi.idnumero 
    join cliente cli on clichi.idcliente = cli.idcliente and cli.idcliente = 1

UPDATE cliente SET cancelado = 'N' WHERE idcliente = 1
UPDATE cliente SET cancelado = 'S' WHERE idcliente = 1
*/