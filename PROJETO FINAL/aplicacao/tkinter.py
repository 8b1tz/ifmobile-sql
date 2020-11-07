from tkinter import *
import psycopg2 as pg
import tkinter.font as font
#usua = input('Faca seu login: \nUsuário: ')
#senha = input('Senha: ')
try:
    con = pg.connect(
            host='localhost', 
            database= 'ifmobile', 
            user="postgres",
            password="postgres",
            port=5432)
except pg.DatabaseError as dbe:
    con.close()
    print('ERRO, NÃO FOI POSSIVEL CONECTAR AO BANCO\nVerifique se suas credenciais estão corretas, \nse o banco está criado ou em funcionamento.')

class List:
    def __init__(self, head=None):  # Construtor
        self._head = head
        self.res = False

    def geraNum(self):  
        cur = con.cursor()
        cur.execute("SELECT * FROM chip;")
        antigoresult = cur.fetchall()
        cur.execute("INSERT INTO chip (idOperadora, idPlano, ativo, disponivel) VALUES ( 1, 1, 'S', 'S');")
        con.commit()
        cur.execute("SELECT * FROM chip;")
        result = cur.fetchall()
        lista_final = [x for x in result if x not in antigoresult]
        for x in lista_final:
            myLabel.configure(text = 'idnumero: {} \n idoperadora:{} \n idplano: {} \n ativo: {} \n disponivel: {}'.format(x[0], x[1], x[2], x[3],x[4] ))

    def gera5NumDisp(self):
        cur = con.cursor() 
        cur.execute("SELECT * FROM verInativNum();")
        nums = cur.fetchall()
        #myLabel.configure(text = '')
        for x in nums:  
            #myLabel = Label(root, text="{}".format(x))
            #myLabel = Label(root, text="{}".format(x))
            print(x)

    def povoaLig(self): 
        cur = con.cursor()

        try:
            labelmes = Label(root, text="MES ", ).grid(row=2, column=0)  
            labelano = Label(root, text="ANO ",).grid(row=2, column=2)  
            mes = Entry(root, text= 'Mes',bg = 'pink', ).grid(row=2,column=1, sticky="ew")
            ano = Entry(root, text= 'Ano',bg = 'pink',).grid(row=2,column=3, sticky="ew")
        except ValueError:
            con.rollback()
            myLabel.configure(text = 'Não é permitido caracteres que não sejam numeros!')
            #return print('Não é permitido caracteres que não sejam numeros!')

        try:
            cur.execute("CALL geraLig(%s, %s);", (mes, ano))
        except pg.errors.InvalidDatetimeFormat as e:
            con.rollback()
            myLabel.configure(text = "Datas inválidas, operação abortada!\nError tipo: {erType}".format(erType = type(e)))
            #return print("Datas inválidas, operação abortada!\nError tipo: {erType}".format(erType = type(e)))
        except pg.errors.DatetimeFieldOverflow as e2:
            myLabel.configure(text = "Houve um overflow da data(data fora do alcance), operação abortada!\nError tipo: {erType}".format(erType = type(e2)))
            con.rollback()
            #return print("Houve um overflow da data(data fora do alcance), operação abortada!\nError tipo: {erType}".format(erType = type(e2)))
        except pg.errors.UniqueViolation as e3:
            con.rollback()
            myLabel.configure(text = "Já existem ligações nessa data, operação abortada!\nError tipo: {erType}".format(erType = type(e3)))
            #return print("Já existem ligações nessa data, operação abortada!\nError tipo: {erType}".format(erType = type(e3)))

        con.commit()
        cur.execute("SELECT COUNT(*) FROM ligacao as li where EXTRACT(MONTH FROM li.data) = %s AND EXTRACT(YEAR FROM li.data) = %s", (mes,ano))
        result_novalig = cur.fetchall()
        #print("ligação gerada: ")
        for row7 in result_novalig:
            myLabel.configure(text = "Quantidade de ligações realizadas: {}".format(str(row7[0])))
            #print("Quantidade de ligações realizadas: "+str(row7[0])+"\n")
            
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
        try:
            cur.execute("insert into ligacao (data, chip_emissor, ufOrigem, chip_receptor, ufDestino, duracao) values ('2001-07-27 14:11:00',%s, 'PB', %s, 'PB', '0:52:06');",(emissor, receptor))
        except Exception:
            con.rollback()
            return print('Não é possível fazer/receber ligações com um número inativo!')
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
        cur.execute ("SELECT idCliente, nome from cliente where cancelado = 'N' LIMIT 5;")
        result_naocanc1 = cur.fetchall()
        print("Clientes não cancelados: ")
        for row5 in result_naocanc1:
            print(row5)
        cliente1 = input("Qual cliente você deseja cancelar? Escolha o numero: ")
        try:
            cur.execute("SELECT chip.idnumero FROM cliente join cliente_chip on cliente_chip.idcliente = cliente.idcliente join chip on cliente_chip.idnumero = chip.idnumero WHERE cliente.idcliente = "+cliente1+";")
        except pg.errors.UndefinedColumn:
            con.rollback()
            return print('Não é permitido usar letras na escolha!')
            
        result_clch = cur.fetchall()
        if result_clch == []:
            con.rollback()
            return print ('Não existem numeros ativos para esse cliente! \nOu ele é um cliente novo ou está cancelado!')
            
        print("Números do cliente: ")
        for row6 in result_clch:
            print(row6)
        resposta = input("Tem certeza que quer fazer isso? S/N: ")
        if resposta.upper() == 'S':
            cur.execute("UPDATE cliente  SET cancelado = 'S' where idCliente = "+cliente1+";")
            con.commit()
            print("Agora números estão disponiveis! ")
        else:
            print('Operação cancelada!')

        

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
        try:
            cur.execute("insert into cliente_chip (idNumero, idCliente) values ('"+numero+"', "+cliente+");")
            con.commit()
        except:
            print('Não é possível atribuir chip a um cliente cancelado!')


lis = List()

root = Tk()
root.geometry('1100x600') 
root.grid_rowconfigure(3,  weight=1)
root.grid_columnconfigure(3,  weight=1)
strVar = StringVar()

myFont = font.Font(family='Helvetica', size=20, weight='bold')

myLabel = Label(root, text="Respostas estarão aqui !")

myButton  = Button(root, text="Gerando Numero",width=20,height=5, command=lis.geraNum,bg = 'orange',)
myButton1 = Button(root, text="Gerando 5 Numeros",width=20,height=5, command=lis.gera5NumDisp,bg = 'orange',)
myButton2 = Button(root, text="View 1",width=25,height=5, command=lis.viewUm,bg = 'orange',)
myButton3 = Button(root, text="View 2",width=25,height=5, command=lis.viewDois,bg = 'orange',)
myButton4 = Button(root, text="View 3",width=25,height=5, command=lis.viewTres,bg = 'orange',)
myButton5 = Button(root, text="Cliente Inativo",width=20,height=5, command=lis.geraNum,bg = 'orange',)
myButton6 = Button(root, text="Libera Chip",width=20,height=5, command=lis.geraNum,bg = 'orange',)
myButton7 = Button(root, text="Ligação com nº inativo",width=25,height=5, command=lis.geraNum,bg = 'orange',)
myButton8 = Button(root, text="Povoamento de Ligacao",width=25,height=5, command=lis.povoaLig,bg = 'orange',)
myButton9 = Button(root, text="Gerando Fatura",width=25,height=5, command=lis.geraNum,bg = 'orange',)

myButton.config(font=(8))
myButton1.config(font=(8))
myButton2.config(font=(8))
myButton3.config(font=(8))
myButton4.config(font=(8))
myButton5.config(font=(8))
myButton6.config(font=(8))
myButton7.config(font=(8))
myButton8.config(font=(8))
myButton9.config(font=(8))
myLabel.config(font=("Courier", 20))


myButton.grid(row=0,column=0 , sticky="ew")
myButton1.grid(row=0,column=1 , sticky="ew")
myButton2.grid(row=0,column=2 , sticky="ew")
myButton3.grid(row=0,column=3 , sticky="ew")
myButton4.grid(row=0,column=4 , sticky="ew")
myButton5.grid(row=1,column=0 , sticky="ew")
myButton6.grid(row=1,column=1 , sticky="ew")
myButton7.grid(row=1,column=2 , sticky="ew")
myButton8.grid(row=1,column=3 , sticky="ew")
myButton9.grid(row=1,column=4 , sticky="ew")

myLabel.grid(rowspan=3,columnspan=5 , sticky="ew")

root.mainloop()

