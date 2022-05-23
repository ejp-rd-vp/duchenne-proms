require 'linkeddata'

@g = RDF::Graph.load("https://w3id.org/duchenne-proms")
# RDF::Vocabulary.from_graph(@g, url: "https://w3id.org/duchenne-proms", class_name: "DDP")

sparql = SPARQL::Client.new(@g)
q = <<END
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>
PREFIX dcat: <http://www.w3.org/ns/dcat#>
select ?f ?l ?t where {
?p rdfs:subClassOf <https://w3id.org/duchenne-proms#prom_question> .
?p rdfs:label ?l .
?p dcat:theme ?t .
?p rdfs:seeAlso ?f .
}
END

res = sparql.query(q)

res.each do |r|
  puts "#{r[:f].to_s},\"#{r[:l].to_s}\",\"#{r[:t].to_s}\"\n"
end


 
# def ontology_lookup(id)
#   id = "f29:" + id   # this is the unique hash id of the question in F29 proms.  It is in the "seeAlso" field of the prom ontology class for that question
#   $stderr.puts "looking up #{id}"

#   id.strip!
#   unless @g
#     @g = RDF::Graph.load("https://w3id.org/duchenne-proms")
#     RDF::Vocabulary.from_graph(@g, url: "https://w3id.org/duchenne-proms", class_name: "DDP")
#   end
#   pref = DDP.find("http://www.w3.org/2000/01/rdf-schema#").__prefix__
  
#   DDP.each do |term|
    
#     #pref = DDP.find("http://purl.org/dc/elements/1.1/").__prefix__
#     termid = term.properties[(pref.to_s + ":seeAlso").to_sym].to_s  # check the seeAlso (f29:12331jh4321i24h3iu12h423u)
#     #label = t.properties[:label]
#     #$stderr.puts "#{id}  #{termid}"
    
#     if termid == id
#       #term.properties[:label].gsub!(/\,/, "")
#       #term.properties[:label].gsub!(/\n/, "")
#       #term.properties[:label].gsub!(/\r/, "")
#       return term
#     end
      
#   end
#   return nil
#   #t = DDP.find_term("https://w3id.org/duchenne-proms#DDP_00064")
#   #pref = DDP.find("http://purl.org/dc/elements/1.1/").__prefix__
#   #t.properties[(pref.to_s + ":description").to_sym]
#   #t.properties[:label]
#   #
#   #> t.properties
#   # => {:subClassOf=>#<RDF::URI:0x67c78 URI:https://w3id.org/duchenne-proms#prom_question>, :"dc11:identifier"=>#<RDF::Literal:0xcb660("DDP_00064")>, :type=>#<RDF::Vocabulary::Term:0x3520 ID:http://www.w3.org/2002/07/owl#Class>, :"dc11:description"=>#<RDF::Literal:0xcb674("Chewing"@en)>, :label=>#<RDF::Literal:0xcb688("Chewing"@en)>} 
#   #
#   #t.entail(:subClassOf)
# end

