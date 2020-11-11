//
//  LinearProgrammingTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Michael Ho on 11/10/20.
//

import XCTest

class LinearProgrammingTests: XCTestCase {
    let lp1 = LP1()
    /**
     Find maximum of equation: x1 + 6*x2 + 10*x3
     Conditions:
        1. x1 less than 300
        2. x2 less than 200
        3. x1 + 3*x2 + 2*x3 less than 1000. (cost)
        4. x2 + 3*x3 less than 500. (packaging)
        5. x1, x2, x3 are all greater than or equal to 0.
     Data:
         x1  x2  x3  s1  s2  s3  s4  s5  s6  s7
       [ 1,  0,  0,  1,  0,  0,  0,  0,  0,  0,  300]
       [ 0,  1,  0,  0,  1,  0,  0,  0,  0,  0,  200]
       [ 1,  3,  2,  0,  0,  1,  0,  0,  0,  0, 1000]
       [ 0,  1,  3,  0,  0,  0,  1,  0,  0,  0,  500]
       [ 1,  6, 10,  0,  0,  0,  0,  0,  0,  0,  0]
     
     */
    func testSimplexExample() {
        var data: [[Double]] = [
            [ 1,  0,  0,  1,  0,  0,  0,  300],
            [ 0,  1,  0,  0,  1,  0,  0,  200],
            [ 1,  3,  2,  0,  0,  1,  0,  1000],
            [ 0,  1,  3,  0,  0,  0,  1,  500],
            [-1, -6, -10,  0,  0,  0,  0,  0]
        ]
        
        lp1.loadData(data, 4, 7)
        for _ in 0..<10 {
            data = lp1.findMaxProfit()
        }
        
    }
}
