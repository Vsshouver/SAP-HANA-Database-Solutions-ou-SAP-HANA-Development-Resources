SELECT
    T0.DocNum AS "Nº Requisição",
    T0.ReqDate AS "Data",
    T0.ReqName AS "Solicitante",
    T1.ItemCode AS "Cód. Item",
    T2.ItemName AS "Descrição",
    T1.Quantity AS "Quantidade",
    T0.Comments AS "Justificativa"
FROM OPRQ T0
INNER JOIN PRQ1 T1 ON T0.DocEntry = T1.DocEntry
INNER JOIN OITM T2 ON T1.ItemCode = T2.ItemCode
WHERE T0.DocStatus = 'P' -- 'P' para pendente
ORDER BY T0.ReqDate
