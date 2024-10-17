CREATE DATABASE bdBanco
GO 

CREATE TABLE tbCliente (
	codCliente INT PRIMARY KEY IDENTITY(1,1)
	, nomeCliente VARCHAR (90)
	, cpfCliente CHAR (11)
)

CREATE TABLE tbContaCorrente (
	codConta INT PRIMARY KEY IDENTITY(1,1)
	, numConta INT
	, saldo