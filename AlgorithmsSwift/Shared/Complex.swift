//
//  Complex.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/21/20.
//

struct Complex {
    let real: Double
    let imaginary: Double
    
    init() {
        self.real = 0.0
        self.imaginary = 0.0
    }
    
    init(real: Double, imaginary: Double) {
        self.real = real
        self.imaginary = imaginary
    }

    static func +(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real + rhs.real, imaginary: lhs.imaginary + rhs.imaginary)
    }

    static func -(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real - rhs.real, imaginary: lhs.imaginary - rhs.imaginary)
    }

    static func *(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real * rhs.real - lhs.imaginary * rhs.imaginary,
                       imaginary: lhs.imaginary * rhs.real + lhs.real * rhs.imaginary)
    }
}
