SELECT
    'Contas a Receber' AS "Tipo",
    T0.DocNum AS "Documento",
    T0.CardCode AS "Cód. Parceiro",
    T0.CardName AS "Parceiro",
    T0.DocDueDate AS "Vencimento",
    T0.DocTotal AS "Valor"
FROM OINV T0
WHERE T0.DocStatus = 'O'
AND T0.DocDueDate BETWEEN CURRENT_DATE AND ADD_DAYS(CURRENT_DATE, 30)

UNION ALL

SELECT
    'Contas a Pagar' AS "Tipo",
    T0.DocNum AS "Documento",
    T0.CardCode AS "Cód. Parceiro",
    T0.CardName AS "Parceiro",
    T0.DocDueDate AS "Vencimento",
    T0.DocTotal * -1 AS "Valor"
FROM OPCH T0
WHERE T0.DocStatus = 'O'
AND T0.DocDueDate BETWEEN CURRENT_DATE AND ADD_DAYS(CURRENT_DATE, 30)

ORDER BY "Vencimento"
