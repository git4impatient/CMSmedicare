# wget http://download.cms.gov/openpayments/PGYR16_P011718.ZIP
# warning the cms.gov site changes the names of the files this was the old namePGYR16_P063017.ZIP
# continued moving target  
# get new link here:  https://openpaymentsdata.cms.gov/

wget http://download.cms.gov/openpayments/PGYR17_P062918.ZIP


jar -xvf  PGYR17_P062918.ZIP 

sudo -u hdfs hadoop fs -mkdir /user/$USER
sudo -u hdfs hadoop fs -chown $USER:$USER /user/$USER  
hadoop fs -rm -R /user/$USER/cms.db/ownership
hadoop fs -rm -R /user/$USER/cms.db/generalpayments
hadoop fs -rm -R /user/$USER/cms.db/researchpayments
hadoop fs -mkdir /user/$USER/cms.db
hadoop fs -mkdir /user/$USER/cms.db/ownership
hadoop fs -mkdir /user/$USER/cms.db/researchpayments
hadoop fs -mkdir /user/$USER/cms.db/generalpayments
hadoop fs -put  *OWNRSHP_*.csv /user/$USER/cms.db/ownership
hadoop fs -put  OP_DTL_GNRL_P*.csv  /user/$USER/cms.db/generalpayments
hadoop fs -put  OP_DTL_RSRCH_P*.csv /user/$USER/cms.db/researchpayments
export DATANODE=$(sudo su - hdfs -c "hdfs dfsadmin -report | grep Hostname | sed 's/.*: //'  | tail -1")
impala-shell -i $DATANODE -f cmsdb.ddl
impala-shell -i $DATANODE -f generalpayments.ddl 
impala-shell -i $DATANODE -f researchpayments.ddl 
impala-shell -i $DATANODE -f ownership.ddl 
