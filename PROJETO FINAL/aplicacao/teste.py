import psycopg2

con = psycopg2.connect(
    host = "localhost",
    database= "ifmobile",
    user = "postgres",
    password="postgres",
    port = 5432
)
cur = con.cursor()


cur.execute ("SELECT idCliente from cliente where cancelado = 'N' LIMIT 5;")
result_naocanc1 = cur.fetchall()
print("Clientes não cancelados: ")
for row5 in result_naocanc1:
    print(row5)
cliente1 = input("Qual cliente você deseja cancelar? ")
cur.execute("SELECT chip.idnumero FROM cliente join cliente_chip on cliente_chip.idcliente = cliente.idcliente join chip on cliente_chip.idnumero = chip.idnumero WHERE cliente.idcliente = "+cliente1+";")
result_clch = cur.fetchall()
print("Números do cliente: ")
for row6 in result_clch:
    print(row6)
resposta = print(input("Tem certeza que quer fazer isso? S/N: "))
if resposta == 'S' or 's':
    cur.execute("UPDATE cliente  SET cancelado = 'S' where idCliente = "+cliente1+";")
    print("Agora números estão disponiveis! ")

con.commit()