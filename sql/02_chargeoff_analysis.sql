-- Q5 — overall charge-off rate as a percentage.

/* select loan_status, count(*), 
round(count(*) * 100 :: numeric / (select count(*) from loans where loan_status in ('Charged Off','Fully Paid')),2) as portfolio_share
from loans
where loan_status = 'Charged Off' 
group by loan_status */


-- Q6 — charge-off rate by grade, ranked

/* select 
grade,
chargeoff_count,
resolved_chargeoff,
round(chargeoff_count * 100 :: numeric/ resolved_chargeoff,2) as rate
from (
select grade,
count(case when loan_status = 'Charged Off' then 1 end) as chargeoff_count,
count(case when loan_status in ('Charged Off','Fully Paid') then 1 end) as resolved_chargeoff
from loans
where loan_status in ('Charged Off','Fully Paid')
group by grade
) as chargeoff
order by grade */

-- Q7 — charge-off rate by purpose

-- select 
-- purpose,
-- chargeoff_count,
-- resolved_count,
-- round(chargeoff_count * 100 :: numeric / resolved_count, 2) as chargeoff_rate
-- from (
-- select purpose,
-- count(case when loan_status = 'Charged Off' then 1 end) as chargeoff_count,
-- count(case when loan_status in ('Fully Paid','Charged Off') then 1 end) as resolved_count
-- from loans 
-- where loan_status in ('Fully Paid','Charged Off')
-- group by purpose
-- ) as rate

-- Q8 — charge-off rate by verification status

-- select 
-- verification_status,
-- chargedoff_count,
-- resolved_count,
-- round(chargedoff_count * 100 :: numeric / resolved_count,2) as Chargeoff_rate
-- from (
-- select 
-- verification_status,
-- count(case when loan_status = 'Charged Off' then 1 end) as chargedoff_count,
-- count(case when loan_status in ('Fully Paid','Charged Off') then 1 end) as resolved_count
-- from loans 
-- where loan_status in ('Fully Paid','Charged Off')
-- group by verification_status
-- ) as Chargeoff_rate 

-- Q9 — borrower segments exceeding 20% charge-off rate 

-- select
-- grade,
-- chargeoff_count,
-- resolved_count,
-- rate
-- from (
-- SELECT 
--         grade,
--         chargeoff_count,
--         resolved_count,
--         ROUND(chargeoff_count * 100.0::NUMERIC / resolved_count, 2) AS rate
-- from(		
-- select 
-- grade,
-- count(case when loan_status = 'Charged Off' then 1 end) as chargeoff_count,
-- count(case when loan_status in ('Fully Paid','Charged Off') then 1 end) as resolved_count
-- from loans
-- where loan_status in ('Charged Off','Fully Paid')
-- group by grade  
-- ) as cr
-- ) as rates
-- where rate > 20
-- order by grade desc;
