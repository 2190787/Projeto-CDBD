/*
TeSP_PSI_1920_CDBD_6
Módulo de Avaliação de Desepenho de Colaboradores
Ricardo Gonçalves Lopes, estudante n.º 2190787
Simão Santos Pedro, estudante n.º 2192579
*/
-- ********************			INTRODUÇÃO DE DADOS 		********************

USE basededados6;

INSERT INTO hierarquiaorg(idhierarquia,	descricao, nivelhierarquico)	VALUES
	(default, 'Administração', 1),
	(default, 'Direção', 2),
	(default, 'Operação', 3);

INSERT INTO departamentos(iddepartamento, descricao, idhierarquia) VALUES
	(default, 'Administração', 1),
	(default, 'Direção', 2),
	(default, 'Contabilidade', 3),
	(default, 'Vendas', 3),
	(default, 'Programação', 3),
	(default, 'Recursos Humanos', 3);

INSERT INTO funcoes(idfuncao, descricao, iddepartamento) VALUES
	(default, 'Administrador', 1),
	(default, 'Diretor Geral', 2),
	(default, 'Assistente Direção', 2),
	(default, 'TOC', 3),
	(default, 'Contabilista', 3),
	(default, 'Fiscalista', 3),
	(default, 'Chefe Vendas', 4),
	(default, 'Vendedor', 4),
	(default, 'Project Manager', 5),
	(default, 'Developer', 5),
	(default, 'Diretor Recursos Humanos', 6),
	(default, 'Tecnico Recursos Humanos', 6);

INSERT INTO tarefas(idtarefa, descricao) VALUES
	(default, 'Estimar a pontução Issues'), -- Aplicavel aos developers
	(default, 'Planear as Sprints'), -- Aplicavel aos developers 
	(default, 'Implementar Issues'), -- Aplicavel aos developers 
	(default, 'Garantir execução projetos de acordo com a metodologia ágil SCRUM'),  -- Aplicavel ao Project manager, ou Scrum Master
	(default, 'Conceção de Bases de Dados'), -- Aplicavel Developer
	(default, 'Planeamento Projetos'), -- Aplicavel Project Manager
	(default, 'Implementação de Projetos'), -- Aplicavel Project Manager
	(default, 'Processamento Faturas'), -- Aplicavel tecnicos contabilidade
	(default, 'Processamento Recebimentos'), -- Aplicavel tecnicos contabilidade
	(default, 'Elaboração Horários'), -- Aplicavel tecnicos recursos humanos
	(default, 'Pontualidade Processamento Salarios'), -- Aplicavel tecnicos recuros humanos
	(default, 'Estrategia Global Retenção Talentos'), -- Aplicavel tecnicos recursos humanos
	(default, 'Identificação Talentos Interno'), -- Aplicavel tecnicos recursos humanos
	(default, 'Elaboração Estrategia Marketing'),  -- Aplicavel Diretor
	(default, 'Atender Telefonemas'),  -- Aplicavel assistente
	(default, 'Elaboração Estrategia Motivacional'), -- Diretor recursos humanos
	(default, 'Cumprir os objectivos orçamentados da empresa'), -- Aplicavel Diretor Geral
	(default, 'Cumprir os objectivos de vendas do departamento'), -- Aplicavel Chefe Vendas
	(default, 'Cumprir objectivos de venda pessoais'), -- Aplicavel Vendedor
	(default, 'Administrar'),
    (default, 'Entregar Iva mensal'),
    (default, 'Demonstração resultados');

INSERT INTO kpis(idkpi, descricao, idtarefa) VALUES
	(default, 'Sprint Planing', 4), -- Kpi Relativo a Garantir execução projetos de acordo com a metodologia ágil SCRUM
	(default, 'Regularidade Daily Meetings', 4), -- Kpi Relativo a Garantir execução projetos de acordo com a metodologia ágil SCRUM
	(default, 'Regularidade Sprint Retrospective', 4), -- Kpi Relativo a Garantir execução projetos de acordo com a metodologia ágil SCRUM
	(default, 'Numero de issues com pontuacao > 8', 1), -- Kpi relativo a Estimar a pontução Issues
	(default, 'Indice de issues completados nas sprints', 2), -- Kpi do Planeamento Sprints
	(default, 'Evolução numero faturas processadas', 8), -- KPI relativo a Processamento Faturas
	(default, 'Numero médio dos dias de pagamento', 9), -- Kpi Relativo ao Processamento dos Recebimentos
	(default, 'Numero divergencias picagens face horarios', 10), -- KPI Elaboração Horários
	(default, 'Numero entregas fora do prazo limite', 11), -- KPI Relativo a Pontualidade Processamento Salarios
	(default, 'Evolução do numero fans facebook', 14), -- Kpi relativo Elaboração Estrategia Marketing
	(default, 'Taxa telefonemas atendidos em menos de 20 segundos', 15), -- KPI relativo a Atender Telefonemas
	(default, 'Indice Satisfação Colaboradores', 16), -- KPI relativo estategia motivacional
	(default, 'Indice assiduidade', 16), -- KPI relativo estategia motivacional
	(default, 'Evolução do volume faturação', 17), -- Kpi Cumprimento objeticos orçamentados
	(default, 'Evolução margem%', 17), -- Kpi Cumprimento objeticos orçamentados
	(default, 'Evolução margem€', 17), -- Kpi Cumprimento objeticos orçamentados
	(default, 'Evolução do numero de cliente',18 ), -- Kpi relativo a Cumprir os objectivos de vendas do departamento
	(default, 'Aumentar do numero de clientes', 19), -- Kpi Relativo a Atingimento objectivos de venda pessoais
	(default, 'Entrega Iva dentro prazo', 21),
	(default, 'Apresentação resultados dentro do prazo', 22),
	(default, 'Media story points por sprint', 3);


INSERT INTO listatarefas(idfuncao, idtarefa) VALUES
	(1, 20),
	(2, 14),
	(2, 17),
	(3, 15),
	(5, 8),
	(5, 9),
	(7, 18),
	(8, 19),
	(9, 4),
	(10, 3),
	(10, 2),
	(10, 1),
	(11, 16),
	(12, 11),
	(4, 21),
	(6, 22);

INSERT INTO funcionarios(idfuncionario, primeiro, apelido, rua, numero, andar, fracao, localidade, numerocp, extensaocp, designacaopostal, dtanascimento, cc, nif, niss, dtacontratacao, idfuncao) VALUES
	(default, 'José', 'Caiado', 'Beco das Flores', '1', '5.º', 'Esq', 'Leiria', '2400', '013', 'Leiria', '1957/03/21 00:00:00', '18540854', '953106957', '12953106957', '2011/12/03 00:00:00',1),
	(default, 'Dulce', 'Zózimo', 'Rua da Aveleira', '2', '4.º', 'Frt', 'Brogal', '2400', '014', 'Brogal', '1997/02/24 00:00:00', '12717319', '460055683', '12460055683', '2015/11/21 00:00:00',2),
	(default, 'Tânia', 'Norte', 'Travessa Nossa Senhora das Preces', '3', '3.º', 'Dir', 'Casal do ralha', '2400', '018', 'Casal do ralha', '1998/03/01 00:00:00', '14662221', '322946200', '12322946200', '2019/05/21 00:00:00',3),
	(default, 'Telmo', 'Brazão', 'Rua Principal ', '4', '2.º', 'Esq', 'Cascaria', '2400', '020', 'Cascaria', '1970/06/14 00:00:00', '19232303', '688571228', '12688571228', '2013/06/29 00:00:00',4),
	(default, 'Rodrigo', 'Madeira', 'Rua Nossa Senhora das Preces', '5', '1.º', 'Frt', 'Meia légua', '2400', '430', 'Meia légua', '1965/09/03 00:00:00', '18101682', '925889729', '12925889729', '2013/06/29 00:00:00',5),
	(default, 'Arlindo', 'Faustino', 'Rua das Hortas', '6', '5.º', 'Dir', 'Mouratos', '2400', '432', 'Mouratos', '1960/08/06 00:00:00', '11969437', '630577122', '12630577122', '2014/07/17 00:00:00',6),
	(default, 'Cristina', 'Cordeiro', 'Rua Mina da Póvoa ', '7', '4.º', 'Esq', 'Pernelhas', '2400', '442', 'Pernelhas', '1961/06/26 00:00:00', '12663714', '860864399', '12860864399', '2015/01/02 00:00:00',7),
	(default, 'Rui', 'Matias', 'Rua do Viso', '8', '3.º', 'Frt', 'Ponte cabreira', '2400', '446', 'Ponte cabreira', '1966/04/16 00:00:00', '12100955', '385586719', '12385586719', '2013/02/04 00:00:00',8),
	(default, 'Teresa', 'Anjos', 'Travessa das Flores', '9', '2.º', 'Dir', 'Vale arieira', '2400', '491', 'Vale arieira', '1960/10/28 00:00:00', '15766009', '139938451', '12139938451', '2016/02/28 00:00:00',9),
	(default, 'Susana', 'Silva', 'Rua das Flores', '10', '1.º', 'Esq', 'Vale frade', '2400', '493', 'Vale frade', '1960/12/24 00:00:00', '11006647', '418998943', '12418998943', '2016/12/30 00:00:00',10),
	(default, 'Maria', 'Ribeiro', 'Rua da Escola', '11', '5.º', 'Frt', 'Vale juncal', '2400', '497', 'Vale juncal', '1995/09/13 00:00:00', '18030774', '516449766', '12516449766', '2015/09/18 00:00:00',11),
	(default, 'João', 'Rebocho', 'Travessa dos Ribeiros', '12', '4.º', 'Dir', 'Amor', '2400', '759', 'Amor', '1994/07/26 00:00:00', '16642800', '995905068', '12995905068', '2014/06/23 00:00:00',12),
	(default, 'Arlindo', 'Cordeiro', 'Travessa do Baeta', '13', '3.º', 'Esq', 'Barradas', '2400', '762', 'Barradas', '1990/06/03 00:00:00', '17570590', '766455250', '12766455250', '2016/12/09 00:00:00',5),
	(default, 'Joana', 'Silvério', 'Rua Principal ', '15', '1.º', 'Dir', 'Brejo', '2400', '764', 'Brejo', '1971/07/14 00:00:00', '16219458', '990864735', '12990864735', '2017/01/12 00:00:00',8),
	(default, 'Cristiano', ' Rodrigues', 'Rua das Cavadas', '16', '5.º', 'Esq', 'Casal dos claros', '2400', '765', 'Casal dos claros', '1989/04/12 00:00:00', '19806291', '227289862', '12227289862', '2018/12/25 00:00:00',10),
	(default, 'Miguel', 'Fonseca', 'Praceta São Pedro', '20', '1.º', 'Frt', 'Ribeira da escoura', '2400', '769', 'Ribeira da escoura', '1971/01/09 00:00:00', '13447135', '696079885', '12696079885', '2013/12/21 00:00:00',8),
	(default, 'Cristiano', 'Fernandes', 'Largo da Estação', '21', '5.º', 'Dir', 'Toco', '2400', '770', 'Toco', '1981/10/23 00:00:00', '18001924', '570255507', '12570255507', '2016/07/17 00:00:00',10),
	(default, 'Carla', 'Jesus', 'Avenida do Emigrante', '26', '5.º', 'Frt', 'Azoia', '2400', '823', 'Azoia', '1983/03/11 00:00:00', '17215050', '767554215', '12767554215', '2017/04/03 00:00:00',10),
	(default, 'Cecília', 'Simões', 'Rua Armando Santos', '31', '5.º', 'Esq', 'Vale horto', '2400', '828', 'Vale horto', '1987/12/03 00:00:00', '14096609', '206985995', '12206985995', '2015/11/16 00:00:00',10),
	(default, 'Tânia', 'Silvério', 'Rua Luciana Aguiar Guerra ', '36', '5.º', 'Dir', 'Arneiro', '2405', '005', 'Arneiro', '1986/04/20 00:00:00', '19881312', '241828089', '12241828089', '2014/12/06 00:00:00',10);

INSERT INTO funcionarioschefe(idfuncionariochefe, telefoneempresa) VALUES
	(1, '967654321'),
	(2, '963852741'),
	(4, '963572418'),
	(7, '967854213'),
	(9, '961234587'),
	(11, '965412387');

INSERT INTO avaliacoesdesempenho(ano, idavaliado, idavaliador) VALUES
	(2018, 2, 1),
	(2018, 3, 2),
	(2018, 5, 4),
	(2018, 13, 4),
	(2018, 8, 7),
	(2018, 14, 7),
	(2018, 16, 7),
	(2018, 10, 9),
	(2018, 15, 9),
	(2018, 17, 9),
	(2018, 18, 9),
	(2018, 19, 9),
	(2018, 20, 9),
	(2018, 12, 11),
	(2018, 7, 2),
	(2018, 9, 2),
	(2018, 11, 2),
	(2019, 2, 1),
	(2019, 3, 2),
	(2019, 5, 4),
	(2019, 13, 4),
	(2019, 8, 7),
	(2019, 14, 7),
	(2019, 16, 7),
	(2019, 10, 9),
	(2019, 15, 9),
	(2019, 17, 9),
	(2019, 18, 9),
	(2019, 19, 9),
	(2019, 20, 9),
	(2019, 4, 2),
	(2019, 7, 2),
	(2019, 9, 2),
	(2019, 11, 2);

INSERT INTO kpisavaliados(ano, idavaliado, idkpi, objetivo, avaliacao) VALUES
	(2018, 2, 10, '> 1500 fans', 4),
	(2018, 2, 14, 'Crescimento 2% face ano anterior', 4),
	(2018, 2, 15, 'Crescimento 0,1% face ano anterior', 4),
	(2018, 2, 16, 'Crescimento 0,5% face ano anterior', 4),
	(2019, 2, 10, '> 1500 fans', 5),
	(2019, 2, 14, 'Crescimento 2% face ano anterior', 5),
	(2019, 2, 15, 'Crescimento 0,1% face ano anterior', 4),
	(2019, 2, 16, 'Crescimento 0,5% face ano anterior', 5),
	(2018, 3, 11, '>90%', 4),
	(2019, 3, 11, '>90%', 4),
	(2019, 4, 19, '>11', 4),
	(2018, 5, 6, '>1000', 4),
	(2018, 5, 7, 'Entre 45 e 60 dias', 3),
	(2019, 5, 6, '>1000', 2),
	(2019, 5, 7, 'Entre 45 e 60 dias', 2),
	(2018, 7, 17, 'Crescimento de 2% do numere de clientes', 5),
	(2019, 7, 17, 'Crescimento de 2% do numere de clientes', 4),
	(2018, 8, 18, 'Aumento de 10 clientes face ao ano anterior', 4),
	(2019, 8, 18, 'Aumento de 10 clientes face ao ano anterior', 5),
	(2018, 9, 1, '2 por mês', 4),
	(2018, 9, 2, '>4 por semana', 4),
	(2018, 9, 3, '2 por mês', 4),
	(2019, 9, 1, '2 por mês', 5),
	(2019, 9, 2, '>4 por semana', 5),
	(2019, 9, 3, '2 por mês', 5),
	(2018, 10, 4, '<10%', 4),
	(2018, 10, 5, 'Entre 90% e 100%', 5),
	(2018, 10, 21, '>8', 4),
	(2019, 10, 4, '<10%', 5),
	(2019, 10, 5, 'Entre 90% e 100%', 4),
	(2019, 10, 21, '>8', 4),
	(2018, 11, 12, '>75%', 4),
	(2018, 11, 13, 'Entre 90% e 100%', 3),
	(2019, 11, 12, '>75%', 5),
	(2019, 11, 13, 'Entre 90% e 100%', 4),
	(2018, 12, 9, '<1', 3),
	(2018, 13, 6, '>1000', 4),
	(2018, 13, 7, 'Entre 45 e 60 dias', 4),
	(2019, 13, 6, '>1000', 4),
	(2019, 13, 7, 'Entre 45 e 60 dias', 4),
	(2018, 14, 18, 'Aumento de 10 clientes face ao ano anterior', 3),
	(2019, 14, 18, 'Aumento de 10 clientes face ao ano anterior', 4),
	(2018, 15, 4, '<10%', 4),
	(2018, 15, 5, 'Entre 90% e 100%', 4),
	(2018, 15, 21, '>8', 5),
	(2019, 15, 4, '<10%', 5),
	(2019, 15, 5, 'Entre 90% e 100%', 4),
	(2019, 15, 21, '>8', 5),
	(2018, 16, 18, 'Aumento de 10 clientes face ao ano anterior', 4),
	(2019, 16, 18, 'Aumento de 10 clientes face ao ano anterior', 5),
	(2018, 17, 4, '<10%', 4),
	(2018, 17, 5, 'Entre 90% e 100%', 5),
	(2018, 17, 21, '>8', 4),
	(2019, 17, 4, '<10%', 3),
	(2019, 17, 5, 'Entre 90% e 100%', 4),
	(2019, 17, 21, '>8', 5),
	(2018, 18, 4, '<10%', 4),
	(2018, 18, 5, 'Entre 90% e 100%', 5),
	(2018, 18, 21, '>8', 3),
	(2019, 18, 4, '<10%', 4),
	(2019, 18, 5, 'Entre 90% e 100%', 3),
	(2019, 18, 21, '>8', 4),
	(2018, 19, 4, '<10%', 5),
	(2018, 19, 5, 'Entre 90% e 100%', 3),
	(2018, 19, 21, '>8', 4),
	(2019, 19, 4, '<10%', 2),
	(2019, 19, 5, 'Entre 90% e 100%', 3),
	(2019, 19, 21, '>8', 1),
	(2018, 20, 4, '<10%', 4),
	(2018, 20, 5, 'Entre 90% e 100%', 5),
	(2018, 20, 21, '>8', 4),
	(2019, 20, 4, '<10%', 3),
	(2019, 20, 5, 'Entre 90% e 100%', 5),
	(2019, 20, 21, '>8', 4);