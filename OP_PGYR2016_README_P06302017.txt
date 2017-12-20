Filename: OP_PGYR2016_README_P06302017.txt
Version: 1.0
Date: June 2017

1. Program Year 2016 Data Files 

This data set includes records submitted for the 2016 program year that have been matched with total confidence to a particular covered recipient (i.e., physician or teaching hospital) and displays information about that recipient. This data set includes the most recent attested-to data for program year 2016 as of May 30, 2017.
The data set contained in the comma-separated value (CSV) file includes only the data that is eligible for publication. Consult the Open Payments Data Dictionary and Methodology document for an explanation of the criteria that the Centers for Medicare and Medicaid Services (CMS) used to determine what data to publish. This document can be found on the Resources page of the Open Payments website (https://www.cms.gov/OpenPayments/About/Resources.html). The Data Dictionary and Methodology document also includes information on the data collection and reporting methodology, data fields included in the files, and any notes or special considerations that users should be aware of.
Each record in General Payment, Research Payment, and Ownership/Investment files includes a Change Type indicator field. The Change Type value of NEW indicates that the record is newly reported by the reporting entity since the last publication and is being published for the first time. 
Since the Program Year 2016 is the latest program year, there is no Removed and Deleted Records file. 
2. Considerations for using the CSV Files 

Microsoft Excel removes leading zeroes from data fields in CSV files. Certain fields in these data sets may have leading zeroes. These zeroes will be missing when viewing the information within Microsoft Excel. 

Additionally, the latest versions of Microsoft Excel cannot display data sets with more than 1,048,576 rows. Some of these CSV files may exceed that limit. Displaying the data in its entirety may require the use of spreadsheet programs capable of handling very large numbers of records.

3. Details about the Datasets Included in this OP_DTL_PGYR2016_P06302017.zip file


This compressed (.zip) file contains three (3) comma-separated values (CSV) files that use commas as delimiters and one (1) README.txt file. Descriptions of each file contained in this compressed (.zip) file are provided below.

File #1 - OP_DTL_GNRL_PGYR2016_P06302017.csv: 
This file contains the data set of General Payments reported for the 2016 program year. General Payments are defined as payments or other transfers of value made to a covered recipient (physician or teaching hospital) that are not made in connection with a research agreement or research protocol. 

File #2 - OP_DTL_RSRCH_PGYR2016_P06302017.csv:
This file contains the data set of Research Payments reported for the 2016 program year. Research Payments are defined as payments or other transfers of value made in connection with a research agreement or research protocol.

File #3 - OP_DTL_OWNRSHP_PGYR2016_P06302017.csv:
This file contains the data set of Ownership and Investment Interest Information reported for the 2016 program year. Ownership and Investment Interest Information is defined as information on the value of ownership or investment interests that a physician or an immediate family member of a physician held in an applicable manufacturer or applicable group purchasing organization (GPO).  

Also available is a supplementary file that displays information for physicians including principal investigators indicated as recipients of payments. This supplementary file can be found in a separate zip file: 

OP_PH_PRFL_SPLMTL_P06302017.zip:
The physician profile information included in the data sets is submitted by the reporting entity. In contrast, the physician information included in the supplementary file can be derived from different sources including the National Plan and Provider Enumeration System (NPPES) and the Provider Enrollment, Chain and Ownership System (PECOS). As a result, the data in these sources may differ slightly. When searching for physicians using the Open Payments search tool on https://openpaymentsdata.cms.gov, use the physician profile information as listed in the supplementary file.
