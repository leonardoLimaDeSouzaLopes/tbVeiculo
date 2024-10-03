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