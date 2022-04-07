# Types of Tests Mappings

Mappings for the data contained within the "typeoftest" fields from the "cardiotest", "respiratorytests", "bonehealtest", "bloodtest" and "surgery" visits from the medical care data 

## CSV file 

### CSV file
Please find the CSV file [here](../term_mappings/typesOfTests_mappings.csv)

### Columns

databaseName, testURI, testPrefName


## Notes:
  * databaseName - the **EXACT** contents of the "Support" and "Living Situation" fields in the database
  * testURI - matching URI ([NCIT](http://www.ontobee.org/ontology/NCIT) preferred) for the test from the database
  * testPrefName - preferred name for the test as stated in the ontology where its URI was extracted from
  