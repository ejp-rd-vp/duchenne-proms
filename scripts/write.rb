def puts(filename, string)
    File.write(filename, string, mode: "a")
    
end