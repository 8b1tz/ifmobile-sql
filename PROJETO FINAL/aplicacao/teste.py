import psycopg2

con = psycopg2.connect(
    host = "localhost",
    database= "ifmobile",
    user = "postgres",
    password="postgres",
    port = 5432
)
cur = con.cursor()

mes = input("Insira o mes: ")
ano = input("Insira o ano: ")
cur.execute("select * from ligacao ORDER by data DESC;")
result_antigaslig = cur.fetchall()
cur.execute("CALL geraLig(%s, %s);", (mes, ano))
cur.execute("select * from ligacao ORDER by data DESC;")
result_novalig = cur.fetchall()
lista_ligac = [x for x in result_novalig if x not in result_antigaslig]
print("ligação gerada: ")
for row7 in lista_ligac:
    print("data: ",row7[0])
    print("emissor: ",row7[1])
    print("uf origem: ",row7[2])
    print("receptor: ",row7[3])
    print("uf destino: ",row7[4])
    print("duracao: ",row7[5])