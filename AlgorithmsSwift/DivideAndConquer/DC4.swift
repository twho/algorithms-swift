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
}
