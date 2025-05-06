SELECT 
    T0.DocNum AS "Nº Documento",
    T0.DocDate AS "Data",
    T0.CardCode AS "Cód. Cliente",
    T0.CardName AS "Cliente",
    T0.DocTotal AS "Total"
FROM ORDR T0
WHERE T0.DocStatus = 'O' -- 'O' para aberto
ORDER BY T0.DocDate DESC
