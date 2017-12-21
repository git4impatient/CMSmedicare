use cms;
select g.physician_profile_id, 
sum(g.total_amount_of_payment_usdollars) cms.genpayments ,
sum(r.total_amount_of_payment_usdollars )cms.researchpayments,
sum ( o.total_amount_invested_usdollars ) cms.ownerinvest
from generalpayments g left outer join ownership o  on
  g.physician_profile_id =   o.physician_profile_id 
  left outer join researchpayments r on
  g.physician_profile_id =   r.physician_profile_id
where g.total_amount_of_payment_usdollars is not null
and  g.physician_profile_id not like ""
--and  o.total_amount_invested_usdollars is not null

group by g.physician_profile_id
order by genpayments desc
limit 50
