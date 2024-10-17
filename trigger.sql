USE bdVeiculos

CREATE TRIGGER tgInsertMulta
	ON tbMultas
	FOR INSERT
	AS 
	BEGIN

		DECLARE @pontosMulta INT
		DECLARE @idMotorista INT

		SELECT @idMotorista = tbMotorista.idMotorista, @pontosMulta = pontosMulta FROM INSERTED
		INNER JOIN tbVeiculo ON tbVeiculo.idVeiculo = INSERTED.idVeiculo
		INNER JOIN tbMotorista ON tbMotorista.idMotorista = tbVeiculo.idMotorista
		
		DECLARE @pontuacaoAcumulada INT

		UPDATE tbMotorista
		SET pontuacaoAcumulada += @pontosMulta, @pontuacaoAcumulada = pontuacaoAcumulada
		WHERE idMotorista = @idMotorista

		IF (@pontuacaoAcumulada >= 20)
		BEGIN
			PRINT ('voce alcancou 20 pontos podera ter sua habilitação suspensa.')
		END

	END

INSERT INTO tbMotorista (nomeMotorista, pontuacaoAcumulada)
VALUES('JOJ', 0)

SELECT * FROM tbMotorista

INSERT INTO tbVeiculo (modeloVeiculo, idMotorista)
VALUES('Fusca', 1)

SELECT * FROM tbVeiculo

INSERT INTO tbMultas (pontosMulta, idVeiculo)
VALUES(3, 1)

SELECT * FROM tbMultas

--2
USE bdBanco

--a
CREATE TRIGGER tgDepositoInsert
ON tbDeposito FOR INSERT
AS

	DECLARE @valorDeposito MONEY , @codConta INT

	SET @valorDeposito = (SELECT valorDeposito FROM INSERTED)

	SELECT @codConta = codConta FROM INSERTED

	UPDATE tbContaCorrente
	SET saldoConta = saldoConta + @valorDeposito
	WHERE codConta = @codConta

--b
CREATE TRIGGER tgSaqueInsert
ON tbSaque FOR INSERT
AS
	DECLARE @valorSaque MONEY ,  @codConta INT

	SET @valorSaque = (SELECT valorSaque FROM INSERTED)

	SELECT @codConta = codConta FROM INSERTED

	IF @valorSaque > (SELECT saldoConta FROM tbContaCorrente)

	BEGIN
		PRINT('O valor do saque eh maior que o saldo autal')
	END

	IF (SELECT saldoConta FROM tbContaCorrente) = 0 --Verifica se a conta tem saldo
		
	BEGIN
		PRINT('Sem saldo, operacao interrompida')
	END

	ELSE
		BEGIN
			UPDATE tbContaCorrente
			SET saldoConta = saldoConta -@valorSaque
			WHERE codConta = @codConta

			PRINT('Operacao concluida com exito')
		END
