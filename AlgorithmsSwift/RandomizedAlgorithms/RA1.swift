//
//  RA1.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/12/20.
//

class RA1 {
    /**
     Modular exponentiation, the power in Modular Arithmetic. The following function computes (x^y) % N.
     Reference: https://www.geeksforgeeks.org/modular-exponentiation-power-in-modular-arithmetic/
     
     - Parameter x: The number as a base to be calculated.
     - Parameter y: The exponential number.
     - Parameter N: N The mod number.
     
     - Returns: The computation result.
     */
    func modularExp(_ x: inout Int, _ y: inout Int, _ N: Int) -> Int {
        var result = 1
        while y > 0 {
            /**
             If the exponential is not the muliply of 2,
             we multiply x once to the result
             */
            if y % 2 != 0 {
                result = (result * x) % N
            }
            /**
             Now we can directly round y down by 2. We caclulate the modular on
             sqaure of x, this reduces the runtime to half.
             */
            y /= 2
            x = (x * x)%N
        }
        
        return result
    }
    /**
     Multiplicative inverse is another name for reciprocal, which tries to find the number to multiply
     in order to get 1. For example, if x = 3, N = 11, the result will be 4 since 3*4%11 = 1.
     Given two integers x and N, find modular multiplicative inverse of x under modulo N.
     
     - Parameter x: The integer as a base number.
     - Parameter N: The modulo N.
     
     Returns: The computation result.
     */
    static func multiplicativeInverse(_ x: inout Int, _ N: Int) -> Int {
        x = x%N
        // We only need to try N - 1 times so that all remainders
        // from modular of N is considered.
        for i in 1..<N {
            if (x*i)%N == 1 {
                return i
            }
        }
        return -1
    }
    /**
     The class covers greatest common divisor methods.
     */
    class GreatestCommonDivisor {
        /**
         The euclid algorithm used to calculate greatest common divisor.
         The runtime is O(N^3), where N is the number of bits.
         
         - Parameter x: The larger number to calculate GCD.
         - Parameter y: The smaller number to calculate GCD.
         
         - Returns: The greatest common divisor derived by the algorithm.
         */
        static func euclidAlgorithm(_ x: Int, _ y: Int) -> Int {
            if x == 0 {
                return y
            }
            // x%y takes O(N^2) runtime.
            return euclidAlgorithm(y % x, x)
        }
        /**
         Extended euclid algorithm where xα + yβ = gcd(x, y) to compute inverses.
         The runtime is O(N^3).
         
         - Parameter x: The larger number.
         - Parameter y: The smaller number.
         
         - Returns: The computation result.
         */
        func extendedEuclid(_ x: Int, _ y: Int) -> [Int] {
            if y == 0 {
                return [x, 1, 0]
            }
            let values = extendedEuclid(y, x % y)
            let d = values[0]
            let α = values[2]
            let β = values[1] - (x / y) * values[2]
            // The following means d = xα + yβ, where
            // x and y are the original input.
            return [d, α, β]
        }
    }
}
