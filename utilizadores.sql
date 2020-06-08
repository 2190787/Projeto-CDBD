/*
TeSP_PSI_1920_CDBD_6
Módulo de Avaliação de Desepenho de Colaboradores
Ricardo Gonçalves Lopes, estudante n.º 2190787
Simão Santos Pedro, estudante n.º 2192579
*/
-- ********************			CRIAÇÃO DE UTILIZADORES / CONCESSÃO DE PRIVILÉGIOS			********************

USE basededados6;

DROP USER dataadm@localhost;
FLUSH PRIVILEGES;
CREATE USER 'dataadm'@'localhost' IDENTIFIED BY 'dataadm';
GRANT ALL PRIVILEGES ON basededados6.* TO 'dataadm'@'localhost' WITH GRANT OPTION;
SHOW GRANTS FOR dataadm@localhost;

DROP USER diretor@localhost;
FLUSH PRIVILEGES;
CREATE USER 'diretor'@'localhost' IDENTIFIED BY 'diretor';
SHOW GRANTS FOR diretor@localhost;

DROP USER recursoshumanos@localhost;
FLUSH PRIVILEGES;
CREATE USER 'recursoshumanos'@'localhost' IDENTIFIED BY 'recursoshumanos';
SHOW GRANTS FOR recursoshumanos@localhost;

DROP USER funcionariochefe@localhost;
FLUSH PRIVILEGES;
CREATE USER 'funcionariochefe'@'localhost' IDENTIFIED BY 'funcionariochefe';
SHOW GRANTS FOR funcionariochefe@localhost;

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
