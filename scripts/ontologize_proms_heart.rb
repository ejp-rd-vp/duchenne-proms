require './write.rb'
count = File.read("./currentcount.txt").to_i

promlist = File.read('./proms_count.txt')
promlist = promlist.split("\n")
#puts "heart_clauses.rdf", promlist.class
#puts "heart_clauses.rdf", promlist.first

ordered = Hash.new
questions = ""
promlist.sort.each do |prom|
  prom =~ /\s+\"(.*)\"/
  data = $1

  split = data.split('||')
  next unless split[0] == "Heart condition"
  ordered[split[2]]=split[1]
  
  
end

ordered.each do |question|
  number = sprintf("%05d", count) # UPDATE THIS LINE
  label = question[1]
  question = question[0]
  clause = %{
    <!-- https://w3id.org/duchenne-proms#DDP_#{number} -->
    
        <owl:Class rdf:about="https://w3id.org/duchenne-proms#DDP_#{number}">
            <rdfs:subClassOf rdf:resource="https://w3id.org/duchenne-proms#prom_question"/>
            <rdfs:label xml:lang="en">#{label}</rdfs:label>
            <dc:description xml:lang="en">#{question}</dc:description>
            <dc:identifier>DDP_#{number}</dc:identifier>
        </owl:Class>
        
        }
              
    puts "heart_clauses.rdf", clause
    questions = questions + %{<rdf:Description rdf:about="https://w3id.org/duchenne-proms#DDP_#{number}"/>\n}
    count +=1
      
end

puts "heart_clauses.rdf", %{
    <owl:Class rdf:about="https://w3id.org/duchenne-proms#heart_condition_section">
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
               <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">Heart Condition Section</rdfs:label>

    </owl:Class>
}


File.open("currentcount.txt", "w") do |f|
  f.write count
end