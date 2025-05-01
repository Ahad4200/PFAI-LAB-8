open("data.txt", "w") do file
    write(file, "Julia is fast!")
end

content = read("data.txt", String)
println("File content: $content")