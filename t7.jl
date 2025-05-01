add(x::Int, y::Int) = x + y
add(x::String, y::String) = string(x, y)

println(add(3, 5))
println(add("Hello ", "Julia"))