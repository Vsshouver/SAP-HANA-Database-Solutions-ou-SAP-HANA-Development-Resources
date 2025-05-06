SELECT 
    T0.DocNum AS "Nº Pedido",
    T0.DocDate AS "Data",
    T0.CardCode AS "Cód. Fornecedor",
    T0.CardName AS "Fornecedor",
    T0.DocDueDate AS "Entrega Prevista",
    T0.DocTotal AS "Total",
    T0.Comments AS "Observações"
FROM OPOR T0
WHERE T0.DocStatus = 'O' -- 'O' para aberto
ORDER BY T0.DocDueDate
