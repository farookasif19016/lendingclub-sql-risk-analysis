# LendingClub Loan Default Risk Analysis

### Executive Summary

- Analysed **39,715** LendingClub loans using PostgreSQL.
- Answered **23** business questions covering portfolio performance and credit risk.
- Built an executive Power BI scorecard to validate SQL findings.
- Identified interest rate, loan term and portfolio concentration as the strongest default drivers.
- Demonstrated advanced SQL using CTEs, window functions, subqueries, CASE expressions and ranking functions.
  
## Dashboard Screenshot

<img width="1165" height="656" alt="Screenshot 2026-07-08 150337" src="https://github.com/user-attachments/assets/77dc9347-e83d-44ee-b170-966475d4c895" />

## Dataset

- **Source:** LendingClub loan-level data (public, historical)
- **Size:** 39,715 loans, 49 columns
- **Tool:** PostgreSQL / pgAdmin4
- **Key rule applied throughout:** the charge-off rate denominator always excludes loans with status `Current` — only `Fully Paid` and `Charged Off` loans are resolved outcomes, so only these are used to calculate default rates. Including `Current` loans would understate risk, since those loans haven't had the chance to default yet.

## Key Findings

**1. The portfolio's overall default rate (14.58%) is roughly 3x a healthy benchmark.**
Roughly 1 in every 7 loans charged off — well above the 3–5% range considered healthy for consumer lending, and the number that justifies every segment-level breakdown that follows.

**2. The lender's grading system works exactly as designed.**
Charge-off rate rises monotonically from Grade A (5.99%) to Grade G (33.78%) — a ~28-point spread. But the practical "risk cliff" isn't E–G as the letters imply — it's the **B/C boundary**. Only Grades A and B outperform the portfolio average; every other grade underperforms it.

**3. Rate and dollar exposure are two different questions — and mixing them up leads to the wrong priorities.**
Grade G has the highest individual charge-off rate (33.78%) but contributes only 1.80% of total portfolio losses, because it's 0.8% of the book by volume. Grade B, with a much lower rate (12.20%), contributes the **most** total losses (25.31%) simply because it's the largest segment. Same pattern with loan purpose: debt consolidation causes 49.18% of all losses at a merely average rate (15.33%), purely on volume. A lender optimizing for total dollar losses should watch Grade B/C and debt consolidation — not chase the highest-rate outliers.

**4. Verification status is a symptom of risk, not a safeguard against it.**
Counterintuitively, "Verified" borrowers default *more* (16.80%) than "Not Verified" borrowers (12.83%). Verification isn't randomly applied — the lender verifies income specifically on applicants whose profile already looks risky (high requested amount vs. income, weaker signals). So verification flags pre-existing suspicion; it doesn't create safety. Unverified borrowers look safer simply because they never triggered a red flag to begin with.

**5. Risk factors compound — they don't just add.**
Grade F loans standalone default at 32.68%; debt consolidation standalone defaults at 15.33%. Combined, Grade F + debt consolidation defaults at 35.79% — higher than either factor alone predicts. Interaction effects matter; single-dimension analysis (grade alone, or purpose alone) understates real risk in specific combinations.

**6. Loan term is an independent, confirmed risk driver.**
60-month loans default at 25.31% vs. 11.09% for 36-month loans — a 14.22-point gap, consistent with the hypothesis that longer repayment windows expose borrowers to more life disruption (job loss, medical events) before the loan is repaid.

## Portfolio Risk Scorecard

| Grade | Charge-Off Rate | vs. Portfolio Avg (14.58%) | Risk Band |
|-------|-----------------|---------------------------|-----------|
| A | 5.99% | −8.59 | Low Risk |
| B | 12.20% | −2.39 | Low Risk |
| C | 17.19% | +2.61 | Moderate Risk |
| D | 21.99% | +7.40 | High Risk |
| E | 26.85% | +12.26 | High Risk |
| F | 32.68% | +18.10 | High Risk |
| G | 33.78% | +19.19 | High Risk |

## Power BI Companion Dashboard

To complement the SQL analysis, I built a Power BI dashboard (`/dashboard/`) covering the same grade-level metrics — charge-off count, resolved count, default rate, portfolio deviation, loan volume share, charge-off share, and risk band — using DAX measures (`CALCULATE`, `FILTER`, `ALL`, `DIVIDE`).

**I used the SQL results in this README as ground truth to cross-check the dashboard, row by row, and caught three real DAX bugs in the process:**

1. A filter condition (`loan_status = "Fully Paid"`) that silently excluded charged-off loans from the "Resolved" denominator
2. A double-counted denominator in the default rate calculation
3. A missing `ALL()` context override that caused the portfolio-average comparison to collapse toward zero on every row, since the measure was silently being filtered by whatever grade row it sat in

Each bug was caught by comparing the dashboard's output directly against the SQL results above — a useful discipline for validating any BI layer built on top of verified query logic, rather than trusting visual output at face value.

*(See `/dashboard/scorecard.pbix` and the accompanying screenshot for the finished, cross-validated dashboard.)*

## Skills Demonstrated

• PostgreSQL
• SQL
• Window Functions
• CTEs
• CASE WHEN
• Subqueries
• Data Aggregation
• Power BI
• DAX
• Business Analytics
• Credit Risk Analysis

## SQL Techniques Used

- **Conditional aggregation:** `COUNT(CASE WHEN ... THEN 1 END)` to calculate numerator and denominator in a single pass (used throughout charge-off rate calculations)
- **Nested subqueries:** 2-layer and 3-layer subquery structures to calculate rates, then filter or rank on those calculated rates
- **`HAVING` vs `WHERE`:** filtering on aggregated values (e.g., excluding grade-purpose combinations with fewer than 100 resolved loans) vs. filtering raw rows
- **Window functions:** `SUM() OVER ()` to broadcast a portfolio-wide average alongside each row, without collapsing results into one summary row — used to calculate volume-weighted averages correctly (as opposed to a plain `AVG()` of already-aggregated rates, which would ignore group size and distort the result)
- **Ranking functions:** `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()` — compared side by side to understand behavior under tied vs. non-tied values
- **`CASE WHEN`** for custom bucketing (interest rate bands, risk scorecard bands)
- **Multi-dimensional `GROUP BY`** (grade × purpose) to detect compounding/interaction risk effects

## How to Run

1. Install PostgreSQL and pgAdmin4 (or any Postgres-compatible client)
2. Load the LendingClub dataset into a table named `loans`
3. Run the queries in order from `/sql/`:
   - `01_portfolio_overview.sql`
   - `02_chargeoff_analysis.sql`
   - `03_risk_drivers.sql`
   - `04_portfolio_exposure.sql`
   - `05_advanced_analytics.sql`
4. Each file is commented with `-- Q1:`, `-- Q2:`, etc. matching the question numbering in this README

## Author

Asif Farook Khaja Moideen — MSc Data Science, University of Greenwich
[[LinkedIn]](https://www.linkedin.com/in/asif-farook-khaja-moideen-77409317a/) · [[GitHub]](https://github.com/farookasif19016/lendingclub-sql-risk-analysis)
