require 'json'

count = 189

    #<!-- https://w3id.org/duchenne-proms#DDP_00188 -->
    #
    #<owl:Class rdf:about="https://w3id.org/duchenne-proms#DDP_00188">
    #    <rdfs:subClassOf rdf:resource="https://w3id.org/duchenne-proms#prom_question"/>
    #    <dc:description xml:lang="en">What other aspects would you like to report?</dc:description>
    #    <dc:identifier>DDP_00188</dc:identifier>
    #    <resource:SIO_000628>f29:5e873b20c717560738660404</resource:SIO_000628>
    #    <rdfs:label xml:lang="en">COVID-19: What other aspects would you like to report?</rdfs:label>
    #</owl:Class>
    

json = File.read("one_PROM_Feb2021.json")
json = JSON.parse(json)

clauses = []
json.each do |sec|
  section = sec["section"]["name"]
  # COMMENT THE NEXT LINE TO REGEN ONTOLOGY FROM_SCRATCH
  next unless section == "Questionnaire Activities"  # to add teh questionnaire stuff to the ontology
  sectiontitle =  section.downcase + "_section"
  questions = ""
  
  sec["promsStructure"].each do |str|
    next if ["Title", "Label", ""].include?(str["structure"]["responseType"])
    if str["structure"]["name"].downcase == str["structure"]["question"].downcase
      label = sec["section"]["name"] + ": " + str["structure"]["name"]
    else
      label = sec["section"]["name"] + ": " + str["structure"]["name"] + " - " + str["structure"]["question"]
    end
    question = str["structure"]["question"]
    number = sprintf("%05d", count) # UPDATE THIS LINE
    duchenne_id = "f29:" + str["structure"]["_id"]

    
      clause = %{
    <!-- https://w3id.org/duchenne-proms#DDP_#{number} -->
    
        <owl:Class rdf:about="https://w3id.org/duchenne-proms#DDP_#{number}">
            <rdfs:subClassOf rdf:resource="https://w3id.org/duchenne-proms#prom_question"/>
            <rdfs:label xml:lang="en">#{label}</rdfs:label>
            <dc:description xml:lang="en">#{question}</dc:description>
            <dc:identifier>DDP_#{number}</dc:identifier>
            <resource:SIO_000628>#{duchenne_id}</resource:SIO_000628>
        </owl:Class>
        
        }
      clauses << clause
      
    questions = questions + %{<rdf:Description rdf:about="https://w3id.org/duchenne-proms#DDP_#{number}"/>\n}
    count +=1
  end
      

  sectionclause = %{
    <owl:Class rdf:about="https://w3id.org/duchenne-proms##{sectiontitle}_section">
        <owl:equivalentClass>
            <owl:Restriction>
                <owl:onProperty rdf:resource="http://semanticscience.org/resource/SIO_000028"/>
                <owl:someValuesFrom>
                    <owl:Class>
                        <owl:unionOf rdf:parseType="Collection">
#{questions}
                        </owl:unionOf>
                    </owl:Class>
                </owl:someValuesFrom>
            </owl:Restriction>
        </owl:equivalentClass>
        <owl:equivalentClass>
            <owl:Restriction>
                <owl:onProperty rdf:resource="http://semanticscience.org/resource/SIO_000028"/>
                <owl:allValuesFrom>
                    <owl:Class>
                        <owl:unionOf rdf:parseType="Collection">
#{questions}
                        </owl:unionOf>
                    </owl:Class>
                </owl:allValuesFrom>
            </owl:Restriction>
        </owl:equivalentClass>
        <rdfs:subClassOf rdf:resource="http://semanticscience.org/resource/SIO_000171"/>
        <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">#{section} Section</rdfs:label>

    </owl:Class>
}

  clauses << sectionclause
  
end

header = %{<?xml version="1.0"?>
<rdf:RDF xmlns="https://w3id.org/duchenne-proms#"
     xml:base="https://w3id.org/duchenne-proms"
     xmlns:dc="http://purl.org/dc/elements/1.1/"
     xmlns:owl="http://www.w3.org/2002/07/owl#"
     xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
     xmlns:xml="http://www.w3.org/XML/1998/namespace"
     xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
     xmlns:cito="http://purl.org/spar/cito/"
     xmlns:foaf="http://xmlns.com/foaf/0.1/"
     xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
     xmlns:vann="http://purl.org/vocab/vann/"
     xmlns:void="http://rdfs.org/ns/void#"
     xmlns:terms="http://purl.org/dc/terms/"
     xmlns:schema="http://schema.org/"
     xmlns:protege="http://protege.stanford.edu/plugins/owl/protege#"
     xmlns:resource="http://semanticscience.org/resource/">
    <owl:Ontology rdf:about="https://w3id.org/duchenne-proms">
        <owl:imports rdf:resource="http://semanticscience.org/ontology/sio/v1.48/sio-release.owl"/>
        <rdfs:comment xml:lang="en">An ontology for the Duchenne Data Platform PROMs from Foundation29</rdfs:comment>
        <rdfs:label xml:lang="en">Foundation29 PROMs</rdfs:label>
    </owl:Ontology>
    
}

question_subclass =  %{
    <owl:Class rdf:about="https://w3id.org/duchenne-proms#prom_question">
        <rdfs:label xml:lang="en">PROM Question from Foundation29</rdfs:label>
        <rdfs:subClassOf rdf:resource="http://semanticscience.org/resource/SIO_000171"/>
    </owl:Class>
}

footer = %{
</rdf:RDF>
}

puts header
puts question_subclass
clauses.each {|e| puts e }
puts footer

