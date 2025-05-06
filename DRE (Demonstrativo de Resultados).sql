SELECT
    'Receita de Vendas' AS "Conta",
    SUM(T1.LineTotal) AS "Valor"
FROM OINV T0
INNER JOIN INV1 T1 ON T0.DocEntry = T1.DocEntry
WHERE T0.Canceled = 'N'
AND T0.DocDate BETWEEN '[DataInicial]' AND '[DataFinal]'

UNION ALL

SELECT
    'Custo das Vendas' AS "Conta",
    SUM(T1.Quantity * T0.AvgPrice) * -1 AS "Valor"
FROM OITM T0
INNER JOIN INV1 T1 ON T0.ItemCode = T1.ItemCode
INNER JOIN OINV T2 ON T1.DocEntry = T2.DocEntry
WHERE T2.Canceled = 'N'
AND T2.DocDate BETWEEN '[DataInicial]' AND '[DataFinal]'

UNION ALL

SELECT
    'Despesas Operacionais' AS "Conta",
    SUM(T1.LineTotal) * -1 AS "Valor"
FROM OPCH T0
INNER JOIN PCH1 T1 ON T0.DocEntry = T1.DocEntry
INNER JOIN PCH12 T2 ON T0.DocEntry = T2.DocEntry
WHERE T2.AcctCode LIKE '6%' -- Códigos de conta de despesa
AND T0.DocDate BETWEEN '[DataInicial]' AND '[DataFinal]'
