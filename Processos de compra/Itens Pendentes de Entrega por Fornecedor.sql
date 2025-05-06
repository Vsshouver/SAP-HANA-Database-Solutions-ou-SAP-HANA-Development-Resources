SELECT
    T0.CardCode AS "Cód. Fornecedor",
    T0.CardName AS "Fornecedor",
    T1.ItemCode AS "Cód. Item",
    T2.ItemName AS "Descrição",
    SUM(T1.OpenQty) AS "Quantidade Pendente",
    T1.Price AS "Preço Unitário",
    SUM(T1.OpenQty * T1.Price) AS "Total Pendente"
FROM OPOR T0
INNER JOIN POR1 T1 ON T0.DocEntry = T1.DocEntry
INNER JOIN OITM T2 ON T1.ItemCode = T2.ItemCode
WHERE T1.OpenQty > 0
GROUP BY T0.CardCode, T0.CardName, T1.ItemCode, T2.ItemName, T1.Price
ORDER BY "Total Pendente" DESC
