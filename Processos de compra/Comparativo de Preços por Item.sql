SELECT
    T0.ItemCode AS "Cód. Item",
    T0.ItemName AS "Descrição",
    T1.CardName AS "Fornecedor",
    T2.Price AS "Último Preço",
    T2.DocDate AS "Data Última Compra",
    (SELECT AVG(Price) FROM POR1 
     INNER JOIN OPOR ON POR1.DocEntry = OPOR.DocEntry
     WHERE ItemCode = T0.ItemCode
     AND DocDate BETWEEN ADD_MONTHS(CURRENT_DATE, -12) AND CURRENT_DATE) AS "Preço Médio 12M"
FROM OITM T0
INNER JOIN POR1 T2 ON T0.ItemCode = T2.ItemCode
INNER JOIN OPOR T1 ON T2.DocEntry = T1.DocEntry
WHERE T2.DocEntry IN (SELECT MAX(DocEntry) FROM POR1 
                      WHERE ItemCode = T0.ItemCode
                      GROUP BY ItemCode)
ORDER BY T0.ItemCode
