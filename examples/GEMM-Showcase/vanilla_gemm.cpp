#include <vector>
#include <iostream>
#include <chrono>
#include <random>

void gemm(int M, int N, int K, 
          const std::vector<float>& A, const std::vector<float>& B, std::vector<float>& C) {
    for (int i = 0; i < M; ++i) {
        for (int j = 0; j < N; ++j) {
            float c = 0;
            for (int k = 0; k < K; ++k) {
                c += A[i*K + k] * B[k*N + j];
            }
            C[i*N + j] = c;
        }
    }
}

// A utility function to print matrix
void printMatrix(const std::vector<float>& mat, int M, int N) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            std::cout << mat[i * N + j] << " ";
        }
        std::cout << std::endl;
    }
}

int main() {
    // Example usage of the `gemm` function.
    int M = 500, N = 500, K = 500;
	
	// Creating random number generator
	std::default_random_engine generator;
	std::uniform_real_distribution<float> distribution(0.0, 1.0);
	// Generating random float values for matrices A and B
	std::vector<float> A(M * K);
	std::vector<float> B(K * N);
	for (int i = 0; i < M * K; ++i) {
		A[i] = distribution(generator);
	}
	for (int i = 0; i < K * N; ++i) {
		B[i] = distribution(generator);
	}

	// Placeholder for output matrix C
	std::vector<float> C(M * N);

	// Placeholder for the optimized matrix C
	std::vector<float> C_opt(M * N);

	
    // Measure the time taken for the `gemm` function to execute. [Origin One]
    auto start = std::chrono::high_resolution_clock::now();
    gemm(M, N, K, A, B, C);
    auto stop = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);

    std::cout << "Vanilla GEMM Time: "
         << duration.count() << " microseconds" << std::endl;

  // Test the optimized GEMM
    start = std::chrono::high_resolution_clock::now();
    optimized_gemm(M, N, K, A, B, C_opt);
    stop = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
    std::cout << "Optimized GEMM Time: "
              << duration.count() << " microseconds" << std::endl;


    // Print the resultant C matrix. If it is too large a matrix, you might not want to print it out
    // printMatrix(C, M, N);
    return 0;
}
