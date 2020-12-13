//
//  RandomizedAlgorithmsTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Michael Ho on 12/12/20.
//

import XCTest

class RandomizedAlgorithmsTests: XCTestCase {
    let ra1 = RA1()
    let gcd = RA1.GreatestCommonDivisor()
    let ra2 = RA2()
 
    // MARK: Modular exponentiation
    func testModularExp1() {
        var input = (x: 2, y: 5, N: 13)
        let expected = 6
        XCTAssertEqual(expected, ra1.modularExp(&input.x, &input.y, input.N))
    }
    
    func testModularExp2() {
        var input = (x: 3, y: 19, N: 11)
        let expected = 4
        XCTAssertEqual(expected, ra1.modularExp(&input.x, &input.y, input.N))
    }
    
    // MARK: Multiplicative Inverse
    func testMultiplicativeInverses() {
        var input = (x: 3, N: 11)
        let expected = 4
        XCTAssertEqual(expected, RA1.multiplicativeInverse(&input.x, input.N))
    }
    
    // MARK: Euclid Algorithm
    func testEuclidAlgorithm1() {
        let input = (x: 69, y: 23)
        let expected = 23
        XCTAssertEqual(expected, RA1.GreatestCommonDivisor.euclidAlgorithm(input.x, input.y))
    }
    
    func testEuclidAlgorithm2() {
        let input = (x: 35, y: 10)
        let expected = 5
        XCTAssertEqual(expected, RA1.GreatestCommonDivisor.euclidAlgorithm(input.x, input.y))
    }
    
    func testEuclidAlgorithm3() {
        let input = (x: 31, y: 2)
        let expected = 1
        XCTAssertEqual(expected, RA1.GreatestCommonDivisor.euclidAlgorithm(input.x, input.y))
    }
    
    // MARK: Extended Euclid Algorithm
    func testExtendedEuclid1() {
        let input = (x: 30, y: 35)
        let expected = [5, -1, 1]
        XCTAssertEqual(expected, gcd.extendedEuclid(input.x, input.y))
    }
    
    func testExtendedEuclid2() {
        let input = (x: 360, y: 7)
        let expected = [1, -2, 103]
        XCTAssertEqual(expected, gcd.extendedEuclid(input.x, input.y))
    }
    
    // MARK: Euler's Theorem
    func testEulerTheorem1() {
        let input = 3
        let expected = 2
        XCTAssertEqual(expected, ra2.phi(input))
    }
    
    func testEulerTheorem2() {
        let input = 9
        let expected = 6
        XCTAssertEqual(expected, ra2.phi(input))
    }
    
    func testEulerTheorem3() {
        let input = 15
        let expected = 8
        XCTAssertEqual(expected, ra2.phi(input))
    }
}
