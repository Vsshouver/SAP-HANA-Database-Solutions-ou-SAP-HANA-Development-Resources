SELECT
    -- Dados da Solicitação
    T0."DocNum"                           AS "Nº Solicitação",
    T0."DocDate"                          AS "Data Solicitação",
    T0."Requester"                        AS "Solicitante",
    T0."Comments"                         AS "Observação",
    OBPL."BPLName"                        AS "Empresa",
    CASE 
        WHEN T0."DocStatus" = 'O' THEN 'Aberta'
        WHEN T0."DocStatus" = 'C' THEN 'Fechada'
    END                                   AS "Status Solicitação",
    CASE 
        WHEN T0."CANCELED" = 'Y' THEN 'Sim'
        ELSE 'Não'
    END                                   AS "Cancelado?",

    -- Linhas da Solicitação
    T1."LineNum"                          AS "Linha",
    CASE 
        WHEN T1."LineStatus" = 'O' THEN 'Aberta'
        ELSE 'Fechada'
    END                                   AS "Status Linha",
    T1."ItemCode"                         AS "Código Item",
    T1."Dscription"                       AS "Descrição",
    T1."Quantity"                         AS "Qtd Solicitada",
    T1."OpenQty"                          AS "Qtd em Aberto",
    T1."Price"                            AS "Preço Estimado",
    T1."U_RBH_TAG"                        AS "TAG",
    T1."WhsCode"                          AS "Depósito",
    T1."OcrCode"                          AS "Cod CC",
    T5."OcrName"                          AS "Centro de Custo",

    -- Referências de documentos vinculados
    OC."DocNum"                           AS "Nº Cotação",
    QUT."DocNum"                          AS "Nº Requisição de Cotação",
    PO."DocNum"                           AS "Nº Pedido",

    -- Nota Fiscal de Entrada
    NF."DocNum"                           AS "Nº Nota Fiscal",
    NF."DocDate"                          AS "Data Nota Fiscal",
    NF."DocTotal"                         AS "Total Nota Fiscal"

FROM OPRQ T0
INNER JOIN PRQ1 T1 ON T0."DocEntry" = T1."DocEntry"
LEFT JOIN OOCR T5 ON T1."OcrCode" = T5."OcrCode"
LEFT JOIN OBPL ON T0."BPLId" = OBPL."BPLId"

-- Junções para recuperar apenas os números dos documentos relacionados
LEFT JOIN PQT1 OC1 
    ON OC1."BaseType" = 1470000113 
    AND OC1."BaseEntry" = T1."DocEntry" 
    AND OC1."BaseLine" = T1."LineNum"
LEFT JOIN OPQT OC 
    ON OC."DocEntry" = OC1."DocEntry"

LEFT JOIN OQUT QUT 
    ON QUT."DocEntry" = OC1."TrgetEntry" 
    AND OC1."TargetType" = 540000006

LEFT JOIN POR1 PO1 
    ON PO1."BaseType" = 1470000113 
    AND PO1."BaseEntry" = T1."DocEntry" 
    AND PO1."BaseLine" = T1."LineNum"
LEFT JOIN OPOR PO 
    ON PO."DocEntry" = PO1."DocEntry"

-- Nota Fiscal de Entrada vinculada ao Pedido
LEFT JOIN PCH1 NF1 
    ON NF1."BaseType" = 22 -- Pedido de Compra
    AND NF1."BaseEntry" = PO1."DocEntry"
    AND NF1."BaseLine" = PO1."LineNum"
LEFT JOIN OPCH NF 
    ON NF."DocEntry" = NF1."DocEntry"

WHERE
    T0."DocDate" BETWEEN [%0] AND [%1]

ORDER BY
    T0."DocDate", T0."DocNum", T1."LineNum";
