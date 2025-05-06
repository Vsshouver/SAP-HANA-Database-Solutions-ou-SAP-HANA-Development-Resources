SELECT
    T0.DocNum AS "Nº Pedido",
    T0.DocDate AS "Data Pedido",
    T0.CardName AS "Fornecedor",
    T1.ItemCode AS "Cód. Item",
    T1.Quantity AS "Qtd. Pedida",
    T1.OpenQty AS "Qtd. Pendente",
    (SELECT SUM(Quantity) FROM PDN1 
     WHERE BaseEntry = T0.DocEntry AND BaseLine = T1.LineNum) AS "Qtd. Recebida"
FROM OPOR T0
INNER JOIN POR1 T1 ON T0.DocEntry = T1.DocEntry
WHERE T1.OpenQty > 0
ORDER BY T0.DocDate
