SELECT
    T0.ItemCode,
    T0.ItemName,
    SUM(T1.Quantity) AS "Quantidade Total",
    SUM(T1.LineTotal) AS "Valor Total",
    ROUND(SUM(T1.LineTotal) / (SELECT SUM(LineTotal) FROM INV1) * 100, 2) AS "Percentual",
    CASE
        WHEN SUM(T1.LineTotal) / (SELECT SUM(LineTotal) FROM INV1) >= 0.8 THEN 'A'
        WHEN SUM(T1.LineTotal) / (SELECT SUM(LineTotal) FROM INV1) >= 0.15 THEN 'B'
        ELSE 'C'
    END AS "Classificação ABC"
FROM OITM T0
INNER JOIN INV1 T1 ON T0.ItemCode = T1.ItemCode
WHERE T1.DocDate BETWEEN '[DataInicial]' AND '[DataFinal]'
GROUP BY T0.ItemCode, T0.ItemName
ORDER BY "Valor Total" DESC
