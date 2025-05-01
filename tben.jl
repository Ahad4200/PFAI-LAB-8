using Plots

x = 1:10
y = x .^ 2
plot(x, y, title="y = x^2")
savefig("plot.png")