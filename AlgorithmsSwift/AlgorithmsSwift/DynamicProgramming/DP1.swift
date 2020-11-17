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
            return dp[n]
        }
    }
}
