class List:
    def init(self, head=None):  # Construtor
        self._head = head

    def geraNum(self):
        print('geraNum')

    def gera5NumDisp(self): 
        print('gera5NumDisp')

    def povoaLig(self): 
        print('povoaLig')

    def viewUm(self):
        print('viewUm')

    def viewDois(self): 
        print('viewDois')

    def viewTres(self):
        print('viewTres')


    def menu(self):
        print( """List
         0 - Finished
         1 - Geração Número
         2 - Geração 5 Números Disponiveis
         3 - Povoamento de Ligacao
         4 - View 1: Ranking planos
         5 - View 2: Faturamento por mes/ano
         6 - View 3: Detalhamento dos clientes
        """)


lis = List()
lis.menu()
r = input(" Type your choice: ")

while (r != '0'):
    if r == "1":
        lis.geraNum()

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

    else:
        lis.menu()
    lis.menu()
    r = input(" Type your choice: ")