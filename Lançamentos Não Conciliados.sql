SELECT
    T0.TransId AS "ID Lançamento",
    T0.RefDate AS "Data",
    T0.Memo AS "Descrição",
    T0.Debit - T0.Credit AS "Valor",
    T1.AcctName AS "Conta Bancária"
FROM JDT1 T0
INNER JOIN OACT T1 ON T0.Account = T1.AcctCode
WHERE T0.Reconciled = 'N'
AND T1.AcctType = 'B'
AND T0.RefDate <= CURRENT_DATE
ORDER BY T0.RefDate
