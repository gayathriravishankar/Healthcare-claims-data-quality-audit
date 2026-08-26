# Interview Pack

## One-page project explanation

### Situation

Healthcare claims data can contain missing identifiers, invalid amounts, and inconsistent statuses. These problems can affect processing and reporting.

### Task

Build a small MySQL audit that identifies defective fictional claims, measures the error rate, and shows where quality problems are concentrated.

### Action

I created related claims and provider tables in MySQL Workbench. I wrote validation rules using `CASE`, null checks, numeric checks, and allowed-status checks. I used aggregate functions to calculate quality metrics, joined provider information to claims, and created a reusable view for reporting.

### Result

The audit flagged 10 of 16 fictional claims, giving a 62.50% sample error rate. Missing diagnosis codes were the largest issue category with four claims. Two fictional providers had the highest sample error rate at 80.00%. The absolute claim-value magnitude flagged was 17,100.00.

### Recommendation

Introduce mandatory-field validation, restrict statuses to approved values, quarantine non-positive amounts, and monitor issue rates by provider.

## Two-minute demo plan

1. Show the `claims` and `providers` tables.
2. Explain the four validation rules.
3. Open the `claim_quality_results` view.
4. Show the 62.50% error rate and 17,100.00 flagged-value magnitude.
5. Show missing diagnosis code as the leading issue.
6. Show the provider comparison.
7. Close with the recommended validation controls.

## Postmortem

### What worked

- `CASE` converted technical checks into readable quality categories.
- A view prevented the validation logic from being repeated in every report.
- Provider joins made the results more useful for operational follow-up.

### What was difficult

- The first join failed because the providers table had not been created before the join query ran.
- Repeating validation conditions made early queries longer and harder to maintain.

### Mitigation

- Run setup scripts in dependency order: providers, claims, data, then analysis.
- Store the shared validation logic in `claim_quality_results`.
- Add comments and keep setup separate from analysis.

### Next improvement

Allow one claim to hold multiple issue flags instead of recording only the first matching issue. Test the logic with a larger synthetic dataset before adding any dashboard.

## Short interview answer

I built a fictional healthcare claims data-quality audit in MySQL Workbench. I created related claims and provider tables, wrote rules to detect missing identifiers, invalid amounts, and unexpected statuses, and then calculated overall and provider-level error rates. The sample contained 16 claims, of which 10 were flagged. Missing diagnosis codes were the most frequent issue. I packaged the logic in a reusable SQL view and proposed preventive validation controls.


