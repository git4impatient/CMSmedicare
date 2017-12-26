--COMPUTE STATS ON ALL
-- CREATE PARQUET VERSIONS OF ALL

--select count(*) from (
use cms;
select g.physician_profile_id, 
sum(g.total_amount_of_payment_usdollars) genpayments ,
sum ( o.total_amount_invested_usdollars ) ownerinvest
from generalpayments g left outer join ownership o on
  g.physician_profile_id =   o.physician_profile_id 
where total_amount_of_payment_usdollars is not null
and  o.total_amount_invested_usdollars is not null

group by physician_profile_id
order by genpayments desc
limit 50
