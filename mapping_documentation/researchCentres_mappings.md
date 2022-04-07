# Research Centres Mappings

Mappings for the data contained within the "hospital" and "otherHospital" fields from the "general", "specificVisit", "emergencies" and "hospitalization" visits from the medical care data 

## CSV file 

### CSV file
Please find the CSV file [here](../term_mappings/researchCentres_mappings.csv)

### Columns

databaseName,centerURI,centerPrefName


## Notes:
  * databaseName - the **EXACT** contents of the "hospital" field in the database, unless it is "Other", then it should be the contents of the "otherHospital" field
  * centerURI - matching URI ([ROR](https://ror.org/) preferred) for the hospital name from the database
  * centerPrefName - preferred name for the hospital as stated in the ontology where its URI was extracted from
  