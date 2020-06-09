/*
TeSP_PSI_1920_CDBD_PL_6
Módulo de Avaliação de Desepenho de Colaboradores
Ricardo Gonçalves Lopes, estudante n.º 2190787
Simão Santos Pedro, estudante n.º 2192579
*/
-- ********************			CRIAÇÃO BASE DE DADOS / TABELAS 		********************

DROP DATABASE IF EXISTS basededados_pl_6;
CREATE DATABASE basededados_pl_6;
USE basededados_pl_6;

CREATE TABLE hierarquiaorg(
	idhierarquia 				INT UNSIGNED	NOT NULL AUTO_INCREMENT,
	descricao				VARCHAR(50)		NOT NULL,
    nivelhierarquico				INT UNSIGNED   	NOT NULL,
	CONSTRAINT pk_niveis_idnivel	PRIMARY KEY (idhierarquia ),
    CONSTRAINT uk_ordemnivel 		UNIQUE		(nivelhierarquico)
)engine=innoDB;

CREATE TABLE departamentos(
	iddepartamento			INT UNSIGNED	NOT NULL AUTO_INCREMENT,
	descricao				VARCHAR(50)		NOT NULL,
    idhierarquia				INT UNSIGNED   	NOT NULL,
	CONSTRAINT pk_departamentos_iddepartamento	PRIMARY KEY (iddepartamento),
    CONSTRAINT fk_departamentos_idhierarquia	FOREIGN KEY(idhierarquia) 	REFERENCES hierarquiaorg(idhierarquia)
)engine=innoDB;

CREATE TABLE funcoes(
	idfuncao				INT UNSIGNED	NOT NULL	AUTO_INCREMENT,
	descricao				VARCHAR(50)		NOT NULL,
	iddepartamento		INT UNSIGNED 	NOT NULL,
	CONSTRAINT pk_funcoes_idfuncao	PRIMARY KEY (idfuncao),
	CONSTRAINT fk_funcionarios_iddepartamento	FOREIGN KEY(iddepartamento)	REFERENCES departamentos(iddepartamento)
)engine=innoDB;

CREATE TABLE funcionarios(
	idfuncionario		INT UNSIGNED	NOT NULL	AUTO_INCREMENT,
	primeiro			VARCHAR(30)		NOT NULL,
	apelido				VARCHAR(30)		NOT NULL,
	rua					VARCHAR(100)	NOT NULL,
	numero				VARCHAR(10)		NOT NULL,
	andar				VARCHAR(10),
	fracao				VARCHAR(10),	
	localidade			VARCHAR(50)		NOT NULL,
	numerocp			VARCHAR(6)		NOT NULL,
	extensaocp			VARCHAR(6)		NOT NULL,
	designacaopostal	VARCHAR(50)		NOT NULL,
	dtanascimento		DATETIME		NOT NULL,
	cc					VARCHAR(8)		NOT NULL,
	nif					VARCHAR(9)		NOT NULL,
	niss				VARCHAR(11)		NOT NULL,
	dtacontratacao		DATETIME		NOT NULL,
	idfuncao			INT UNSIGNED 	NOT NULL,
	CONSTRAINT pk_funcionarios_idfuncionario	PRIMARY KEY (idfuncionario),
	CONSTRAINT uk_cc 		UNIQUE		(cc),
	CONSTRAINT uk_nif 		UNIQUE		(nif),
	CONSTRAINT uk_niss 		UNIQUE		(niss),
	CONSTRAINT fk_funcionarios_idfuncao			FOREIGN KEY(idfuncao) 		REFERENCES funcoes(idfuncao)
)engine=innoDB;

CREATE TABLE funcionarioschefe(
	idfuncionariochefe		INT UNSIGNED	NOT NULL,
    telefoneempresa			varchar(9)		NOT NULL,
	CONSTRAINT pk_funcionarioschefe_idfuncionario	PRIMARY KEY (idfuncionariochefe),
    CONSTRAINT fk_funcionarioschefe_idfuncionario	FOREIGN KEY(idfuncionariochefe) 		REFERENCES funcionarios(idfuncionario)
)engine=innoDB;

CREATE TABLE tarefas(
	idtarefa				INT UNSIGNED	NOT NULL	AUTO_INCREMENT,
	descricao				VARCHAR(100)		NOT NULL,
	CONSTRAINT pk_funcoes_idfuncao				PRIMARY KEY (idtarefa)
)engine=innoDB;

CREATE TABLE listatarefas(
	idfuncao				INT UNSIGNED	NOT NULL,
	idtarefa				INT UNSIGNED	NOT NULL,
	CONSTRAINT pk_listatarefas		PRIMARY KEY (idfuncao, idtarefa),
    CONSTRAINT fk_listatarefas_idfuncao			FOREIGN KEY(idfuncao) 		REFERENCES funcoes(idfuncao),
    CONSTRAINT fk_listatarefas_idtarefa			FOREIGN KEY(idtarefa) 		REFERENCES tarefas(idtarefa)
)engine=innoDB;

CREATE TABLE avaliacoesdesempenho(
	ano						INT	UNSIGNED	NOT NULL,
    idavaliado				INT UNSIGNED	NOT NULL,
    idavaliador				INT UNSIGNED	NOT NULL,
    CONSTRAINT pk_avaliacoesdesempenho_ano_idfuncionario	PRIMARY KEY (ano, idavaliado),
    CONSTRAINT fk_avaliacoesdesempenho_idavaliado			FOREIGN KEY(idavaliado) 		REFERENCES funcionarios(idfuncionario),
	CONSTRAINT fk_avaliacoesdesempenho_idavaliador			FOREIGN KEY(idavaliador) 		REFERENCES funcionariosChefe(idfuncionarioChefe)
)engine=innoDB;

CREATE TABLE kpis(
	idkpi					INT UNSIGNED	NOT NULL AUTO_INCREMENT,
	descricao				VARCHAR(50)		NOT NULL,
    idtarefa				INT UNSIGNED,
	CONSTRAINT pk_kpis_id_kpi		PRIMARY KEY (idkpi),
    CONSTRAINT fk_kpis_idtarefa		FOREIGN KEY(idtarefa) 	REFERENCES tarefas(idtarefa)
)engine=innoDB;

CREATE TABLE kpisavaliados(
	ano				INT UNSIGNED	NOT NULL,
    idavaliado		INT UNSIGNED	NOT NULL,
	idkpi			INT UNSIGNED	NOT NULL,
    objetivo		VARCHAR(100)	NOT NULL,
    avaliacao		ENUM('0','1','2','3','4','5')	NOT NULL,
	CONSTRAINT pk_kpiavaliado_ano_idavaliado_idkpi		PRIMARY KEY (ano, idavaliado, idkpi),
    -- CONSTRAINT fk_kpiavalaido_ano				FOREIGN KEY(ano) 	REFERENCES avaliacoesdesempenho(ano),
    -- CONSTRAINT fk_kpiavalaido_idfuncionario		FOREIGN KEY(idfuncionario) 	REFERENCES avaliacoesdesempenho(idfuncionario),
    CONSTRAINT fk_kpiavalaido_ano				FOREIGN KEY(ano, idavaliado) 	REFERENCES avaliacoesdesempenho(ano, idavaliado),
    CONSTRAINT fk_kpiavalaido_idkapi			FOREIGN KEY(idkpi)	 	REFERENCES kpis(idkpi)
)engine=innoDB;