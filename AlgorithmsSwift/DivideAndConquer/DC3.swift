//
//  DC3.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/19/20.
//

import Foundation

class DC3 {
    /**
     The naive method to calculate the sum of geometric series.
     
     - Parameter a: The first term of the series.
     - Parameter r: The common ratio.
     - Parameter n: The number of terms.
     
     - Returns: The result of the sum of the series.
     */
    func sumOfGeometricSeries(_ a: Double, _ r: Double, _ n: Int) -> Double {
        var sum = 0.0
        var a = a
        for _ in 0..<n {
            sum = sum + a
            a = a * r
        }
        return sum
    }
    /**
     The method using formula to calculate the sum of geometric series.
     
     - Parameter a: The first term of the series.
     - Parameter r: The common ratio.
     - Parameter n: The number of terms.
     
     - Returns: The result of the sum of the series.
     */
    func sumOfGSByFormula(_ a: Double, _ r: Double, _ n: Int) -> Double {
        return a * (1.0 - pow(r, Double(n))) / (1 - r)
    }
}
