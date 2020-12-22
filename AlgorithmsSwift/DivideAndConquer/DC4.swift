//
//  DC4.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/20/20.
//

class DC4 {
    /**
     Naive approach to multiply 2 polynomials.
     
     - Parameter A: The first polynomial represented in integer array.
     - Parameter B: The second polynomial represented in integer array.
     
     - Returns: The multiplication result as an integer array.
     */
    func multiplication(_ A: [Int], _ B: [Int]) -> [Int] {
        var output = Array(repeating: 0, count: A.count + B.count - 1)
        for i in 0..<A.count {
            for j in 0..<B.count {
                output[i + j] += A[i]*B[j]
            }
        }
        return output
    }
    /**
     The function used to calculate Fast Fourier Transform.
     The original complext is divided into two polynomials:
     1. A0(x) = a0 + a2x + a4x^2 + ... + (an - 2)x^(n/2 - 1).
     2. A1(x) = a1 + a3x + a5x^2 + ... + (an - 1)x^(n/2 - 1).
     
     Original: A(x) = A0(x^2) + xA1(x^2)
     
     - Parameter A:     The complex numbers.
     - Parameter omega: The complex numbers.
     - Parameter length: The complex numbers.
     - Parameter power: The complex numbers.
     
     - Returns: The FFT result.
     */
    func FastFourierTransform(_ A: [Complex], _ omega: [Complex], _ length: Int, _ power: Int) -> [Complex] {
        if length == 1 {
            return A
        }
        
        var AEven = Array(repeating: Complex(), count: length)
        var AOdd = Array(repeating: Complex(), count: length)
        // Divide the original one to AEven and AOdd.
        for i in 0..<length {
            if i % 2 == 0 {
                AEven[i / 2] = A[i]
            } else {
                AOdd[i / 2] = A[i]
            }
        }
        
        let solutionEven = FastFourierTransform(AEven, omega, length / 2, power * 2)
        let solutionOdd = FastFourierTransform(AOdd, omega, length / 2, power * 2)
        var polySol = Array(repeating: Complex(), count: length)
        // Combine two arrays
        for i in 0..<length / 2 {
            polySol[i] = solutionEven[i] + omega[i * power] * solutionOdd[i]
            polySol[i + length / 2] = solutionEven[i] - omega[i * power] * solutionOdd[i]
        }
        return polySol
    }
}
