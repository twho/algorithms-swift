//
//  DP1.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/12/20.
//

class DP1 {
    /**
     Methods to find Fibonacci number.
     */
    class Fibonacci {
        /**
         The recursive method to find Fibonacci number. Runtime: O(2^N)
         
         - Parameter n:     The number to be calculated Fibonacci numbers.
         - Parameter time:  The counter to measure runtime.
         
         - Returns: The results of calculation.
         */
        func fibonacci(_ n: Int, _ time: inout Int) -> Int {
            time += 1
            if n == 0 {
                return 0
            } else if n == 1 || n == 2 {
                return 1
            } else {
                return fibonacci(n - 1, &time) + fibonacci(n - 2, &time)
            }
        }
        /**
         The dynamic programming method to find Fibonacci number. Runtime: O(N)
         
         - Parameter n:     The number to be calculated Fibonacci numbers.
         - Parameter time:  The counter to measure runtime.
         
         - Returns: The results of calculation.
         */
        func dpFibonacci(_ n: Int, _ time: inout Int) -> Int {
            var dp = Array(repeating: 1, count: n + 1)
            dp[0] = 0
            dp[1] = 1
            dp[2] = 1
            if n == 0 || n == 1 || n == 2 {
                return dp[n]
            }
            
            for i in 3...n {
                time += 1
                dp[i] = dp[i - 1] + dp[i-2]
            }
            return dp.last!
        }
    }
    /**
     A series of longest subsequence problems and their solutions. Subsequence is different from substring. Subsequence is a subset
     of elements in order that can be derived from another sequence while substring has to be a set of consecutive elements.
     */
    class LongestSubsequence {
        /**
         The dynamic method used to find the longest length of subsequence. The runtime is O(N^2).
         
         - Parameter array: The input array to find LIS.
         
         - Returns: An integer indicates the length of the longest subsequence.
         */
        func findLongestIncreasingSubsequence(_ array: [Int]) -> Int {
            var longestLength = 0
            var dp = Array(repeating: 0, count: array.count)
            dp[0] = 1
            for i in 1..<array.count {
                dp[i] = 1
                for j in 0..<i {
                    if array[j] < array[i] {
                        dp[i] = max(dp[i], 1 + dp[j])
                    }
                }
                longestLength = max(dp[i], longestLength)
            }
            return longestLength
        }
        /**
         The dynamic method used to find the longest length of common subsequence of two different string.
         The runtime is O(N^2).
         
         - Parameter string1: The first string.
         - Parameter string2: The second string.
         
         - Returns: An integer indicates the length of the longest subsequence.
         */
        func findLongestCommonSubsequence(_ string1: String, _ string2: String) -> Int {
            let strArr1 = Array(string1)
            let strArr2 = Array(string2)
            var dp = Array(repeating: Array(repeating: 0, count: strArr2.count), count: strArr1.count)
            for i in 0..<dp.count {
                // Build up the first string
                for j in 0..<dp[i].count {
                    // Build up the second string
                    if strArr1[i] == strArr2[j] {
                        dp[i][j] = 1
                        if i > 0, j > 0 {
                            dp[i][j] += dp[i - 1][j - 1]
                        }
                    } else {
                        if j > 0, i > 0 {
                            dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                        } else if i > 0 {
                            dp[i][j] = dp[i - 1][j]
                        } else if j > 0 {
                            dp[i][j] = dp[i][j - 1]
                        }
                    }
                }
            }
            return dp.last!.last!
        }
    }
}
