drop table if exists cms.ownership;
use cms;
create external table ownership(
change_type string,
physician_profile_id string,
physician_first_name string,
physician_middle_name string,
physician_last_name string,
physician_name_suffix string,
recipient_primary_business_street_address_line1 string,
recipient_primary_business_street_address_line2 string,
recipient_city string,
recipient_state string,
recipient_zip_code string,
recipient_country string,
recipient_province string,
recipient_postal_code string,
physician_primary_type string,
physician_specialty string,
record_id string,
program_year string,
total_amount_invested_usdollars decimal(18,3),
value_of_interest decimal(18,3),
terms_of_interest string,
submitting_applicable_manufacturer_or_applicable_gpo_name string,
applicable_manufacturer_or_applicable_gpo_making_payment_id string,
applicable_manufacturer_or_applicable_gpo_making_payment_name string,
applicable_manufacturer_or_applicable_gpo_making_payment_state string,
applicable_manufacturer_or_applicable_gpo_making_payment_country string,
dispute_status_for_publication string,
interest_held_by_physician_or_an_immediate_family_member string,
payment_publication_date string
)

row format delimited
fields terminated by ','
stored as textfile
location '/user/centos/cms.db/ownership'
;
select * from ownership limit 3;


--"new","1156082","dan",,"azagury",,"300 pasteur dr h3680a",,"stanford","ca","94305-2200","united states",,,"medical doctor","allopathic & osteopathic physicians|surgery","345994234","2016",0.00,330.00,"common stock shareholder","ciel medical inc","100000151571","ciel medical inc","ca","united states","no","physician covered recipient","06/30/2017"
