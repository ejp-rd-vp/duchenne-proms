f = File.read("./duchenne-proms.owl")
o = File.open("questions.csv", "w")

t = f.scan(/Class\srdf\:about\="https:\/\/w3id(.*?)\<\/owl\:Class/m)
puts t.class

t.each do |p|
m1 = p.first.match(/dc:identifier\>(ddp:[^\<]+)\</m)
next unless m1
puts m1[1]

m2 = p.first.match(/rdfs:label[^\>]+\>(.*?)\</m)
puts m2[1]
o.puts(m1[1]+ "," + m2[1])

end
o.close

