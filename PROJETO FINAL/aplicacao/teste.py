import psycopg2

con = psycopg2.connect(
    host = "localhost",
    database= "ifmobile",
    user = "postgres",
    password="postgres",
    port = 5432
)
cur = con.cursor()

cur.execute("select * from fidelidade;")
result_view3 = cur.fetchall()
for row in result_view3:
        print("idCliente: ", row[0])
        print("nome: ", row[1])
        print("uf: ", row[2])
        print("idnumero: ", row[3])
        print("idplano: ", row[4])
        print("tempo fiel: ", row[5])
        print("-----------")