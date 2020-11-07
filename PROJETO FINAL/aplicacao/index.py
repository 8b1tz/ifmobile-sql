from tkinter import *
import psycopg2 as pg

try:
    con = pg.connect(
            host='localhost', 
            database= 'ifmobile', 
            user='postgres', 
            password='postgres', 
            port=5432)
except pg.DatabaseError as dbe:
    con.close()
    print('ERRO')

class List:
    def __init__(self, head=None):  # Construtor
        self._head = head
        self.res = False

    def geraNum(self):  
        cur = con.cursor()
        cur.execute("SELECT * FROM chip;")
        antigoresult = cur.fetchall()
        cur.execute("INSERT INTO chip (idOperadora, idPlano, ativo, disponivel) VALUES ( 1, 1, 'N', 'S');")
        con.commit()
        cur.execute("SELECT * FROM chip;")
        result = cur.fetchall()
        lista_final = [x for x in result if x not in antigoresult]
        for x in lista_final:
            print("Número gerado: ")
            print( x[0])
            print (x[1])
            print (x[2])
            print (x[3])

    def gera5NumDisp(self):
        cur = con.cursor() 
        cur.execute("SELECT * FROM verInativNum();")
        nums = cur.fetchall()
        print("Números disponiveis: ")
        for x in nums:
            print(x)

    def povoaLig(self): 
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

    def viewUm(self):  
        cur = con.cursor()
        cur.execute("select * from rankPlan;")
        result_view1 = cur.fetchall()
        lista_view1 = [x for x in result_view1]
        print("Rank de planos: ")
        for row in lista_view1:
            print("idplano: ",row[0])
            print("descricao: ",row[1])
            print("quantidade: ",row[2])
            print("total: ",row[3])
            print("-----------")

    def viewDois(self): 
        cur = con.cursor()
        cur.execute("select * from faturamento ;")
        result_view2 = cur.fetchall()
        lista_view2 = [x for x in result_view2]
        print("Faturamento por mes/ano: ")
        for row in lista_view2:
            print("ano: {:.0f}".format(row[0]))
            print("mes: {:.0f}".format(row[1]))
            print("Numero de Clientes: ",row[2])
            print("Faturamento: ",row[3])
            print("-----------")

    def viewTres(self):
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

    def geraFatura(self):
        print("Escreva em números, o mes: ")
        mes = int(input())
        print("Escreva em números, o ano: ")
        ano = int(input())
        cur = con.cursor()
        cur.execute("SELECT * FROM fatura;")
        antigafatura = cur.fetchall()
        cur.execute("CALL geraFatu(%s, %s);", (mes, ano))
        con.commit()
        cur.execute("SELECT * FROM fatura;")
        result_fatura = cur.fetchall()
        lista_fatura = [x for x in result_fatura if x not in antigafatura]
        for row in lista_fatura:
            print("data referencial: ", row[0])
            print("idnumero: ",row[1])
            print("valor plano: ",row[2])
            print("total minutos internos: ",row[3])
            print("total minutos externos: ",row[4])
            print("taxa minutos excedidos: ",row[5])
            print("taxa roaming: ",row[6])
            print("total: ",row[7])
            print("pago: ",row[8] )
            print("===================" )

    def negLigInat(self): 
        cur = con.cursor()

        cur.execute("select * from ligacao")
        antiga_liga = cur.fetchall()
        cur.execute("SELECT idNumero FROM chip where ativo = 'N' LIMIT 5;") 
        result_inativos = cur.fetchall()
        print("Números inativos: ")
        for row3 in result_inativos:
            print(row3)
        cur.execute("SELECT idNumero FROM chip where ativo = 'S'LIMIT 5;") 
        result_ativos = cur.fetchall()
        print("Números ativos: ")
        for row2 in result_ativos:
            print(row2)
        emissor = input("Insira o número que ligou: ")
        receptor = input("Insira o receptor: ")
        cur.execute("insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2001-07-27 14:11:00',%s, 'PB', %s, 'PB', '2:52:06');",(emissor, receptor))
        con.commit()
        cur.execute("select * from ligacao;")
        novaliga = cur.fetchall()
        lista_liga = [x for x in novaliga if x not in antiga_liga]
        for row in lista_liga:
            print("data: ", row[0])
            print("emissor: ",row[1])
            print("uf origem: ",row[2])
            print("receptor:: ",row[3])
            print("uf destino: ",row[4])
            print("duracao: ",row[5])


    def libChip(self): 
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

    def negChCliIna(self):
        cur = con.cursor()
        cur.execute ("SELECT idCliente from cliente where cancelado = 'N' LIMIT 5;")
        result_naocanc = cur.fetchall()
        print("Clientes não cancelados: ")
        for row4 in result_naocanc:
            print(row4)
        cur.execute ("SELECT idCliente from cliente where cancelado = 'S' LIMIT 5;")
        result_canc = cur.fetchall()
        print("Clientes Cancelados:")
        for row5 in result_canc:
            print(row5)
        cliente = input("Digite o seu idCliente: ")
        self.gera5NumDisp()
        numero = input("Digite o seu número: ")
        cur.execute("insert into cliente_chip (idNumero, idCliente) values ('"+numero+"', "+cliente+");")
        con.commit()

    def menu(self):
        print( """List
         0 - Fim
         1 - Geração de número
         2 - Geração de até 5 números disponiveis
         3 - Povoamento de ligacao  
         4 - View 1: Ranking planos
         5 - View 2: Faturamento por mes/ano
         6 - View 3: Detalhamento dos clientes
         7 - Negar ligação de numeros inativos/disponiveis
         8 - Liberar chip de cliente cancelado
         9 - Garante chip disponivel para cliente ativo
         10 - Gerar fatura
        """)

lis = List()
lis.menu()
r = input(" Type your choice: ")

while (r != '0'):
    if r == "1":
        lis.geraNum() # QUASE OK
        
    elif r == "2":
        lis.gera5NumDisp() # QUASE OK
        
    elif r == "3":
        lis.povoaLig() 
        
    elif r == "4":
        lis.viewUm()
        
    elif r == "5":
        lis.viewDois()

    elif r == "6":
        lis.viewTres()

    elif r == "7": # QUASE OK
        lis.negLigInat()

    elif r == "8": # QUASE OK
        lis.libChip()  

    elif r == "9": # QUASE OK
        lis.negChCliIna()

    elif r == "10": # QUASE OK
        lis.geraFatura()

    else:
        lis.menu()
    lis.menu()
    r = input(" Type your choice: ")
print('Banco Fechado, Fim !')
con.close()
