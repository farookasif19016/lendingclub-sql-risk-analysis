-- Q10 — interest rate comparison, charged off vs fully paid.

-- select loan_status, round(avg(int_rate) :: numeric,2) as avg_int
-- from loans	
-- where loan_status in ('Fully Paid','Charged Off')
-- group by loan_status

-- Q11 — borrower income, charged off vs fully paid.

-- select loan_status, round(avg(annual_inc)::numeric,2) as avg_income
-- from loans
-- where loan_status in ('Fully Paid','Charged Off')
-- group by loan_status;

-- Q12 — DTI (debt-to-income ratio), charged off vs fully paid. 

-- select loan_status, round(avg(dti):: numeric,2) as avg_dti
-- from loans
-- where loan_status in ('Fully Paid','Charged Off')
-- group by loan_status;

-- Q13 — loan term influence on charge-off risk

-- select term, chargeoff, resolved_count,
-- round(chargeoff * 100 :: numeric / resolved_count,2) as rate
-- from (
-- select 
-- term,
-- count(case when loan_status = 'Charged Off' then 1 end) as chargeoff,
-- count(case when loan_status in ('Charged Off','Fully Paid') then 1 end) as resolved_count
-- from loans
-- where loan_status in ('Charged Off','Fully Paid')
-- group by term
-- ) as charge_off
-- order by term

-- Q14 — higher interest rate loans and default rates

-- select rate_band, chargeoff, resolved_count,
-- round(chargeoff * 100 :: numeric / resolved_count,2) as rate
-- from (
-- select 
-- case 
--      when int_rate < 10 then ('<10')
--      when int_rate between 10 and 15 then ('10-15%')
--      else 'High >15%'
-- end as rate_band,
-- count(case when loan_status = 'Charged Off' then 1 end) as chargeoff,
-- count(case when loan_status in ('Charged Off','Fully Paid') then 1 end) as resolved_count
-- from loans
-- where loan_status in ('Charged Off','Fully Paid')
-- group by rate_band
-- ) as bands
-- order by rate_band;
