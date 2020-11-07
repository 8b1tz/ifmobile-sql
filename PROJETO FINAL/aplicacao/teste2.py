from tkinter import *
import psycopg2 as pg
usua = input('Faca seu login: \nUsuário: ')
senha = input('Senha: ')
try:
    con = pg.connect(
            host='localhost', 
            database= 'ifmobile', 
            user=usua, 
            password=senha, 
            port=5432)
except pg.DatabaseError as dbe:
    con.close()
    print('ERRO, NÃO FOI POSSIVEL CONECTAR AO BANCO\nVerifique se suas credenciais estão corretas, \nse o banco está criado ou em funcionamento.')

class List:
    def __init__(self, head=None):  # Construtor
        self._head = head
        self.res = False

    def geraNum(self, opera, plan):  
        cur = con.cursor()
        cur.execute("SELECT * FROM chip;")
        antigoresult = cur.fetchall()
        cur.execute("INSERT INTO chip (idOperadora, idPlano, ativo, disponivel) VALUES ( %s, %s, 'S', 'S');",(opera, plan))
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

    def geraFatura(self, mes, ano):
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

    def povoaLig(self): 
        print('povoaLig')

    def viewUm(self):  
        print('viewUm')

    def viewDois(self): 
        print('viewDois')

    def viewTres(self):
        print('viewTres')

    def setFim(self):
        self.res = True

    def menu(self):
        print( """List
         0 - Fim
         1 - Geração Número
         2 - Geração 5 Números Disponiveis
         3 - Povoamento de Ligacao  
         4 - View 1: Ranking planos
         5 - View 2: Faturamento por mes/ano
         6 - View 3: Detalhamento dos clientes
         7 - Gera Fatura
        """)

lis = List()
lis.menu()
r = input(" Type your choice: ")

while (r != '0'):
    if r == "1":
        print("""Escolha A Operadora:""")
        cur = con.cursor()
        cur.execute("SELECT * FROM operadora;")
        ope = cur.fetchall()
        for x in ope:
            print(x)
        opera = int(input('\n'))
        cur.execute("SELECT * FROM plano;")
        ope = cur.fetchall()
        for x in ope:
            print (str(x[0])+' - '+str(x[1]))
            print ('    Minutos p/ mesma operadora: '+str(x[2]))
            print ('    Minutos p/ outra operadora: '+str(x[3]))
            print ('    Valor: '+str(x[4]))
        plan = int(input ('Escolha o plano: '))
        lis.geraNum(opera, plan)
        
    elif r == "2":
        lis.gera5NumDisp()
        
    elif r == "3":
        lis.povoaLig()
        
    elif r == "4":
        lis.viewUm()
        
    elif r == "5":
        lis.viewDois()

    elif r == "6":
        lis.viewTres()
    elif r == "7":
        print("Escreva em números, o mes: ")
        mes = int(input())
        print("Escreva em números, o ano: ")
        ano = int(input())
        lis.geraFatura(mes, ano)
    else:
        lis.menu()
    lis.menu()
    r = input(" Type your choice: ")
print('Banco Fechado, Fim !')
con.close()
