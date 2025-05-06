SELECT 
    T0.CardCode AS "Cód. Cliente",
    T0.CardName AS "Cliente",
    SUM(T1.LineTotal) AS "Total Faturado"
FROM OINV T0
INNER JOIN INV1 T1 ON T0.DocEntry = T1.DocEntry
WHERE T0.DocDate >= ADD_DAYS(CURRENT_DATE, -30)
GROUP BY T0.CardCode, T0.CardName
ORDER BY "Total Faturado" DESC
