import numpy as np

def coefficients_broadcasting_convolution(input_tensor, filter_kernel, stride=1, padding=0):
    # Get the shapes of the input tensor and filter kernel
    input_height, input_width = input_tensor.shape
    filter_height, filter_width = filter_kernel.shape

    # Pad the input tensor if necessary
    if padding > 0:
        input_tensor = np.pad(input_tensor, ((padding, padding), (padding, padding)), mode='constant')

    # Calculate the output tensor shape
    output_height = (input_height - filter_height + 2 * padding) // stride + 1
    output_width = (input_width - filter_width + 2 * padding) // stride + 1

    # Rearrange the input tensor
    input_tensor_reshaped = np.zeros((output_height, output_width, filter_height * filter_width))
    for i in range(output_height):
        for j in range(output_width):
            input_tensor_reshaped[i, j] = input_tensor[i:i+filter_height, j:j+filter_width].flatten()

    # Rearrange the filter kernel
    filter_kernel_reshaped = filter_kernel.flatten()

    # Perform the matrix multiplication
    output_tensor = input_tensor_reshaped @ filter_kernel_reshaped

    return output_tensor


# Define the input tensor (image) and filter kernel
input_tensor = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
filter_kernel = np.array([[1, 2], [3, 4]])

# Apply the CB algorithm for convolution
output_tensor = coefficients_broadcasting_convolution(input_tensor, filter_kernel)

print(output_tensor)
