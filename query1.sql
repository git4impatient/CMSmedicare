--select count(*) from (
select g.physician_profile_id, 
sum(g.total_amount_of_payment_usdollars) totpayments ,
sum ( o.total_amount_invested_usdollars ) ownerinvest
from generalpayments g left outer join ownership o on
  g.physician_profile_id =   o.physician_profile_id 
where total_amount_of_payment_usdollars is not null
and  o.total_amount_invested_usdollars is not null

group by physician_profile_id
order by totpayments desc
limit 50
