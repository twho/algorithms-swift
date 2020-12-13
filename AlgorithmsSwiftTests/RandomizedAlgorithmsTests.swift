//
//  RandomizedAlgorithmsTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Michael Ho on 12/12/20.
//

import XCTest

class RandomizedAlgorithmsTests: XCTestCase {
    let gcd = RA1.GreatestCommonDivisor()
    let ra2 = RA2()
    let rsa = RA2.RSA()
 
    // MARK: Modular exponentiation
    func testModularExp1() {
        let input = (x: 2, y: 5, N: 13)
        let expected = 6
        XCTAssertEqual(expected, RA1.modularExp(input.x, input.y, input.N))
    }
    
    func testModularExp2() {
        let input = (x: 3, y: 19, N: 11)
        let expected = 4
        XCTAssertEqual(expected, RA1.modularExp(input.x, input.y, input.N))
    }
    
    // MARK: Multiplicative Inverse
    func testMultiplicativeInverses() {
        let input = (x: 3, N: 11)
        let expected = 4
        XCTAssertEqual(expected, RA1.multiplicativeInverse(input.x, input.N))
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
    
    // MARK: RSA Tests
    func testRSA1() {
        // Message "ABC", where "A" = 1, "B" = 2, "C" = 3
        // The message itself is 2^6 < 8978 < 2^7 (~7 bit)
        let input = 123
        // p*q needs to be larger than 7 bit, which is message size.
        // p = 53, where 2^5 < 53 < 2^6 (~ 6 bit).
        // q = 53, where 2^5 < 59 < 2^6 (~ 6 bit).
        // Therefore, p*q is 12 bit, which is above 7 bit.
        let p = 53
        let q = 59
        let publicKey = rsa.getPublicKeyPair(p, q)
        let encryptedMsg = rsa.encrypt(input, publicKey)
        // The encrypted message should not be eqaul as the original one.
        XCTAssertNotEqual(input, encryptedMsg)
        let privateKey = rsa.getPrivateKey(p, q, publicKey.e)
        let decryptesMsg = rsa.decrypt(encryptedMsg, publicKey.N, privateKey)
        XCTAssertEqual(input, decryptesMsg)
    }
    
    func testRSA2() {
        // Message "HIGH", where "H" = 8, "I" = 9, "G" = 7, "H" = 8.
        // The message itself is 2^13 < 8978 < 2^14 (~14 bit)
        let input = 8978
        // p*q needs to be larger than 7 bit, which is message size.
        // p = 197, where 2^7 < 197 < 2^8 (~ 8 bit).
        // q = 199, where 2^7 < 199 < 2^8 (~ 8 bit).
        // Therefore, p*q is 16 bit, which is above 14 bit.
        let p = 197
        let q = 199
        let publicKey = rsa.getPublicKeyPair(p, q)
        let encryptedMsg = rsa.encrypt(input, publicKey)
        XCTAssertNotEqual(input, encryptedMsg)
        let privateKey = rsa.getPrivateKey(p, q, publicKey.e)
        let decryptesMsg = rsa.decrypt(encryptedMsg, publicKey.N, privateKey)
        XCTAssertEqual(input, decryptesMsg)
    }
    
    // MARK: Prime number
    func testPrimeNumber1() {
        let input = 5255
        XCTAssertFalse(ra2.isPrime(input))
    }
    
    func testPrimeNumber2() {
        let input = 199
        XCTAssertTrue(ra2.isPrime(input))
    }
    
    // MARK: Prime number by Fermat
    func testPrimeNumberByFermat1() {
        let input = 5255
        XCTAssertFalse(ra2.isPrimeByFermat(input, 100))
    }
    
    func testPrimeNumberByFermat2() {
        let input = 197
        XCTAssertTrue(ra2.isPrimeByFermat(input, 100))
    }
}
