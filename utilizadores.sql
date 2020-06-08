/*
TeSP_PSI_1920_CDBD_6
Módulo de Avaliação de Desepenho de Colaboradores
Ricardo Gonçalves Lopes, estudante n.º 2190787
Simão Santos Pedro, estudante n.º 2192579
*/
-- ********************			CRIAÇÃO DE UTILIZADORES / CONCESSÃO DE PRIVILÉGIOS			********************

USE basededados6;

-- View de avaliaçãoes atribuidas por cada funcionário chefe
create or replace view v_avaliacoes_preenchidas_avaliadores as
select
	fc.idfuncionariochefe as 'Id Avaliador',
	concat(f.primeiro, " ", f.apelido) as 'Funcionário Avaliador',
    ka.ano as Ano,
    ka.idavaliado as 'Id Funcionário',
    concat(fa.primeiro, " ", fa.apelido) as 'Funcionário Avaliado',
    ka.idkpi as 'Id Kpi',
    k.descricao as 'Kpi avaliado',
    ka.objetivo as Objetivo,
    ka.avaliacao as Avaliação
from funcionarioschefe fc
	left join funcionarios f
		on fc.idfuncionariochefe = f.idfuncionario
	join avaliacoesdesempenho av
		on av.idavaliador = fc.idfuncionariochefe
	join kpisavaliados ka
		on ka.ano = av.ano and ka.idavaliado = av.idavaliado
	join kpis k
		on k.idkpi = ka.idkpi
	left join funcionarios fa
		on fa.idfuncionario = av.idavaliado
order by 1, 3, 4;

-- View de informações de funcionário e descrição de função, departamento e tarefa
create or replace view v_funcionarios_funcoes_departamentos_tarefas as
select
	f.idfuncionario as ID,
    concat(f.primeiro, " ", f.apelido) as Nome,
    f.cc, f.nif, f.niss,
    date_format(f.dtanascimento, '%d-%m-%Y') as Data_Nasc,
    concat(f.rua, ', ', f.numero, ', ', f.andar, ', ', f.fracao) as Morada,
    f.localidade,
    concat(f.numerocp, ' - ', f.extensaocp, ' ', f.designacaopostal) as Codigo_Postal,
    date_format(f.dtacontratacao, '%d-%m-%Y') as Data_Contratacao,
    fn.descricao as Funcao,
    t.descricao as Tarefa
from funcionarios f
	join funcoes fn
		on f.idfuncao = fn.idfuncao
	join departamentos d
		on fn.iddepartamento = d.iddepartamento
	join listatarefas lt
		on fn.idfuncao = lt.idfuncao
	join tarefas t
		on lt.idtarefa = t.idtarefa
order by f.idfuncionario;

-- Criação do utilizador DataBaseDesigner e atribuição de previlégios
DROP USER databasedesigner@localhost;
CREATE USER 'databasedesigner'@'localhost' IDENTIFIED BY 'dbdesigner';
GRANT ALL PRIVILEGES ON basededados6.* TO 'databasedesigner'@'localhost' WITH GRANT OPTION;
SHOW GRANTS FOR databasedesigner@localhost;

-- Criação do utilizador DataBaseDesigner e atribuição de previlégios
DROP USER diretor@localhost;
FLUSH PRIVILEGES;
CREATE USER 'diretor'@'localhost' IDENTIFIED BY 'diretor';
SHOW GRANTS FOR diretor@localhost;

DROP USER recursoshumanos@localhost;
FLUSH PRIVILEGES;
CREATE USER 'recursoshumanos'@'localhost' IDENTIFIED BY 'recursoshumanos';
SHOW GRANTS FOR recursoshumanos@localhost;

