//
//  Complex.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/21/20.
//

struct Complex {
    let real: Float
    let imaginary: Float
    
    init() {
        self.real = 0.0
        self.imaginary = 0.0
    }
    
    init(real: Float, imaginary: Float) {
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
