//
//  DP2.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/5/20.
//

class DP2 {
    /**
     Methods to solve knapsack problems and their variants.
     */
    class KnapSack {
        /**
         The dynamic programming used to calculate knapsack problems. The runtime is O(NW) where N is
         the number of objects and W is the weight limit of the knapsack. Note that the runtime is not
         polynomial in the input size.
         Reference: https://www.geeksforgeeks.org/0-1-knapsack-problem-dp-10/
         
         - Parameter weights:     The array represents the values of input objects.
         - Parameter values:      The array represents the weights of input objects.
         - Parameter weightLimit: The total weight allowed.
         
         - Returns: An integer of the maximum value possible given the conditions.
         */
        func maxValueWithLimitedSupply(_ weights: [Int], _ values: [Int], _ weightLimit: Int) -> Int {
            var dp = Array(repeating: Array(repeating: 0, count: weightLimit + 1), count: weights.count)
            for i in 0..<dp.count {
                // Each i represents an item in the list.
                for w in 0..<dp[i].count {
                    // w represents weight at each level under weightLimit.
                    if w == 0 {
                        // With the weight limit set to 0, there is nothing we can put in.
                        dp[i][w] = 0
                    } else if i == 0 {
                        /**
                         When we only have one choice, which is item 0, we can only put it in when
                         its weight is within the limit
                         */
                        dp[i][w] = weights[i] <= w ? values[i] : 0
                    } else if weights[i] <= w {
                        /**
                         If the current item has weight less than the limit, we can choose to include the current item or not
                         depending on which way let us get the maximum value.
                         */
                        dp[i][w] = max(values[i] + dp[i - 1][w - weights[i]], dp[i - 1][w])
                    } else {
                        dp[i][w] = dp[i - 1][w]
                    }
                }
            }
            
            return dp.last!.last!
        }
        /**
         The dynamic programming used to calculate knapsack problems with unlimited supply. The runtime is O(NW) where N is
         the number of objects and W is the weight limit of the knapsack. The runtime is the same as previous version of
         knapsack problem.
         
         - Parameter weights:     The array represents the values of input objects.
         - Parameter values:      The array represents the weights of input objects.
         - Parameter weightLimit: The total weight allowed.
         
         - Returns: An integer of the maximum value possible given the conditions.
         */
        func maxValueWithUnlimitedSupply(_ weights: [Int], _ values: [Int], _ weightLimit: Int) -> Int {
            var maxVal = Array(repeating: 0, count: weightLimit + 1)
            for b in 0...weightLimit {
                // Calculate for each weight level.
                for i in 0..<values.count {
                    /**
                     Each i represents an item in the list. We can consider adding the
                     item if its weight is less than the current weight limit b.
                     */
                    if weights[i] <= b {
                        maxVal[b] = max(values[i] + maxVal[b - weights[i]], maxVal[b])
                    }
                }
            }
            return maxVal.last!
        }
    }
    /**
     DP and recursive methods to calculate chain multiply matrix problems.
     */
    class MatrixMultiply {
        /**
         The recursive method used to calculate chain multiply matrix problems.
         */
        func chainMatrixMultiply(_ matrix: [Int], _ start: Int, _ end: Int) -> Int {
            if start == end {
                return 0
            }

            var minVal = Int.max;
            for l in start..<end {
                let count = chainMatrixMultiply(matrix, start, l) + chainMatrixMultiply(matrix, l + 1, end) + matrix[start - 1]*matrix[l]*matrix[end]
                minVal = min(minVal, count)
            }
            return minVal
        }
        /**
         The dynamic programming used to calculate chain multiply matrix problems. Note that the calculation
         merely focuses on how to decide which order to perform the multiplication. The runtime is O(N^3)
         where N is the number of matrices. Example input like {10, 20, 30, 40}, which stands for
         3 matrices 10x20, 20x30 and 30x40.
         Reference: https://www.geeksforgeeks.org/matrix-chain-multiplication-dp-8/
         
         - Parameter matrix: The array of matrix, refer to the description above for the expressions.
         - Parameter start:  The start of the serial calculation.
         - Parameter end:    The tail of the serial calculation.
         
         - Returns: The result of the minimum cost calculation.
         */
        func dpChainMatrixMultiply(_ matrix: [Int]) -> Int {
            let n = matrix.count
            var dp = Array(repeating: Array(repeating: 0, count: n), count: n)
            for i in 1..<n {
                dp[i][i] = 0
            }
            for l in 2..<n {
                for i in 1..<n - l + 1 {
                    let j = i + l - 1
                    if j == n {
                        continue
                    }
                    dp[i][j] = Int.max
                    for k in i...j - 1 {
                        let q = dp[i][k] + dp[k + 1][j] + matrix[i - 1] * matrix[k] * matrix[j];
                        dp[i][j] = min(q, dp[i][j])
                    }
                }
            }
            return dp[1][n - 1]
        }
    }
}

