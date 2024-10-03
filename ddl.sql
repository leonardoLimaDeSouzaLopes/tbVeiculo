CREATE DATABASE bdVeiculos
GO

--USE master
--DROP DATABASE bdVeiculo

USE bdVeiculos

CREATE TABLE tbMotorista (
	idMotorista INT PRIMARY KEY IDENTITY(1,1)
	, nomeMotorista VARCHAR(50)
	, dataNascimentoMotorista DATE
	, cpfMotorista CHAR(11)
	, CNHMotorista CHAR(9)
	, pontuacaoAcumulada INT
)

CREATE TABLE tbVeiculo (
	idVeiculo INT PRIMARY KEY IDENTITY(1,1)
	, modeloVeiculo VARCHAR(50)
	, placa VARCHAR(7)
	, renavam VARCHAR(11)
	, anoVeiculo DATE
	, idMotorista INT FOREIGN KEY REFERENCES tbMotorista(idMotorista)
)

CREATE TABLE tbMultas (
	idMultas INT PRIMARY KEY IDENTITY(1,1)
	, dataMulta DATE
	, horaMulta TIME
	, pontosMulta INT
	, idVeiculo INT FOREIGN KEY REFERENCES tbVeiculo(idVeiculo)
)