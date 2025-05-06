SELECT
    T0.CardCode AS "Cód. Fornecedor",
    T0.CardName AS "Fornecedor",
    COUNT(DISTINCT T1.DocEntry) AS "Qtd. Pedidos",
    SUM(T1.LineTotal) AS "Volume Comprado",
    ROUND(SUM(T1.LineTotal) / (SELECT SUM(LineTotal) FROM POR1 
                               WHERE DocDate BETWEEN '[Ano]-01-01' AND '[Ano]-12-31'), 4) * 100 AS "% do Total"
FROM OPOR T0
INNER JOIN POR1 T1 ON T0.DocEntry = T1.DocEntry
WHERE T1.DocDate BETWEEN '[Ano]-01-01' AND '[Ano]-12-31'
GROUP BY T0.CardCode, T0.CardName
ORDER BY "Volume Comprado" DESC
FETCH FIRST 10 ROWS ONLY
