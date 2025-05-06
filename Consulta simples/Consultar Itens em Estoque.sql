SELECT 
    T0.ItemCode AS "Cód. Item",
    T0.ItemName AS "Descrição",
    T1.WhsCode AS "Depósito",
    T1.OnHand AS "Estoque Disponível"
FROM OITM T0
INNER JOIN OITW T1 ON T0.ItemCode = T1.ItemCode
WHERE T1.OnHand > 0
ORDER BY T1.OnHand DESC
