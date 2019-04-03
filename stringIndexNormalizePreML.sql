-- (C) copyright 2019 Martin Lurie
-- sample code not supported
-- create table for ML analysis 
-- using a subset of available columns
-- code 0169-4060-90 is
-- Victoza® is an injectable prescription medicine 
-- that may improve blood sugar in adults with type 2 diabetes.

-- you can also string-indexer and normalize the values
-- in CDSW with python etc

drop table if exists cmsml;
create table cmsml stored as parquet  as 
select 
abs( fnv_hash(physician_profile_id))/9999999999999999999 profileid,
 abs( fnv_hash(physician_specialty))/9999999999999999999 specialty,
 abs( fnv_hash(covered_recipient_type))/9999999999999999999 hospitalordoctor, 
 abs( fnv_hash(associated_drug_or_biological_ndc_1))/9999999999999999999 drug,
 case  when dispute_status_for_publication ='"No"' then 0 
  else 1
  end  disputed,
   abs( fnv_hash(  recipient_state ))/9999999999999999999 state,
 abs( fnv_hash(  substr( recipient_zip_code, 2, 5 )))/9999999999999999999 myzip,
 abs( fnv_hash( strleft(date_of_payment,3)))/9999999999999999999 pmtmonth,
cast (total_amount_of_payment_usdollars as float ) pmtdollars
from generalpayments_p
limit 100000
;

select * from cmsml;


select disputed, count(*)  from cmsml group by disputed;
select   dispute_status_for_publication, count(*) from generalpayments_p
group by dispute_status_for_publication
order by count(*) desc;

--select abs( fnv_hash( date_of_payment))/9999999999999999999 from generalpayments_p
