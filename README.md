# Healthcare Claims Data Quality Audit

## Project overview

This beginner SQL project audits a small fictional healthcare-claims dataset. It identifies missing and invalid values, measures the overall error rate, groups issues by category, and compares quality results across fictional providers.

The dataset is synthetic. It contains no real patient, claim, or provider information.

## Business question

Which claims contain data-quality problems, what problem occurs most frequently, and which providers have the highest error rates in the sample?

## Tools and SQL techniques

- MySQL Workbench 8.0
- Table creation and inserts
- `SELECT`, `WHERE`, and null checks
- `CASE` expressions
- Aggregate functions
- `GROUP BY` and `ORDER BY`
- `INNER JOIN` and `LEFT JOIN`
- Views
- Window function for issue percentages

## Validation rules

A claim is flagged when it has one or more of these conditions:

- Missing patient ID
- Missing diagnosis code
- Claim amount less than or equal to zero
- Status outside Approved, Denied, or Pending

The current classification gives each claim one primary issue. SQL evaluates the rules from top to bottom and uses the first matching condition.

## Verified results

- Total claims: 16
- Invalid claims: 10
- Valid claims: 6
- Error rate: 62.50%
- Absolute claim-value magnitude flagged: 17,100.00
- Leading issue: Missing diagnosis code, 4 claims
- Highest sample error rate: Green Valley Clinic and Lotus Care Hospital, both 80.00%
- Lowest sample error rate: Sunrise Health Centre, 33.33%

These are demonstration findings from a small fictional dataset. They are not real healthcare benchmarks or real provider-performance results.

## Recommendations

1. Add mandatory-field validation for patient and diagnosis identifiers.
2. Reject or quarantine claim amounts that are zero or negative.
3. Restrict claim status to approved values.
4. Monitor error rates by provider and issue category.
5. Investigate high-error groups before using the data for operational reporting.

## How to run

1. Open MySQL Workbench 8.0.
2. Run `database_setup.sql`.
3. Run `quality_analysis.sql`.
4. Review the detailed audit, summary, issue distribution, and provider comparison result grids.

## Limitations

- The sample contains only 16 fictional claims.
- The results are intentionally designed for SQL practice.
- The primary-issue classification records only the first matching issue.
- The project does not assess medical necessity or coding correctness.
- The flagged amount uses the absolute magnitude of invalid claim amounts and is not a financial-loss estimate.


