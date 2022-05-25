# Clinician Roles Mappings

Mappings for the data contained within the "clinician" fields from the "general" and "specificVisit" visits from the medical care data

## CSV file

### CSV file

Please find the CSV file [here](../term_mappings/medicalCareClinicianRoles_mappings.csv)

### Columns

databaseName, clinicianRoleURI, clinicianRolePrefName

## Notes:

- databaseName - the **EXACT** contents of the "clinician" field in the database
- clinicianRoleURI - matching URI ([NCIT](http://www.ontobee.org/ontology/NCIT) preferred) for the clinician role from the database. The default is http://purl.obolibrary.org/obo/NCIT_C25741
- clinicianRolePrefName - preferred name for the clinician role as stated in the ontology where its URI was extracted from. The default is "Physician"

## Comments:

- The database contained "Other" as the clinician for a medical visit. Due to the lack of information, we mapped it to [Physician](https://www.ontobee.org/ontology/NCIT?iri=http://purl.obolibrary.org/obo/NCIT_C25741)
