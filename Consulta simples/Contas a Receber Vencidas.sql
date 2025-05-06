SELECT
    T0.CardCode AS "Cód. Cliente",
    T0.CardName AS "Cliente",
    T1.DocNum AS "Nº Doc.",
    T1.DocDate AS "Data Doc.",
    T1.DocDueDate AS "Vencimento",
    T1.DocTotal AS "Valor",
    DATEDIFF(DAY, T1.DocDueDate, CURRENT_DATE) AS "Dias Atraso"
FROM OCRD T0
INNER JOIN OINV T1 ON T0.CardCode = T1.CardCode
WHERE T1.DocStatus = 'O' -- Aberto
AND T1.DocDueDate < CURRENT_DATE
ORDER BY "Dias Atraso" DESC
