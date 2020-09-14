# Projeto Banco de Dados II ( IFmobile)

<h2> Até dia 16/09, faltam 1 dia </h2>

1) Povoamento (1/4)
    - Criar o Banco --- DONE
    - Criar Tabelas (2/11) --- TODO
        - estado       V
        - cidade       V
        - cliente      X
        - chip         X
        - cliente_chip X
        
        - cobertura    V
        - tarifa       V
        - auditoria    V
        - fatura       V
        - ligacao      V
        - plano        V
    - Confirmar se as tabelas atendem ao dicionário --- DONE
    - Usar script de povoamento (feita pelo professor) --- TODO

2) Instruções SQL (0/2)
    - a) Uma query para retornar todas as ligações efetuadas por um número específico (exemplo: 83 98880-0505) que está em auditoria (se não estiver em auditoria, não será exibido         resultado). As ligações monitoradas são referentes ao período em que a auditoria foi configurada (datas de início e término da auditoria) . Como resultado, você deve               apresentar 3 informações: ------ TODO

        - data da ligação
        - número de destino
        - duração da chamada

        Obs: Se houver mais de uma auditoria, considere apenas a mais recente.

    - b) Uma query para retornar o somatório da duração (hora/minuto/segundo) das chamadas que um determinado número telefônico realizou com subtotais por dia, mês e ano,                independentemente do tempo em que o cliente está na operadora. ------ TODO
