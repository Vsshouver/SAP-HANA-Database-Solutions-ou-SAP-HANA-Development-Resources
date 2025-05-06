SELECT 
    T0.ItemCode AS "Cód. Item",
    T0.ItemName AS "Descrição",
    SUM(T1.Quantity) AS "Qtd. Vendida",
    SUM(T1.LineTotal) AS "Venda Bruta",
    SUM(T1.LineTotal - (T1.Quantity * T0.AvgPrice)) AS "Margem"
FROM OITM T0
INNER JOIN INV1 T1 ON T0.ItemCode = T1.ItemCode
INNER JOIN OINV T2 ON T1.DocEntry = T2.DocEntry
WHERE T2.DocDate BETWEEN '[DataInicial]' AND '[DataFinal]'
GROUP BY T0.ItemCode, T0.ItemName
ORDER BY "Margem" DESC
