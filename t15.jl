using Flux
using Random

# Set random seed for reproducibility
Random.seed!(123)

# Create a simple linear model 
model = Dense(1 => 1)

# Manually set initial weight to ensure positive slope
model.weight .= Float32[1.0]
model.bias .= Float32[0.0]
println("Initial model parameters: Weight = $(model.weight), Bias = $(model.bias)")
# Create training data with consistent Float32 type
X = Float32[1.0, 2.0, 3.0]
Y = Float32[2.0, 4.0, 6.0]

# Reshape inputs to column vectors with correct dimensions
data = [(reshape([X[i]], 1, 1), reshape([Y[i]], 1, 1)) for i in 1:3]

# Define loss function
function loss(m, x, y)
    return Flux.mse(m(x), y)
end

# Calculate total loss over the dataset
function total_loss()
    sum(loss(model, x, y) for (x, y) in data)
end

# Set up optimizer with lower learning rate for stability
opt = Flux.setup(ADAM(0.01), model)

# Training loop with more epochs
num_epochs = 1000
println("Starting training...")

for epoch in 1:num_epochs
    # Calculate gradients and update weights
    for (x, y) in data
        grad = gradient(m -> loss(m, x, y), model)
        Flux.update!(opt, model, grad[1])
    end
    
    # Print progress every 100 epochs
    if epoch % 100 == 0 || epoch == 1
        current_loss = total_loss()
        println("Epoch $epoch: Loss = $current_loss, Weight = $(model.weight[1]), Bias = $(model.bias[1])")
    end
end

println("\nTraining complete!")
println("Final model parameters: Weight = $(model.weight[1]), Bias = $(model.bias[1])")

# Test the model on training data
println("\nResults on training data:")
for (x, y) in data
    predicted = model(x)
    println("Input: $(x[1]), Target: $(y[1]), Prediction: $(predicted[1])")
end

# Test with new data
test_input = reshape(Float32[5.0], 1, 1)
prediction = model(test_input)
println("\nTest with new input:")
println("Input: 5.0, Expected: 10.0, Prediction: $(prediction[1])")
