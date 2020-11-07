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
cur.execute("UPDATE cliente  SET cancelado = 'S' where idCliente = "+cliente1+";")
con.commit()