USE healthcare_claims_quality;

CREATE OR REPLACE VIEW claim_quality_results AS
SELECT
    c.claim_id,
    c.patient_id,
    c.provider_id,
    p.provider_name,
    c.claim_date,
    c.diagnosis_code,
    c.claim_amount,
    c.claim_status,
    CASE
        WHEN c.patient_id IS NULL THEN 'Missing patient ID'
        WHEN c.diagnosis_code IS NULL THEN 'Missing diagnosis code'
        WHEN c.claim_amount <= 0 THEN 'Invalid claim amount'
        WHEN c.claim_status NOT IN ('Approved', 'Denied', 'Pending')
            THEN 'Invalid claim status'
        ELSE 'Valid claim'
    END AS quality_issue,
    CASE
        WHEN c.patient_id IS NULL
          OR c.diagnosis_code IS NULL
          OR c.claim_amount <= 0
          OR c.claim_status NOT IN ('Approved', 'Denied', 'Pending')
            THEN 'Invalid'
        ELSE 'Valid'
    END AS quality_status
FROM claims AS c
LEFT JOIN providers AS p
    ON c.provider_id = p.provider_id;

-- Detailed audit result
SELECT *
FROM claim_quality_results
ORDER BY claim_id;

-- Overall quality summary
SELECT
    COUNT(*) AS total_claims,
    SUM(CASE WHEN quality_status = 'Invalid' THEN 1 ELSE 0 END)
        AS invalid_claims,
    SUM(CASE WHEN quality_status = 'Valid' THEN 1 ELSE 0 END)
        AS valid_claims,
    ROUND(
        100.0 * SUM(CASE WHEN quality_status = 'Invalid' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS error_rate_percentage,
    SUM(
        CASE WHEN quality_status = 'Invalid'
            THEN ABS(claim_amount)
            ELSE 0
        END
    ) AS claim_value_flagged
FROM claim_quality_results;

-- Issue distribution
SELECT
    quality_issue,
    COUNT(*) AS issue_count,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_invalid_claims
FROM claim_quality_results
WHERE quality_status = 'Invalid'
GROUP BY quality_issue
ORDER BY issue_count DESC, quality_issue;

-- Provider quality comparison
SELECT
    provider_id,
    provider_name,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN quality_status = 'Invalid' THEN 1 ELSE 0 END)
        AS invalid_claims,
    ROUND(
        100.0 * SUM(CASE WHEN quality_status = 'Invalid' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS error_rate_percentage
FROM claim_quality_results
GROUP BY provider_id, provider_name
ORDER BY error_rate_percentage DESC, provider_name;


