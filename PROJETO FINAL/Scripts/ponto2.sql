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

--drop function  verInativNum()

SELECT * FROM verInativNum();