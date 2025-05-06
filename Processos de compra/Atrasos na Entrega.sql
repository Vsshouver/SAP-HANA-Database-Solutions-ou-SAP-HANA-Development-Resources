SELECT
    T0.DocNum AS "Nº Pedido",
    T0.CardCode AS "Cód. Fornecedor",
    T0.CardName AS "Fornecedor",
    T1.ItemCode AS "Cód. Item",
    T2.ItemName AS "Descrição",
    T0.DocDueDate AS "Data Prevista",
    CURRENT_DATE AS "Data Atual",
    DATEDIFF(DAY, T0.DocDueDate, CURRENT_DATE) AS "Dias de Atraso",
    T1.OpenQty AS "Qtd. Pendente"
FROM OPOR T0
INNER JOIN POR1 T1 ON T0.DocEntry = T1.DocEntry
INNER JOIN OITM T2 ON T1.ItemCode = T2.ItemCode
WHERE T1.OpenQty > 0
AND T0.DocDueDate < CURRENT_DATE
ORDER BY "Dias de Atraso" DESC
