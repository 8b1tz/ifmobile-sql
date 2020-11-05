CREATE OR REPLACE FUNCTION verif_clientestatus()
RETURNS TRIGGER AS $$
DECLARE 
    isCancelado char(1); 
BEGIN
isCancelado = cancelado from cliente where idcliente = new.idcliente;

-- Condição para que se o cliente estiver cancelado, NÃO poderá ser adicionado na tabela
IF isCancelado = 'S'  THEN 
    RAISE EXCEPTION '%', 'Cliente cancelado !' ; -- se o cliente estiver cancelado ocorrerá uma execeção 
END IF;

RETURN NEW ;
END;
$$ LANGUAGE plpgsql;

-- Criação do Trigger que executará a verificação do cliente antes da inserção no cliente_chip, em cada linha
CREATE TRIGGER clientetatus 
BEFORE INSERT  ON cliente_chip
FOR EACH ROW
EXECUTE PROCEDURE verif_clientestatus();


-- Observar resultado :
select * from cliente_chip
select * from cliente

insert into cliente_chip (idNumero, idCliente) values ('21985112346', 1);
insert into cliente_chip (idNumero, idCliente) values ('83985112345', 9);

delete from  cliente_chip where idcliente = 1;
delete from  cliente_chip where idcliente = 9;
