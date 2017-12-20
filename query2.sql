select g.physician_profile_id, 
sum(g.total_amount_of_payment_usdollars) genpayments , count(*) 
from generalpayments g 
where g.total_amount_of_payment_usdollars is not null
group by physician_profile_id
order by genpayments desc
limit 50;
