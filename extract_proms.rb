count = 1

promlist = File.read('./proms_count.txt')
promlist = promlist.split("\n")
puts promlist.class
puts promlist.first

ordered = Hash.new
promlist.sort.each do |prom|
  prom =~ /\s+\"(.*)\"/
  data = $1

  split = data.split('||')
  next unless split[0] == "Questionnaire Activities"
  next unless split[2] =~ /^\d/
  ordered[split[2]]=split[1]
  
  
end

ordered = ordered.sort_by { |s,v| s.scan(/\d+/).first.to_i }

ordered.each do |question|
  number = sprintf("%04d", count)
  label = question[1]
  question = question[0]
  clause = %{
    <!-- https://w3id.org/duchenne-proms#DDP_#{number} -->
    
        <owl:Class rdf:about="https://w3id.org/duchenne-proms#dpp_prom_#{number}">
            <rdfs:subClassOf rdf:resource="https://w3id.org/duchenne-proms#prom_question"/>
            <rdfs:label xml:lang="en">#{label}</rdfs:label>
            <dc:description xml:lang="en">#{question}</dc:description>
            <dc:identifier>DDP_#{number}</dc:identifier>
        </owl:Class>
        
        }
              
    puts clause
    count +=1
      
end
