SELECT
    NVL("Copy_of_CV_CS_MERGED"."Source_System",'')::VarChar(256) AS "Source_System",
    NVL(CASE 
        WHEN "ARRPRD_CV_CS_MERGED"."Product_Group" = 'Checking Products' THEN 'DDA'
    END,'')::VarChar(256) AS "Product_Group", 
    NVL(CASE 
        WHEN 
            "ARRPRD_CV_CS_MERGED"."Product_Group_Code" IN ( 
                'CHK_PD', 
                'SVG_PD', 
                'TM_PD', 
                'LOAN_PD', 
                'SAFE_DEP_PD', 
                '6' )
            THEN
                LPAD("ACCTARR_ACCOUNT_ARRANGEMENT"."ACCOUNT_NUMBER", 12, '0')
        ELSE "ACCTARR_ACCOUNT_ARRANGEMENT"."ACCOUNT_NUMBER"
    END,'')::VarChar(256) AS "Account_Number", 
    NVL(to_number("ACCTARRTRANS_TRANSACTION"."TRANSACTION_AMOUNT_1", '999999999999999D99'),'')::VARCHAR(18) AS "Transaction_Amount_1",
    "ACCTARRTRANS_TRANSACTION"."TRANSACTION_VALUE_DATE" AS "Transaction_Posting_Date", 
    NVL(TRIM(BOTH FROM TRIM(BOTH FROM Trim(BOTH FROM "ACCTARRTRANS_TRANSACTION"."DESCRIPTION_1") || ' ' || Trim(BOTH FROM "ACCTARRTRANS_TRANSACTION"."DESCRIPTION_2")) || ' ' || TRIM(BOTH FROM "ACCTARRTRANS_TRANSACTION"."DESCRIPTION_3")),'')::VarChar(256) AS "Transaction_Description", 
    NVL("ACCTARRTRANS_TRANSACTION"."INTERNAL_TRANSACTION_CODE",'')::VarChar(256) AS "Transaction_Code_Internal", 
    "ACCTARRTRANS_TRANSACTION"."TRANSACTION_ID" AS "Transaction_ID", 
    ''::VarChar(256) AS "BLANK_FIELD", 
    NVL("ARRRSC_ACCTARRTRANS_TRANSACTION_ARRRSC_ACCTARRTRANS_DD_TRANSACTION_TYPE_Copy__4__of_CV_CS_MERGED2"."Debit_Card_Used_in_Transaction",'') AS "Debit_Card_Used_in_Transaction", 
    ''::VarChar(256) AS "Card_Processor_Tran_ID", 
    "ACCTARRTRANS_TRANSACTION"."SERIAL_CHECK_NUMBER" AS "Serial_or_Check_Number"
FROM
    "DBDATA"."ADMIN"."CUSTOMER" "CUSTOMER0"
        INNER JOIN 
        (
        SELECT
            "INVOLVED_PARTY"."INVOLVED_PARTY_ID" AS "INVOLVED_PARTY_ID", 
            "INVOLVED_PARTY"."SOURCE_SYSTEM_ID" AS "SOURCE_SYSTEM_ID"
        FROM
            "DBDATA"."ADMIN"."INVOLVED_PARTY" "INVOLVED_PARTY" 
        WHERE 
            "INVOLVED_PARTY"."END_DATE" IS NULL
        ) "INVOLVED_PARTY0"
        ON "CUSTOMER0"."CUSTOMER_ID" = "INVOLVED_PARTY0"."INVOLVED_PARTY_ID"
            INNER JOIN "DBDATA"."ADMIN"."PROCESSING_DATES" "Copy_of_PROCESSING_DATES"
            ON CAST(-1 AS INTEGER) <> "INVOLVED_PARTY0"."INVOLVED_PARTY_ID"
                INNER JOIN 
                (
                SELECT
                    "CLASSIFICATION_VALUE0"."CLASSIFICATION_NAME" AS "Source_System", 
                    "CLASSIFICATION_VALUE0"."CLASSIFICATION_ID" AS "CV_CLASSIFICATION_ID"
                FROM
                    "DBDATA"."ADMIN"."CLASSIFICATION_VALUE" "CLASSIFICATION_VALUE0"
                        INNER JOIN "DBDATA"."ADMIN"."CLASSIFICATION_SCHEME" "CLASSIFICATION_SCHEME0"
                        ON "CLASSIFICATION_VALUE0"."CLASSIFICATION_SCHEME_ID" = "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_ID" 
                WHERE 
                    "CLASSIFICATION_VALUE0"."END_DATE" IS NULL AND
                    "CLASSIFICATION_SCHEME0"."END_DATE" IS NULL AND
                    "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_NAME" = 'SOURCE_SYSTEM'
                ) "Copy_of_CV_CS_MERGED"
                ON "INVOLVED_PARTY0"."SOURCE_SYSTEM_ID" = "Copy_of_CV_CS_MERGED"."CV_CLASSIFICATION_ID"
                    LEFT OUTER JOIN 
                    "DBDATA"."ADMIN"."ACCOUNT_ARRANGEMENT" "ACCTARR_ACCOUNT_ARRANGEMENT"
                        INNER JOIN 
                        (
                        SELECT
                            "ARRANGEMENT0"."ARRANGEMENT_ID" AS "ARRANGEMENT_ID"
                        FROM
                            "DBDATA"."ADMIN"."ARRANGEMENT" "ARRANGEMENT0"
                                LEFT OUTER JOIN 
                                (
                                SELECT
                                    "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."ARRANGEMENT_ID" AS "ARRANGEMENT_ID", 
                                    "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."CLASSIFICATION_SCHEME_ID" AS "CLASSIFICATION_SCHEME_ID", 
                                    "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."ARRANGEMENT_X_CLASSIFICATION_RLTNP_TYPE_ID" AS "ARRANGEMENT_X_CLASSIFICATION_RLTNP_TYPE_ID", 
                                    "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."EFFECTIVE_DATE" AS "EFFECTIVE_DATE", 
                                    "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."RANK" AS "RANK0", 
                                    "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."POPULATION_DATE" AS "POPULATION_DATE", 
                                    "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."POPULATION_TIME" AS "POPULATION_TIME", 
                                    "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."CLASSIFICATION_ID" AS "CLASSIFICATION_ID", 
                                    "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."END_DATE" AS "END_DATE", 
                                    "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."DESCRIPTION" AS "DESCRIPTION", 
                                    "Copy_of_IP_CLASSIFICATION_VALUE"."CLASSIFICATION_ID" AS "CV_CLASSIFICATION_ID", 
                                    "Copy_of_IP_CLASSIFICATION_VALUE"."POPULATION_DATE" AS "CV_POPULATION_DATE", 
                                    "Copy_of_IP_CLASSIFICATION_VALUE"."POPULATION_TIME" AS "CV_POPULATION_TIME", 
                                    "Copy_of_IP_CLASSIFICATION_VALUE"."CLASSIFICATION_SCHEME_ID" AS "CV_CLASSIFICATION_SCHEME_ID", 
                                    "Copy_of_IP_CLASSIFICATION_VALUE"."CLASSIFICATION_NAME" AS "CV_The_Value_CLASSIFICATION_NAME", 
                                    "Copy_of_IP_CLASSIFICATION_VALUE"."CLASSIFICATION_CODE" AS "CV_CLASSIFICATION_CODE", 
                                    "Copy_of_IP_CLASSIFICATION_VALUE"."DESCRIPTION" AS "CV_DESCRIPTION", 
                                    "Copy_of_IP_CLASSIFICATION_VALUE"."EFFECTIVE_DATE" AS "CV_EFFECTIVE_DATE", 
                                    "Copy_of_IP_CLASSIFICATION_VALUE"."END_DATE" AS "CV_END_DATE", 
                                    "Copy_of_IP_CLASSIFICATION_VALUE"."PARENT_CLASSIFICATION_ID" AS "CV_PARENT_CLASSIFICATION_ID", 
                                    "Copy_of_IP_CLASSIFICATION_VALUE"."CLASSIFICATION_VALUE_SHORT_NAME" AS "CV_CLASSIFICATION_VALUE_SHORT_NAME", 
                                    "Copy_of_IP_CLASSIFICATION_SCHEME"."CLASSIFICATION_SCHEME_ID" AS "CS_CLASSIFICATION_SCHEME_ID", 
                                    "Copy_of_IP_CLASSIFICATION_SCHEME"."POPULATION_DATE" AS "CS_POPULATION_DATE", 
                                    "Copy_of_IP_CLASSIFICATION_SCHEME"."POPULATION_TIME" AS "CS_POPULATION_TIME", 
                                    "Copy_of_IP_CLASSIFICATION_SCHEME"."CLASSIFICATION_SCHEME_NAME" AS "CS_CLASSIFICATION_SCHEME_NAME", 
                                    "Copy_of_IP_CLASSIFICATION_SCHEME"."EFFECTIVE_DATE" AS "CS_EFFECTIVE_DATE", 
                                    "Copy_of_IP_CLASSIFICATION_SCHEME"."END_DATE" AS "CS_END_DATE", 
                                    "Copy_of_IP_CLASSIFICATION_SCHEME"."CLASSIFICATION_SCHEME_SHORT_NAME" AS "CS_CLASSIFICATION_SCHEME_SHORT_NAME"
                                FROM
                                    "DBDATA"."ADMIN"."ARRANGEMENT_X_CLASSIFICATION_RLTNP" "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"
                                        INNER JOIN "DBDATA"."ADMIN"."CLASSIFICATION_SCHEME" "Copy_of_IP_CLASSIFICATION_SCHEME"
                                        ON "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."CLASSIFICATION_SCHEME_ID" = "Copy_of_IP_CLASSIFICATION_SCHEME"."CLASSIFICATION_SCHEME_ID"
                                            INNER JOIN "DBDATA"."ADMIN"."CLASSIFICATION_VALUE" "Copy_of_IP_CLASSIFICATION_VALUE"
                                            ON "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."CLASSIFICATION_ID" = "Copy_of_IP_CLASSIFICATION_VALUE"."CLASSIFICATION_ID" 
                                WHERE 
                                    "Copy_of_IP_CLASSIFICATION_SCHEME"."CLASSIFICATION_SCHEME_NAME" = 'EMPLOYMENT_POSITION_TYPE' AND
                                    "ARRANGEMENT_X_CLASSIFICATION_RLTNP0"."END_DATE" IS NULL
                                ) "Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"
                                ON "ARRANGEMENT0"."ARRANGEMENT_ID" = "Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"."ARRANGEMENT_ID" 
                        WHERE 
                            "Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"."END_DATE" IS NULL AND
                            "Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"."CV_END_DATE" IS NULL AND
                            "Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"."CS_END_DATE" IS NULL AND
                            ("Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"."CV_CLASSIFICATION_CODE" = '' OR
                            "Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"."CV_CLASSIFICATION_CODE" IS NULL OR
                            "Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"."CV_CLASSIFICATION_CODE" <> 'ANYTINGASDF' OR
                            "Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"."CV_CLASSIFICATION_CODE" IS NULL)
                        ) "Copy_of_ARRANGEMENT_Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"
                        ON "ACCTARR_ACCOUNT_ARRANGEMENT"."ACCOUNT_ARRANGEMENT_ID" = "Copy_of_ARRANGEMENT_Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"."ARRANGEMENT_ID"
                            INNER JOIN 
                            (
                            SELECT
                                "ARRANGEMENT"."ARRANGEMENT_ID" AS "ARRANGEMENT_ID"
                            FROM
                                "DBDATA"."ADMIN"."ARRANGEMENT" "ARRANGEMENT" 
                            WHERE 
                                "ARRANGEMENT"."END_DATE" IS NULL
                            ) "ARR_ARRANGEMENT"
                            ON "ARR_ARRANGEMENT"."ARRANGEMENT_ID" = "ACCTARR_ACCOUNT_ARRANGEMENT"."ACCOUNT_ARRANGEMENT_ID"
                                INNER JOIN 
                                (
                                SELECT
                                    "ARRANGEMENT_X_INVOLVED_PARTY_RLTNP0"."ARRANGEMENT_ID" AS "ARRANGEMENT_ID", 
                                    "ARRANGEMENT_X_INVOLVED_PARTY_RLTNP0"."INVOLVED_PARTY_ID" AS "INVOLVED_PARTY_ID", 
                                    "ARRANGEMENT_X_INVOLVED_PARTY_RLTNP0"."CUSTOMER_OWNER_RELATIONSHIP_TYPE_ID" AS "CUSTOMER_OWNER_RELATIONSHIP_TYPE_ID"
                                FROM
                                    (
                                    SELECT
                                        "CLASSIFICATION_VALUE0"."CLASSIFICATION_ID" AS "CV_CLASSIFICATION_ID", 
                                        "CLASSIFICATION_VALUE0"."POPULATION_DATE" AS "CV_POPULATION_DATE", 
                                        "CLASSIFICATION_VALUE0"."POPULATION_TIME" AS "CV_POPULATION_TIME", 
                                        "CLASSIFICATION_VALUE0"."CLASSIFICATION_SCHEME_ID" AS "CV_CLASSIFICATION_SCHEME_ID", 
                                        "CLASSIFICATION_VALUE0"."CLASSIFICATION_NAME" AS "CV_The_Value_CLASSIFICATION_NAME", 
                                        "CLASSIFICATION_VALUE0"."CLASSIFICATION_CODE" AS "CV_CLASSIFICATION_CODE", 
                                        "CLASSIFICATION_VALUE0"."DESCRIPTION" AS "CV_DESCRIPTION", 
                                        "CLASSIFICATION_VALUE0"."EFFECTIVE_DATE" AS "CV_EFFECTIVE_DATE", 
                                        "CLASSIFICATION_VALUE0"."END_DATE" AS "CV_END_DATE", 
                                        "CLASSIFICATION_VALUE0"."PARENT_CLASSIFICATION_ID" AS "CV_PARENT_CLASSIFICATION_ID", 
                                        "CLASSIFICATION_VALUE0"."CLASSIFICATION_VALUE_SHORT_NAME" AS "CV_CLASSIFICATION_VALUE_SHORT_NAME", 
                                        "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_ID" AS "CS_CLASSIFICATION_SCHEME_ID", 
                                        "CLASSIFICATION_SCHEME0"."POPULATION_DATE" AS "CS_POPULATION_DATE", 
                                        "CLASSIFICATION_SCHEME0"."POPULATION_TIME" AS "CS_POPULATION_TIME", 
                                        "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_NAME" AS "CS_CLASSIFICATION_SCHEME_NAME", 
                                        "CLASSIFICATION_SCHEME0"."EFFECTIVE_DATE" AS "CS_EFFECTIVE_DATE", 
                                        "CLASSIFICATION_SCHEME0"."END_DATE" AS "CS_END_DATE", 
                                        "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_SHORT_NAME" AS "CS_CLASSIFICATION_SCHEME_SHORT_NAME"
                                    FROM
                                        "DBDATA"."ADMIN"."CLASSIFICATION_VALUE" "CLASSIFICATION_VALUE0"
                                            INNER JOIN "DBDATA"."ADMIN"."CLASSIFICATION_SCHEME" "CLASSIFICATION_SCHEME0"
                                            ON "CLASSIFICATION_VALUE0"."CLASSIFICATION_SCHEME_ID" = "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_ID"
                                    ) "Type_IDs_CLASSIFICATION_VALUE"
                                        INNER JOIN "DBDATA"."ADMIN"."ARRANGEMENT_X_INVOLVED_PARTY_RLTNP" "ARRANGEMENT_X_INVOLVED_PARTY_RLTNP0"
                                        ON "Type_IDs_CLASSIFICATION_VALUE"."CV_CLASSIFICATION_ID" = "ARRANGEMENT_X_INVOLVED_PARTY_RLTNP0"."ARRANGEMENT_X_INVOLVED_PARTY_RLTNP_TYPE_ID" 
                                WHERE 
                                    "ARRANGEMENT_X_INVOLVED_PARTY_RLTNP0"."END_DATE" IS NULL AND
                                    "Type_IDs_CLASSIFICATION_VALUE"."CS_CLASSIFICATION_SCHEME_SHORT_NAME" = 'AR_X_IP_RLTNP_TP' AND
                                    "Type_IDs_CLASSIFICATION_VALUE"."CV_CLASSIFICATION_CODE" IN ( 
                                        'IP_IS_CST_IN_AR', 
                                        'External Relationship' ) AND
                                    "Type_IDs_CLASSIFICATION_VALUE"."CV_END_DATE" IS NULL AND
                                    "Type_IDs_CLASSIFICATION_VALUE"."CS_END_DATE" IS NULL
                                ) "ARRANGEMENT_X_INVOLVED_PARTY_RLTNP2"
                                ON "ARRANGEMENT_X_INVOLVED_PARTY_RLTNP2"."ARRANGEMENT_ID" = "ARR_ARRANGEMENT"."ARRANGEMENT_ID"
                    ON "CUSTOMER0"."CUSTOMER_ID" = "ARRANGEMENT_X_INVOLVED_PARTY_RLTNP2"."INVOLVED_PARTY_ID"
                        LEFT OUTER JOIN 
                        (
                        SELECT
                            "ARRANGEMENT_X_PRODUCT_RLTNP"."ARRANGEMENT_ID" AS "ARRANGEMENT_ID", 
                            "ARRANGEMENT_X_PRODUCT_RLTNP"."PRODUCT_ID" AS "PRODUCT_ID"
                        FROM
                            "DBDATA"."ADMIN"."ARRANGEMENT_X_PRODUCT_RLTNP" "ARRANGEMENT_X_PRODUCT_RLTNP" 
                        WHERE 
                            "ARRANGEMENT_X_PRODUCT_RLTNP"."END_DATE" IS NULL
                        ) "ARRPRD_ARRANGEMENT_X_PRODUCT_RLTNP"
                            INNER JOIN 
                            (
                            SELECT
                                "PRODUCT"."PRODUCT_ID" AS "PRODUCT_ID"
                            FROM
                                "DBDATA"."ADMIN"."PRODUCT" "PRODUCT" 
                            WHERE 
                                "PRODUCT"."END_DATE" IS NULL
                            ) "ARRPRD_PRODUCT"
                            ON "ARRPRD_ARRANGEMENT_X_PRODUCT_RLTNP"."PRODUCT_ID" = "ARRPRD_PRODUCT"."PRODUCT_ID"
                                INNER JOIN "DBDATA"."ADMIN"."PRODUCT_X_GROUP_RLTNP" "ARRPRD_PRODUCT_X_GROUP_RLTNP"
                                ON "ARRPRD_PRODUCT"."PRODUCT_ID" = "ARRPRD_PRODUCT_X_GROUP_RLTNP"."PRODUCT_ID"
                                    INNER JOIN 
                                    (
                                    SELECT
                                        "GROUP0"."GROUP_ID" AS "GROUP_ID", 
                                        "GROUP0"."PRODUCT_GROUP_TYPE_ID" AS "PRODUCT_GROUP_TYPE_ID"
                                    FROM
                                        (
                                        SELECT
                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_ID" AS "CV_CLASSIFICATION_ID", 
                                            "CLASSIFICATION_VALUE0"."POPULATION_DATE" AS "CV_POPULATION_DATE", 
                                            "CLASSIFICATION_VALUE0"."POPULATION_TIME" AS "CV_POPULATION_TIME", 
                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_SCHEME_ID" AS "CV_CLASSIFICATION_SCHEME_ID", 
                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_NAME" AS "CV_The_Value_CLASSIFICATION_NAME", 
                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_CODE" AS "CV_CLASSIFICATION_CODE", 
                                            "CLASSIFICATION_VALUE0"."DESCRIPTION" AS "CV_DESCRIPTION", 
                                            "CLASSIFICATION_VALUE0"."EFFECTIVE_DATE" AS "CV_EFFECTIVE_DATE", 
                                            "CLASSIFICATION_VALUE0"."END_DATE" AS "CV_END_DATE", 
                                            "CLASSIFICATION_VALUE0"."PARENT_CLASSIFICATION_ID" AS "CV_PARENT_CLASSIFICATION_ID", 
                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_VALUE_SHORT_NAME" AS "CV_CLASSIFICATION_VALUE_SHORT_NAME", 
                                            "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_ID" AS "CS_CLASSIFICATION_SCHEME_ID", 
                                            "CLASSIFICATION_SCHEME0"."POPULATION_DATE" AS "CS_POPULATION_DATE", 
                                            "CLASSIFICATION_SCHEME0"."POPULATION_TIME" AS "CS_POPULATION_TIME", 
                                            "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_NAME" AS "CS_CLASSIFICATION_SCHEME_NAME", 
                                            "CLASSIFICATION_SCHEME0"."EFFECTIVE_DATE" AS "CS_EFFECTIVE_DATE", 
                                            "CLASSIFICATION_SCHEME0"."END_DATE" AS "CS_END_DATE", 
                                            "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_SHORT_NAME" AS "CS_CLASSIFICATION_SCHEME_SHORT_NAME"
                                        FROM
                                            "DBDATA"."ADMIN"."CLASSIFICATION_VALUE" "CLASSIFICATION_VALUE0"
                                                INNER JOIN "DBDATA"."ADMIN"."CLASSIFICATION_SCHEME" "CLASSIFICATION_SCHEME0"
                                                ON "CLASSIFICATION_VALUE0"."CLASSIFICATION_SCHEME_ID" = "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_ID"
                                        ) "Type_IDs_CLASSIFICATION_VALUE"
                                            INNER JOIN "DBDATA"."ADMIN"."GROUP" "GROUP0"
                                            ON "Type_IDs_CLASSIFICATION_VALUE"."CV_CLASSIFICATION_ID" = "GROUP0"."GROUP_TYPE_ID" 
                                    WHERE 
                                        "Type_IDs_CLASSIFICATION_VALUE"."CS_CLASSIFICATION_SCHEME_SHORT_NAME" = 'GRP_TP' AND
                                        "GROUP0"."END_DATE" IS NULL AND
                                        "Type_IDs_CLASSIFICATION_VALUE"."CV_END_DATE" IS NULL AND
                                        "Type_IDs_CLASSIFICATION_VALUE"."CS_END_DATE" IS NULL
                                    ) "ARRPRD_GROUP"
                                    ON "ARRPRD_PRODUCT_X_GROUP_RLTNP"."GROUP_ID" = "ARRPRD_GROUP"."GROUP_ID"
                                        INNER JOIN 
                                        (
                                        SELECT
                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_ID" AS "CV_CLASSIFICATION_ID", 
                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_NAME" AS "Product_Group", 
                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_CODE" AS "Product_Group_Code"
                                        FROM
                                            "DBDATA"."ADMIN"."CLASSIFICATION_VALUE" "CLASSIFICATION_VALUE0"
                                                INNER JOIN "DBDATA"."ADMIN"."CLASSIFICATION_SCHEME" "CLASSIFICATION_SCHEME0"
                                                ON "CLASSIFICATION_VALUE0"."CLASSIFICATION_SCHEME_ID" = "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_ID" 
                                        WHERE 
                                            "CLASSIFICATION_VALUE0"."END_DATE" IS NULL AND
                                            "CLASSIFICATION_SCHEME0"."END_DATE" IS NULL AND
                                            "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_NAME" = 'PRODUCT_GROUP_TYPE'
                                        ) "ARRPRD_CV_CS_MERGED"
                                        ON "ARRPRD_GROUP"."PRODUCT_GROUP_TYPE_ID" = "ARRPRD_CV_CS_MERGED"."CV_CLASSIFICATION_ID"
                        ON "ARR_ARRANGEMENT"."ARRANGEMENT_ID" = "ARRPRD_ARRANGEMENT_X_PRODUCT_RLTNP"."ARRANGEMENT_ID"
                            LEFT OUTER JOIN 
                            (
                            SELECT
                                "CLASSIFICATION_VALUE0"."CLASSIFICATION_ID" AS "CV_CLASSIFICATION_ID", 
                                "CLASSIFICATION_VALUE0"."CLASSIFICATION_CODE" AS "Relationship_Code"
                            FROM
                                "DBDATA"."ADMIN"."CLASSIFICATION_VALUE" "CLASSIFICATION_VALUE0"
                                    INNER JOIN "DBDATA"."ADMIN"."CLASSIFICATION_SCHEME" "CLASSIFICATION_SCHEME0"
                                    ON "CLASSIFICATION_VALUE0"."CLASSIFICATION_SCHEME_ID" = "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_ID" 
                            WHERE 
                                "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_NAME" = 'CUSTOMER_OWNER_RELATIONSHIP_TYPE' AND
                                "CLASSIFICATION_VALUE0"."END_DATE" IS NULL AND
                                "CLASSIFICATION_SCHEME0"."END_DATE" IS NULL
                            ) "ARR_Relationship_CV_CS_MERGED"
                            ON "ARRANGEMENT_X_INVOLVED_PARTY_RLTNP2"."CUSTOMER_OWNER_RELATIONSHIP_TYPE_ID" = "ARR_Relationship_CV_CS_MERGED"."CV_CLASSIFICATION_ID"
                                LEFT OUTER JOIN "DBDATA"."ADMIN"."TRANSACTION" "ACCTARRTRANS_TRANSACTION"
                                ON "Copy_of_ARRANGEMENT_Copy_of_ARRANGEMENT_X_CLASSIFICATION_RLTNP_Copy_of_CV_CS_MERGED"."ARRANGEMENT_ID" = "ACCTARRTRANS_TRANSACTION"."PRIMARY_ARRANGEMENT_ID"
                                    LEFT OUTER JOIN "DBDATA"."ADMIN"."DEMAND_DEPOSIT_TRANSACTION" "ACCTARRTRANS_DEMAND_DEPOSIT_TRANSACTION"
                                    ON "ACCTARRTRANS_TRANSACTION"."TRANSACTION_ID" = "ACCTARRTRANS_DEMAND_DEPOSIT_TRANSACTION"."DEMAND_DEPOSIT_TRANSACTION_ID"
                                        LEFT OUTER JOIN 
                                        (
                                        SELECT
                                            "ARRRSC_to_ACCTARRTRANS_ARRRSC_PAYMENT_CARD"."Card_Number_16" AS "Debit_Card_Used_in_Transaction", 
                                            "ARRRSC_to_ACCTARRTRANS_ARRRSC_ACCTARRTRANS_TRANSACTION"."Transaction_ID" AS "Transaction_ID"
                                        FROM
                                            (
                                            SELECT
                                                "TRANSACTION0"."TRANSACTION_ID" AS "Transaction_ID", 
                                                "TRANSACTION0"."PRIMARY_ARRANGEMENT_ID" AS "PRIMARY_ARRANGEMENT_ID", 
                                                "TRANSACTION0"."TRANSACTION_DATE" AS "Transaction_Effective_Date", 
                                                "TRANSACTION0"."TRANSACTION_VALUE_DATE" AS "Transaction_Posting_Date", 
                                                "TRANSACTION0"."DEBIT_CREDIT_CODE" AS "Debit_Credit_Code", 
                                                "TRANSACTION0"."DESCRIPTION_1" AS "Description_1", 
                                                "TRANSACTION0"."DESCRIPTION_2" AS "Description_2", 
                                                "TRANSACTION0"."DESCRIPTION_3" AS "Description_3", 
                                                "TRANSACTION0"."SERIAL_CHECK_NUMBER" AS "Serial_or_Check_Number", 
                                                "TRANSACTION0"."TRANSACTION_SEQUENCE_NUMBER" AS "Transaction_Sequence_Number", 
                                                "TRANSACTION0"."INTERNAL_TRANSACTION_CODE" AS "Transaction_Code_Internal", 
                                                "TRANSACTION0"."EXTERNAL_TRANSACTION_CODE" AS "Transaction_Code_External", 
                                                "TRANSACTION0"."TRANSACTION_REQUESTER" AS "Transaction_Requestor", 
                                                "TRANSACTION0"."TRANSACTION_AMOUNT_1" AS "Transaction_Amount_1", 
                                                "TRANSACTION0"."TRANSACTION_AMOUNT_2" AS "Transaction_Amount_2", 
                                                "TRANSACTION0"."BRANCH_NUMBER" AS "BRANCH_NUMBER", 
                                                "TRANSACTION0"."PASSBOOK_FLAG" AS "Passbook_Flag", 
                                                "TRANSACTION0"."CHANNEL_TYPE_ID" AS "CHANNEL_TYPE_ID", 
                                                "TRANSACTION0"."BATCH_SEQUENCE_NUMBER" AS "Batch_Sequence_Number", 
                                                "TRANSACTION0"."RECORD_TYPE" AS "Transaction_Record_Type", 
                                                "TRANSACTION0"."HISTORY_UPDATE_TYPE_ID" AS "HISTORY_UPDATE_TYPE_ID", 
                                                substr("TRANSACTION0"."DESCRIPTION_1", 1, 4) AS "WORK_First_Four_of_Description_1"
                                            FROM
                                                "DBDATA"."ADMIN"."TRANSACTION" "TRANSACTION0"
                                            ) "ARRRSC_to_ACCTARRTRANS_ARRRSC_ACCTARRTRANS_TRANSACTION"
                                                INNER JOIN "DBDATA"."ADMIN"."DEMAND_DEPOSIT_TRANSACTION" "ARRRSC_to_ACCTARRTRANS_ARRRSC_ACCTARRTRANS_DEMAND_DEPOSIT_TRANSACTION"
                                                ON "ARRRSC_to_ACCTARRTRANS_ARRRSC_ACCTARRTRANS_TRANSACTION"."Transaction_ID" = "ARRRSC_to_ACCTARRTRANS_ARRRSC_ACCTARRTRANS_DEMAND_DEPOSIT_TRANSACTION"."DEMAND_DEPOSIT_TRANSACTION_ID"
                                                    INNER JOIN 
                                                    (
                                                    SELECT
                                                        "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP0"."ARRANGEMENT_ID" AS "ARRANGEMENT_ID", 
                                                        "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP0"."RESOURCE_ITEM_ID" AS "RESOURCE_ITEM_ID"
                                                    FROM
                                                        (
                                                        SELECT
                                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_ID" AS "CV_CLASSIFICATION_ID", 
                                                            "CLASSIFICATION_VALUE0"."POPULATION_DATE" AS "CV_POPULATION_DATE", 
                                                            "CLASSIFICATION_VALUE0"."POPULATION_TIME" AS "CV_POPULATION_TIME", 
                                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_SCHEME_ID" AS "CV_CLASSIFICATION_SCHEME_ID", 
                                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_NAME" AS "CV_The_Value_CLASSIFICATION_NAME", 
                                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_CODE" AS "CV_CLASSIFICATION_CODE", 
                                                            "CLASSIFICATION_VALUE0"."DESCRIPTION" AS "CV_DESCRIPTION", 
                                                            "CLASSIFICATION_VALUE0"."EFFECTIVE_DATE" AS "CV_EFFECTIVE_DATE", 
                                                            "CLASSIFICATION_VALUE0"."END_DATE" AS "CV_END_DATE", 
                                                            "CLASSIFICATION_VALUE0"."PARENT_CLASSIFICATION_ID" AS "CV_PARENT_CLASSIFICATION_ID", 
                                                            "CLASSIFICATION_VALUE0"."CLASSIFICATION_VALUE_SHORT_NAME" AS "CV_CLASSIFICATION_VALUE_SHORT_NAME", 
                                                            "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_ID" AS "CS_CLASSIFICATION_SCHEME_ID", 
                                                            "CLASSIFICATION_SCHEME0"."POPULATION_DATE" AS "CS_POPULATION_DATE", 
                                                            "CLASSIFICATION_SCHEME0"."POPULATION_TIME" AS "CS_POPULATION_TIME", 
                                                            "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_NAME" AS "CS_CLASSIFICATION_SCHEME_NAME", 
                                                            "CLASSIFICATION_SCHEME0"."EFFECTIVE_DATE" AS "CS_EFFECTIVE_DATE", 
                                                            "CLASSIFICATION_SCHEME0"."END_DATE" AS "CS_END_DATE", 
                                                            "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_SHORT_NAME" AS "CS_CLASSIFICATION_SCHEME_SHORT_NAME"
                                                        FROM
                                                            "DBDATA"."ADMIN"."CLASSIFICATION_VALUE" "CLASSIFICATION_VALUE0"
                                                                INNER JOIN "DBDATA"."ADMIN"."CLASSIFICATION_SCHEME" "CLASSIFICATION_SCHEME0"
                                                                ON "CLASSIFICATION_VALUE0"."CLASSIFICATION_SCHEME_ID" = "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_ID"
                                                        ) "Type_IDs_CLASSIFICATION_VALUE"
                                                            INNER JOIN 
                                                            (
                                                            SELECT
                                                                "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP"."ARRANGEMENT_ID" AS "ARRANGEMENT_ID", 
                                                                "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP"."RESOURCE_ITEM_ID" AS "RESOURCE_ITEM_ID", 
                                                                "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP"."ARRANGEMENT_X_RESOURCE_ITEM_RLTNP_TYPE_ID" AS "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP_TYPE_ID", 
                                                                "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP"."EFFECTIVE_DATE" AS "Acct_Tickler_Effective_Date", 
                                                                "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP"."RANK" AS "RANK0", 
                                                                "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP"."POPULATION_DATE" AS "POPULATION_DATE", 
                                                                "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP"."POPULATION_TIME" AS "POPULATION_TIME", 
                                                                "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP"."END_DATE" AS "END_DATE"
                                                            FROM
                                                                "DBDATA"."ADMIN"."ARRANGEMENT_X_RESOURCE_ITEM_RLTNP" "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP" 
                                                            WHERE 
                                                                "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP"."END_DATE" IS NULL
                                                            ) "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP0"
                                                            ON "Type_IDs_CLASSIFICATION_VALUE"."CV_CLASSIFICATION_ID" = "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP0"."ARRANGEMENT_X_RESOURCE_ITEM_RLTNP_TYPE_ID" 
                                                    WHERE 
                                                        "Type_IDs_CLASSIFICATION_VALUE"."CS_CLASSIFICATION_SCHEME_SHORT_NAME" = 'AR_X_RI_RLTNP_TP' AND
                                                        "Type_IDs_CLASSIFICATION_VALUE"."CV_CLASSIFICATION_CODE" = 'RI_PROVIDES_ACS_TO_AR' AND
                                                        "ARRANGEMENT_X_RESOURCE_ITEM_RLTNP0"."END_DATE" IS NULL AND
                                                        "Type_IDs_CLASSIFICATION_VALUE"."CV_END_DATE" IS NULL AND
                                                        "Type_IDs_CLASSIFICATION_VALUE"."CS_END_DATE" IS NULL
                                                    ) "ARRRSC_to_ACCTARRTRANS_ARRRSC_Payment_Card_ARRANGEMENT_X_RESOURCE_ITEM_RLTNP_Type_IDs_CLASSIFICATION_VALUE2"
                                                    ON "ARRRSC_to_ACCTARRTRANS_ARRRSC_ACCTARRTRANS_TRANSACTION"."PRIMARY_ARRANGEMENT_ID" = "ARRRSC_to_ACCTARRTRANS_ARRRSC_Payment_Card_ARRANGEMENT_X_RESOURCE_ITEM_RLTNP_Type_IDs_CLASSIFICATION_VALUE2"."ARRANGEMENT_ID"
                                                        INNER JOIN 
                                                        (
                                                        SELECT
                                                            "PAYMENT_CARD"."PAYMENT_CARD_NUMBER" AS "Card_Number_16", 
                                                            "PAYMENT_CARD"."PAYMENT_CARD_ID" AS "PAYMENT_CARD_ID", 
                                                            Substr("PAYMENT_CARD"."PAYMENT_CARD_NUMBER", 13, 4) AS "WORK_Last_Four_of_Card_Number_16", 
                                                            "PAYMENT_CARD"."CARD_EXPIRY_DATE" AS "Card_Expiration_Date", 
                                                            "PAYMENT_CARD"."PAYMENT_CARD_TYPE_ID" AS "PAYMENT_CARD_TYPE_ID", 
                                                            "PAYMENT_CARD"."EMBOSSING_NAME" AS "Embossing_Name", 
                                                            "PAYMENT_CARD"."EMBOSSING_NAME_LINE_2" AS "Embossing_Name_Line_2", 
                                                            "PAYMENT_CARD"."PROCESSING_OPTION_FLAG_0" AS "Processing_Option_Flag_0", 
                                                            substr("PAYMENT_CARD"."PAYMENT_CARD_NUMBER", 1, 6) AS "ISO_Number", 
                                                            substr("PAYMENT_CARD"."PAYMENT_CARD_NUMBER", 7) AS "Card_Number"
                                                        FROM
                                                            "DBDATA"."ADMIN"."PAYMENT_CARD" "PAYMENT_CARD"
                                                        ) "ARRRSC_to_ACCTARRTRANS_ARRRSC_PAYMENT_CARD"
                                                        ON "ARRRSC_to_ACCTARRTRANS_ARRRSC_Payment_Card_ARRANGEMENT_X_RESOURCE_ITEM_RLTNP_Type_IDs_CLASSIFICATION_VALUE2"."RESOURCE_ITEM_ID" = "ARRRSC_to_ACCTARRTRANS_ARRRSC_PAYMENT_CARD"."PAYMENT_CARD_ID"
                                                            INNER JOIN 
                                                            (
                                                            SELECT
                                                                "TRANSACTION_TYPE0"."TRANSACTION_TYPE_ID" AS "TRANSACTION_TYPE_ID", 
                                                                "TRANSACTION_TYPE0"."POINT_OF_SALE" AS "POS_Transaction_Indicator", 
                                                                "TRANSACTION_TYPE0"."EXTERNAL_TRANSACTION_CODE" AS "EXTERNAL_TRANSACTION_CODE", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_CLASSIFICATION_ID" AS "CV_CLASSIFICATION_ID", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_The_Value_CLASSIFICATION_NAME" AS "Posting_Transaction_Code_Description", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_CLASSIFICATION_CODE" AS "Posting_Transaction_Code", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_POPULATION_DATE" AS "CV_POPULATION_DATE", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_POPULATION_TIME" AS "CV_POPULATION_TIME", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_CLASSIFICATION_SCHEME_ID" AS "CV_CLASSIFICATION_SCHEME_ID", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_DESCRIPTION" AS "CV_DESCRIPTION", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_EFFECTIVE_DATE" AS "CV_EFFECTIVE_DATE", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_END_DATE" AS "CV_END_DATE", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_PARENT_CLASSIFICATION_ID" AS "CV_PARENT_CLASSIFICATION_ID", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_CLASSIFICATION_VALUE_SHORT_NAME" AS "CV_CLASSIFICATION_VALUE_SHORT_NAME", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CS_CLASSIFICATION_SCHEME_ID" AS "CS_CLASSIFICATION_SCHEME_ID", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CS_POPULATION_DATE" AS "CS_POPULATION_DATE", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CS_POPULATION_TIME" AS "CS_POPULATION_TIME", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CS_CLASSIFICATION_SCHEME_NAME" AS "CS_CLASSIFICATION_SCHEME_NAME", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CS_EFFECTIVE_DATE" AS "CS_EFFECTIVE_DATE", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CS_END_DATE" AS "CS_END_DATE", 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CS_CLASSIFICATION_SCHEME_SHORT_NAME" AS "CS_CLASSIFICATION_SCHEME_SHORT_NAME"
                                                            FROM
                                                                "DBDATA"."ADMIN"."TRANSACTION_TYPE" "TRANSACTION_TYPE0"
                                                                    INNER JOIN 
                                                                    (
                                                                    SELECT
                                                                        "CLASSIFICATION_VALUE0"."CLASSIFICATION_ID" AS "CV_CLASSIFICATION_ID", 
                                                                        "CLASSIFICATION_VALUE0"."CLASSIFICATION_NAME" AS "CV_The_Value_CLASSIFICATION_NAME", 
                                                                        "CLASSIFICATION_VALUE0"."CLASSIFICATION_CODE" AS "CV_CLASSIFICATION_CODE", 
                                                                        "CLASSIFICATION_VALUE0"."POPULATION_DATE" AS "CV_POPULATION_DATE", 
                                                                        "CLASSIFICATION_VALUE0"."POPULATION_TIME" AS "CV_POPULATION_TIME", 
                                                                        "CLASSIFICATION_VALUE0"."CLASSIFICATION_SCHEME_ID" AS "CV_CLASSIFICATION_SCHEME_ID", 
                                                                        "CLASSIFICATION_VALUE0"."DESCRIPTION" AS "CV_DESCRIPTION", 
                                                                        "CLASSIFICATION_VALUE0"."EFFECTIVE_DATE" AS "CV_EFFECTIVE_DATE", 
                                                                        "CLASSIFICATION_VALUE0"."END_DATE" AS "CV_END_DATE", 
                                                                        "CLASSIFICATION_VALUE0"."PARENT_CLASSIFICATION_ID" AS "CV_PARENT_CLASSIFICATION_ID", 
                                                                        "CLASSIFICATION_VALUE0"."CLASSIFICATION_VALUE_SHORT_NAME" AS "CV_CLASSIFICATION_VALUE_SHORT_NAME", 
                                                                        "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_ID" AS "CS_CLASSIFICATION_SCHEME_ID", 
                                                                        "CLASSIFICATION_SCHEME0"."POPULATION_DATE" AS "CS_POPULATION_DATE", 
                                                                        "CLASSIFICATION_SCHEME0"."POPULATION_TIME" AS "CS_POPULATION_TIME", 
                                                                        "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_NAME" AS "CS_CLASSIFICATION_SCHEME_NAME", 
                                                                        "CLASSIFICATION_SCHEME0"."EFFECTIVE_DATE" AS "CS_EFFECTIVE_DATE", 
                                                                        "CLASSIFICATION_SCHEME0"."END_DATE" AS "CS_END_DATE", 
                                                                        "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_SHORT_NAME" AS "CS_CLASSIFICATION_SCHEME_SHORT_NAME"
                                                                    FROM
                                                                        "DBDATA"."ADMIN"."CLASSIFICATION_VALUE" "CLASSIFICATION_VALUE0"
                                                                            INNER JOIN "DBDATA"."ADMIN"."CLASSIFICATION_SCHEME" "CLASSIFICATION_SCHEME0"
                                                                            ON "CLASSIFICATION_VALUE0"."CLASSIFICATION_SCHEME_ID" = "CLASSIFICATION_SCHEME0"."CLASSIFICATION_SCHEME_ID"
                                                                    ) "TRAN_TYPE_Copy_of_CV_CS_MERGED"
                                                                    ON "TRANSACTION_TYPE0"."TRANSACTION_TYPE_ID" = "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_CLASSIFICATION_ID" 
                                                            WHERE 
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CS_END_DATE" IS NULL AND
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_END_DATE" IS NULL AND
                                                                "TRAN_TYPE_Copy_of_CV_CS_MERGED"."CV_CLASSIFICATION_CODE" IN ( 
                                                                    '41', 
                                                                    '53', 
                                                                    '56', 
                                                                    '57', 
                                                                    '61', 
                                                                    '161' )
                                                            ) "ARRRSC_to_ACCTARRTRANS_ARRRSC_ACCTARRTRANS_DD_TRANSACTION_TYPE_Copy__4__of_CV_CS_MERGED"
                                                            ON "ARRRSC_to_ACCTARRTRANS_ARRRSC_ACCTARRTRANS_DEMAND_DEPOSIT_TRANSACTION"."POSTING_TRANSACTION_TYPE_ID" = "ARRRSC_to_ACCTARRTRANS_ARRRSC_ACCTARRTRANS_DD_TRANSACTION_TYPE_Copy__4__of_CV_CS_MERGED"."TRANSACTION_TYPE_ID" 
                                        WHERE 
                                            "ARRRSC_to_ACCTARRTRANS_ARRRSC_ACCTARRTRANS_TRANSACTION"."WORK_First_Four_of_Description_1" = "ARRRSC_to_ACCTARRTRANS_ARRRSC_PAYMENT_CARD"."WORK_Last_Four_of_Card_Number_16" AND
                                            "ARRRSC_to_ACCTARRTRANS_ARRRSC_ACCTARRTRANS_TRANSACTION"."WORK_First_Four_of_Description_1" = "ARRRSC_to_ACCTARRTRANS_ARRRSC_PAYMENT_CARD"."WORK_Last_Four_of_Card_Number_16"
                                        ) "ARRRSC_ACCTARRTRANS_TRANSACTION_ARRRSC_ACCTARRTRANS_DD_TRANSACTION_TYPE_Copy__4__of_CV_CS_MERGED2"
                                        ON "ACCTARRTRANS_DEMAND_DEPOSIT_TRANSACTION"."DEMAND_DEPOSIT_TRANSACTION_ID" = "ARRRSC_ACCTARRTRANS_TRANSACTION_ARRRSC_ACCTARRTRANS_DD_TRANSACTION_TYPE_Copy__4__of_CV_CS_MERGED2"."Transaction_ID" 
WHERE 
    "ARR_Relationship_CV_CS_MERGED"."Relationship_Code" IN ( 
        'JOF', 
        'JAF', 
        'SOW', 
        'OWN' ) AND
    "ACCTARRTRANS_TRANSACTION"."TRANSACTION_VALUE_DATE" >= "Copy_of_PROCESSING_DATES"."REPORTING_DATE" AND
    "ARRPRD_CV_CS_MERGED"."Product_Group" = 'Checking Products'
