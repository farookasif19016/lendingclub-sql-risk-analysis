-- Q1 — Portfolio Overview

/* select count(*),
sum(loan_amnt) as tot_amnt,
sum(funded_amnt) as fund_amnt, 
round(avg(funded_amnt)::numeric, 2) as avg_funded_amnt,
round(avg(loan_amnt)::numeric, 2) as avg_loan_amnt,
round(avg(loan_amnt)::numeric - avg(funded_amnt)::numeric,2) as avg_funding_gap
from loans */

--Q2 — loan distribution across grades, count and portfolio share.

/* select grade, 
count(*) as loan_count,
round(count(*) * 100.0 :: numeric / (select count(*) from loans),2) as portfolio_share
from loans
group by grade 
order by grade */

--Q3 — loan distribution by purpose, count, portfolio share, and average funding gap per purpose.

/* select purpose, 
count(*), 
round(count(*)*100 :: numeric/(select count(*) from loans),2) as portfolio_purpose_share,
round(avg(loan_amnt)::numeric - avg(funded_amnt)::numeric,2) as avg_funding_gap
from loans
group by purpose; */

--Q4 - Loan Term Distribution by term, count, portfolio share

/* select term, count(*), round(count(*) * 100 :: numeric / (select count(*) from loans),2) as portfolio_share
from loans 
group by term; */