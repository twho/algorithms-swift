//
//  DynamicProgrammingTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Michael Ho on 11/12/20.
//

import XCTest

class DynamicProgrammingTests: XCTestCase {
    let fib = DP1.Fibonacci()
    
    func testFibonacci() {
        var time = 0
        let expected = 55 // Fibonacci(10)
        XCTAssertEqual(expected, fib.fibonacci(10, &time))
    }
    
    func testFibonacciDP() {
        var time1 = 0
        let _ = fib.fibonacci(40, &time1)
        let expected = 102334155 // Fibonacci(40)
        var time2 = 0
        XCTAssertEqual(expected, fib.dpFibonacci(40, &time2))
        XCTAssertTrue(time2 < time1) // time1 == 204668309, time2 == 38
    }
}
