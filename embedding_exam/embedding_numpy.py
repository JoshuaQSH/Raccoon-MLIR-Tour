import numpy as np

class EmbeddingLayer:
    def __init__(self, input_dim, output_dim):
        # Initialize the weight matrix with random values
        self.weight_matrix = np.random.randn(input_dim, output_dim)

    def __call__(self, input_indices):
        # Perform a lookup in the weight matrix based on the input indices
        return self.weight_matrix[input_indices]

# Define the embedding layer parameters
input_dim = 10000  # Vocabulary size
output_dim = 300   # Embedding dimension

# Create the embedding layer
embedding_layer = EmbeddingLayer(input_dim, output_dim)

# Example input: a list of word indices
input_indices = np.array([1, 25, 50, 100, 250])

# Use the embedding layer to get the corresponding word vectors
word_vectors = embedding_layer(input_indices)
print(word_vectors)
