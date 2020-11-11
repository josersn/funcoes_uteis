CREATE DEFINER=`root`@`%` FUNCTION `dataUtilTicket`( data datetime, qtdeDias int ) RETURNS datetime
    DETERMINISTIC
BEGIN

DECLARE selected datetime;
DECLARE dataFinal datetime;
DECLARE diasemana int;
DECLARE contador int;
DECLARE dia int;

SET selected = data;
SET diasemana = DAYOFWEEK(selected);
SET contador = 0;

 WHILE (DAYOFWEEK(selected) =1 or DAYOFWEEK(selected)=7 or (SELECT COUNT(*) FROM Feriado WHERE dtFeriado = SUBSTRING(selected, 1, 10)) > 0) DO
		SET selected = DATE_ADD(selected, INTERVAL 1 DAY);
	END WHILE;    

WHILE (contador < qtdeDias) DO
	SET selected = DATE_ADD(selected, INTERVAL 1 DAY);
    WHILE (DAYOFWEEK(selected) =1 or DAYOFWEEK(selected)=7 or (SELECT COUNT(*) FROM Feriado WHERE dtFeriado = SUBSTRING(selected, 1, 10)) > 0) DO
		SET selected = DATE_ADD(selected, INTERVAL 1 DAY);
	END WHILE;
	SET contador = contador + 1;	
END WHILE;
  

RETURN date_format(selected,'%Y-%m-%d %H:%i:%s');
END