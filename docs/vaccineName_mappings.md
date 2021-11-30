# Vaccine and Disease Mappings

Mappings for the data contained within the "name" field from the vaccine data 

## CSV file 

### CSV file
Please find the CSV file [here](../csv/vaccineName_mappings.csv)

### Columns

databaseName,vaccineURI,vaccinePrefName,diseaseURI,diseasePrefName


## Notes:
  * databaseName - the EXACT contents of the "name" field in the database
  * vaccineURI - matching URI ([VO](http://www.ontobee.org/ontology/VO) preferred) for the name of the vaccine from the database
  * vaccinePrefName - preferred name for the vaccione as stated in the ontology where its URI was extracted from
  * diseaseURI - matching URI ([NCIT](http://www.ontobee.org/ontology/NCIT) preferred) for the disease that is the target of the vaccine from the database
  * diseasePrefName - preferred name for the disease that is the target of the vaccine from the database as stated in the ontology where its URI was extracted from
  