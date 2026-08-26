CREATE DATABASE IF NOT EXISTS healthcare_claims_quality;

USE healthcare_claims_quality;

CREATE TABLE IF NOT EXISTS providers (
    provider_id VARCHAR(10) PRIMARY KEY,
    provider_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS claims (
    claim_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10),
    provider_id VARCHAR(10),
    claim_date DATE,
    diagnosis_code VARCHAR(10),
    claim_amount DECIMAL(10, 2),
    claim_status VARCHAR(20),
    CONSTRAINT fk_claim_provider
        FOREIGN KEY (provider_id) REFERENCES providers(provider_id)
);

INSERT IGNORE INTO providers (
    provider_id,
    provider_name,
    specialty,
    city
)
VALUES
    ('PR001', 'Sunrise Health Centre', 'General Medicine', 'Coimbatore'),
    ('PR002', 'Green Valley Clinic', 'Endocrinology', 'Chennai'),
    ('PR003', 'Lotus Care Hospital', 'Orthopedics', 'Bengaluru');

INSERT IGNORE INTO claims (
    claim_id,
    patient_id,
    provider_id,
    claim_date,
    diagnosis_code,
    claim_amount,
    claim_status
)
VALUES
    ('C001', 'P001', 'PR001', '2026-01-05', 'E11.9', 2500.00, 'Approved'),
    ('C002', 'P002', 'PR001', '2026-01-08', NULL, 1800.00, 'Denied'),
    ('C003', 'P003', 'PR002', '2026-02-02', 'I10', -500.00, 'Pending'),
    ('C004', 'P004', 'PR001', '2026-02-10', 'J45.9', 3200.00, 'Approved'),
    ('C005', NULL, 'PR002', '2026-02-15', 'E78.5', 2100.00, 'Denied'),
    ('C006', 'P006', 'PR003', '2026-02-18', 'M54.5', 1500.00, 'Unknown'),
    ('C007', 'P007', 'PR001', '2026-03-01', 'E11.9', 2800.00, 'Approved'),
    ('C008', 'P008', 'PR001', '2026-03-03', NULL, 1900.00, 'Denied'),
    ('C009', 'P009', 'PR002', '2026-03-05', NULL, 2300.00, 'Pending'),
    ('C010', 'P010', 'PR001', '2026-03-08', 'I10', 1700.00, 'Approved'),
    ('C011', 'P011', 'PR002', '2026-03-10', 'J45.9', -250.00, 'Denied'),
    ('C012', 'P012', 'PR003', '2026-03-12', 'E78.5', 3100.00, 'Rejected'),
    ('C013', NULL, 'PR003', '2026-03-15', 'M54.5', 2200.00, 'Pending'),
    ('C014', 'P014', 'PR002', '2026-03-18', 'I10', 2600.00, 'Approved'),
    ('C015', 'P015', 'PR003', '2026-03-20', NULL, 1450.00, 'Denied'),
    ('C016', 'P016', 'PR003', '2026-03-22', 'E11.9', 3500.00, 'Approved');


