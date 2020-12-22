//
//  DC5.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/21/20.
//

import Foundation

class DC5 {
    /**
     Calculate the multiplication of 2 polynomials.
     
     - Parameter p:            The coefficients of the first polynomials in double.
     - Parameter q:            The coefficients of the second polynomials in double.
     - Parameter n:            The size of the polynomials.
     - Parameter omega:        The omega w in the FFT formula.
     - Parameter omegaInverse: The omega inverse ω^-1 in the FFT formula.
     
     - Returns: The result of the multiplication.
     */
    func multiply(_ p: [Double], _ q: [Double], _ n: Int, _ omega: [Complex], _ omegaInverse: [Complex]) -> [Double] {
        // Generate complex objects with 2 times the size
        var pInteger = Array(repeating: Complex(), count: n)
        var qInteger = Array(repeating: Complex(), count: n)
        // Copy the coefficents into the real part of complex number and pad zeros to remaining terms.
        for i in 0..<n/2 {
            pInteger[i] = Complex(real: p[i], imaginary: 0)
            qInteger[i] = Complex(real: q[i], imaginary: 0)
        }
        
        for i in n/2..<n {
            pInteger[i] = Complex(real: 0, imaginary: 0)
            qInteger[i] = Complex(real: 0, imaginary: 0)
        }
        
        let power = 1
        // Apply the FFT to the two factors
        let solP = DC4.fastFourierTransform(pInteger, omega, n, power)
        let solQ = DC4.fastFourierTransform(qInteger, omega, n, power)
        // Multiply the results point-wise recursive
        var finalSol = Array(repeating: Complex(), count: n)
        for i in 0..<n {
            finalSol[i] = solP[i]*solQ[i]
        }
        // Apply the FFT to the point-wise product
        let poly = DC4.fastFourierTransform(finalSol, omegaInverse, n, power)
        var result = Array(repeating: 0.0, count: n - 1)
        for i in 0..<n - 1 {
            result[i] = poly[i].real / Double(n)
        }
        return result
    }
    /**
     Calculate the omega ω value.
     
     - Parameter n: The length of the coefficient array.
     - Parameter inverse: Set to true to calculate inverse values.
     
     - Returns: The coefficients of the omega w in the formula.
     */
    func getOmega(_ n: Int, _ inverse: Bool) -> [Complex] {
        var omega = Array(repeating: Complex(), count: n)
        for i in 0..<n {
            omega[i] = Complex(real: cos(2.0 * Double(i) * Double.pi / Double(n)), imaginary: (inverse ? -1.0 : 1.0) * sin(2.0 * Double(i) * Double.pi / Double(n)))
        }
        return omega
    }
}
