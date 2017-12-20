 select g.physician_profile_id, 
sum(g.total_amount_of_payment_usdollars) genpayments ,
sum(r.total_amount_of_payment_usdollars )researchpayments,
sum ( o.total_amount_invested_usdollars ) ownerinvest
from generalpayments g left outer join ownership o  on
  g.physician_profile_id =   o.physician_profile_id 
  left outer join researchpayments r on
  g.physician_profile_id =   r.physician_profile_id
where g.total_amount_of_payment_usdollars is not null
--and  o.total_amount_invested_usdollars is not null

group by physician_profile_id
order by genpayments desc
limit 50
