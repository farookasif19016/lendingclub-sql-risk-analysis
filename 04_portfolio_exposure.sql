-- Q15 — grades contributing most charge-offs, by count and share.

-- select grade,
-- count(*) as portfolio_share,
-- count(case when loan_status = 'Charged Off' then 1 end) as chargeoff,
-- round(count(case when loan_status = 'Charged Off' then 1 end) * 100 :: numeric / (select count(*) from loans where loan_status = 'Charged Off'),2) as share_of_total_chargeoff
-- from loans
-- where loan_status in ('Charged Off','Fully Paid')
-- group by grade

-- Q16 - purposes contributing most charge-offs.

-- select purpose,
-- count(*) as portfolio_share,
-- count(case when loan_status = 'Charged Off' then 1 end) as charge_off,
-- round(count(case when loan_status = 'Charged Off' then 1 end) * 100 :: numeric / (select count(*) from loans where loan_status = 'Charged Off'),2) as chargeoff_per_purpose
-- from loans
-- where loan_status in ('Charged Off','Fully Paid')
-- group by purpose;

-- Q17 — small business risk: default rate, exposure, and contribution

-- select
-- round(sum(funded_amnt):: numeric,2) as tot_funded_amnt,
-- round(count(case when loan_status ='Charged Off' then 1 end) * 100 :: numeric/ (select count(*) from loans where loan_status = 'Charged Off'),2) as chargeoff_share,
-- count(case when loan_status ='Charged Off' then 1 end) as sb_chargeoff_count,
-- count(case when loan_status in ('Fully Paid','Charged Off') then 1 end) as sb_resolved_count,
-- round(count(case when loan_status ='Charged Off' then 1 end) * 100 :: numeric/ count(case when loan_status in ('Fully Paid','Charged Off') then 1 end),2) as sb_chargeoff_rate
-- from loans
-- where loan_status in ('Fully Paid','Charged Off') and purpose = 'small_business';

-- Q18 — grade-purpose combinations with highest risk exposure

-- select grade, purpose,
-- count(case when loan_status = 'Charged Off' then 1 end) as chargeoff_count,
-- count(case when loan_status in ('Charged Off','Fully Paid') then 1 end) as resolved_count,
-- round(count(case when loan_status = 'Charged Off' then 1 end) * 100 :: numeric/ count(case when loan_status in ('Charged Off','Fully Paid') then 1 end),2) as chargeoff_rate
-- from loans
-- where loan_status in ('Charged Off','Fully Paid')
-- group by grade, purpose
-- having count(case when loan_status in ('Charged Off','Fully Paid') then 1 end) >= 100
-- order by chargeoff_rate desc;

-- Q19 — rank borrower segments by portfolio risk exposure

-- select grade,
-- count(case when loan_status = 'Charged Off' then 1 end) as charge_off,
-- count(case when loan_status in ('Charged Off','Fully Paid') then 1 end) as resolved_chargeoff,
-- round(count(case when loan_status = 'Charged Off' then 1 end) * 100 :: numeric/ (select count(*) from loans where loan_status = 'Charged Off'),2) as portfolio_chargeOff,
-- dense_rank() over (order by 
-- round(count(case when loan_status = 'Charged Off' then 1 end) * 100 :: numeric/ (select count(*) from loans where loan_status = 'Charged Off'),2) desc
-- ) as risk_rank
-- from loans
-- where loan_status in ('Charged Off','Fully Paid')
-- group by grade
