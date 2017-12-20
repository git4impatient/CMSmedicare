wget http://download.cms.gov/openpayments/PGYR16_P063017.ZIP
unzip PGYR16_P063017.ZIP
hadoop fs -rm -R /user/$USER/cms.db/ownership
hadoop fs -rm -R /user/$USER/cms.db/generalpayments
hadoop fs -rm -R /user/$USER/cms.db/researchpayments
hadoop fs -mkdir /user/$USER/cms.db/ownership
hadoop fs -mkdir /user/$USER/cms.db/researchpayments
hadoop fs -mkdir /user/$USER/cms.db/generalpayments
hadoop fs -put  OP_DTL_OWNRSHP_PGYR2016_P06302017.csv.sample /user/$USER/cms.db/ownership
hadoop fs -put  OP_DTL_GNRL_PGYR2016_P06302017.csv.sample  /user/$USER/cms.db/generalpayments
hadoop fs -put  OP_DTL_RSRCH_PGYR2016_P06302017.csv.sample /user/$USER/cms.db/researchpayments
impala-shell -f generalpayments.ddl 
impala-shell -f researchpayments.ddl 
impala-shell -f ownership.ddl 
