# UCI Reasons Mappings

Mappings for the data contained within the "reason" field from the "hospitalization" visits where the "uci" field is true from the medical care data 

## CSV file 

### CSV file
Please find the CSV file [here](../term_mappings/uciReasons_mappings.csv)

### Columns

databaseName, reasonURI, reasonPrefName


## Notes:
  * databaseName - the **EXACT** contents of the "Support" and "Living Situation" fields in the database
  * reasonURI - matching URI ([NCIT](http://www.ontobee.org/ontology/NCIT) preferred) for the reason from the database
  * reasonPrefName - preferred name for the reason as stated in the ontology where its URI was extracted from
  