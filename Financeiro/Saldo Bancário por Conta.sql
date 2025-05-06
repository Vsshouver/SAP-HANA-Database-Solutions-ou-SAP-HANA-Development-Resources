SELECT
    T0.AcctCode AS "Cód. Conta",
    T0.AcctName AS "Conta Bancária",
    (SELECT SUM(Debit) - SUM(Credit) FROM JDT1 
     WHERE Account = T0.AcctCode
     AND RefDate <= CURRENT_DATE) AS "Saldo Atual",
     
    (SELECT SUM(Debit) - SUM(Credit) FROM JDT1 
     WHERE Account = T0.AcctCode
     AND Reconciled = 'Y'
     AND RefDate <= CURRENT_DATE) AS "Saldo Conciliado"
FROM OACT T0
WHERE T0.AcctType = 'B' -- Contas bancárias
ORDER BY "Saldo Atual" DESC
