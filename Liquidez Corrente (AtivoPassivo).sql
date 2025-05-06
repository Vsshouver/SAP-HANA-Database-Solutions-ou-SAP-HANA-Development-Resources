SELECT
    (SELECT SUM(Debit) - SUM(Credit) FROM JDT1 
     WHERE Account LIKE '1%' -- Ativo Circulante
     AND RefDate <= CURRENT_DATE) AS "Ativo Circulante",
     
    (SELECT SUM(Credit) - SUM(Debit) FROM JDT1 
     WHERE Account LIKE '2%' -- Passivo Circulante
     AND RefDate <= CURRENT_DATE) AS "Passivo Circulante",
     
    (SELECT "Ativo Circulante" / NULLIF("Passivo Circulante", 0)) AS "Índice Liquidez"
FROM DUMMY
