#copyright 2019 Martin Lurie
# sample code not supported
# use pairplot and logistic regression to 
# predict if a claim will be disputed



from __future__ import print_function
!echo $PYTHON_PATH
import os, sys
#import path
from pyspark.sql import *

# create spark sql session
myspark = SparkSession\
    .builder\
    .appName("CMS_kmeans") \
    .getOrCreate()



sc = myspark.sparkContext

import time
print ( time.time())

sc.setLogLevel("ERROR")
print ( myspark )
# make spark print text instead of octal
myspark.sql("SET spark.sql.parquet.binaryAsString=true")

# read in the data file from HDFS
cmsdf = myspark.read.parquet ( "/user/hive/warehouse/cms.db/cmsml")
# also read from s3 mydf = myspark.read.parquet ( "s3a://impalas3a/sample_07_s3a_parquet")
# print number of rows and type of object
print ( cmsdf.count() )
print  ( cmsdf )

# create a table name to use for queries
cmsdf.createOrReplaceTempView("cmsdata")
# run a query
bigpayments=myspark.sql('select * from cmsdata where pmtdollars > 100000')
bigpayments.show(5)

# pairplot to see what we have...
import seaborn as sns
import pandas

cms1000=myspark.sql('select specialty, hospitalordoctor, drug, disputed, state, pmtmonth, pmtdollars from cmsdata where pmtdollars <  10000 limit 5000')
cms1000.show(3)
# seaborn wants a pandas dataframe, not a spark dataframe
# so convert
pdsdf = cms1000.toPandas()

sns.set(style="ticks" , color_codes=True)
# this takes a long time to run:  
# you can see it if you uncomment it
g = sns.pairplot(pdsdf,  hue="disputed" )

# predict if a payment will be disputed



# we can skip this step since we used Impala to make the 
# data numeric and normalize
# need to convert from text field to numeric
# this is a common requirement when using sparkML
#from pyspark.ml.feature import StringIndexer
# this will convert each unique string into a numeric
#indexer = StringIndexer(inputCol="txtlabel", outputCol="label")
#indexed = indexer.fit(mydf).transform(mydf)
#indexed.show(5)
# now we need to create  a  "label" and "features"
# input for using the sparkML library

cmsdispute=myspark.sql('select disputed label, specialty, hospitalordoctor, drug, state, pmtmonth, pmtdollars from cmsdata where pmtdollars <  10000 limit 5000')

from pyspark.ml.feature import VectorAssembler
from pyspark.ml.linalg import Vectors

assembler = VectorAssembler(
    inputCols=[ "specialty", "hospitalordoctor", "drug", "state", "pmtmonth", "pmtdollars"],
    outputCol="features")
output = assembler.transform(cmsdispute)
# note the column headers - label and features are keywords
print ( output.show(3) )
from pyspark.ml.classification import LogisticRegression

# Create a LogisticRegression instance. This instance is an Estimator.
lr = LogisticRegression(maxIter=10, regParam=0.01)
# Print out the parameters, documentation, and any default values.
print("LogisticRegression parameters:\n" + lr.explainParams() + "\n")

# Learn a LogisticRegression model. This uses the parameters stored in lr.
model1 = lr.fit(output)

#### Major shortcut - no train and test data!!!
# Since model1 is a Model (i.e., a transformer produced by an Estimator),
# we can view the parameters it used during fit().
# This prints the parameter (name: value) pairs, where names are unique IDs for this
# LogisticRegression instance.
print("Model 1 was fit using parameters: ")
print(model1.extractParamMap())

trainingSummary = model1.summary

# Obtain the objective per iteration
objectiveHistory = trainingSummary.objectiveHistory
print("objectiveHistory:")
for objective in objectiveHistory:
    print(objective)

# Obtain the receiver-operating characteristic as a dataframe and areaUnderROC.
trainingSummary.roc.show()
print("areaUnderROC: " + str(trainingSummary.areaUnderROC))

prediction = model1.transform(output)
prediction.show(3)
result = prediction.select("label", "probability", "prediction") \
    .collect()
#print(result)
i=0
for row in result:
   if ( row.label != row.prediction ):
    print("label=%s, prob=%s, prediction=%s" \
          % (row.label, row.probability, row.prediction))
    i=i+1
    if ( i > 10):
      break

trainingSummary.roc.show()
print("areaUnderROC: " + str(trainingSummary.areaUnderROC))    
# Now try with only 2 predictors
assembler = VectorAssembler(
    inputCols=[ "specialty", "drug"],
    outputCol="features")
output = assembler.transform(cmsdispute)
model2 = lr.fit(output)
trainingSummary = model2.summary

# Obtain the receiver-operating characteristic as a dataframe and areaUnderROC.
trainingSummary.roc.show()
print("areaUnderROC: " + str(trainingSummary.areaUnderROC))
    
import pickle
import cdsw

# Output
filename = 'model.pkl'
pickle.dump(model1, open(filename, 'wb'))
cdsw.track_file(filename)
