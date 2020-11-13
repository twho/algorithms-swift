//
//  LinearProgrammingTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Michael Ho on 11/10/20.
//

import XCTest

class LinearProgrammingTests: XCTestCase {
    let lp1 = LP1()
    let lp2 = LP2()
    
    func testSimplexExample() {
        /**
         Find maximum of equation: x1 + 6*x2 + 10*x3
         Conditions:
            1. x1 less than 300
            2. x2 less than 200
            3. x1 + 3*x2 + 2*x3 less than 1000. (cost)
            4. x2 + 3*x3 less than 500. (packaging)
            5. x1, x2, x3 are all greater than or equal to 0.
         */
        let simplex = LP1.SimplexMethod(mainEquation: SimplexEquation(equationNumbers:[1, 6, 10]),
                                        constraints: [
                                            SimplexEquation(equationNumbers:[1, 0, 0], equationSolution:300, Relation.lessOrEqual),
                                            SimplexEquation(equationNumbers:[0, 1, 0], equationSolution:200, Relation.lessOrEqual),
                                            SimplexEquation(equationNumbers:[1, 3, 2], equationSolution:1000, Relation.lessOrEqual),
                                            SimplexEquation(equationNumbers:[0, 1, 3], equationSolution:500, Relation.lessOrEqual),
                                            SimplexEquation(equationNumbers:[1, 0, 0], equationSolution:0, Relation.greaterOrEqual),
                                            SimplexEquation(equationNumbers:[0, 1, 0], equationSolution:0, Relation.greaterOrEqual),
                                            SimplexEquation(equationNumbers:[0, 0, 1], equationSolution:0, Relation.greaterOrEqual)
                                        ],
                                        valueTarget: .max)
        var findMaximum = false
        simplex.nextIteration()
        while !findMaximum {
            if let val = simplex.solution?.optimumSolution.realValue, Int(val) == 2400 {
                findMaximum = true
                break
            }
            simplex.nextIteration()
        }
        XCTAssertTrue(findMaximum)
    }
    
    func testSimplexOptimumExample() {
        /**
         Find maximum of equation: x1 + 6*x2 + 10*x3
         Conditions:
            1. x1 less than 300
            2. x2 less than 200
            3. x1 + 3*x2 + 2*x3 less than 1000. (cost)
            4. x2 + 3*x3 less than 500. (packaging)
            5. x1, x2, x3 are all greater than or equal to 0.
         */
        let output = lp2.findOptimumIntegerValue(mainEquation: SimplexEquation(equationNumbers:[1, 6, 10]),
                                                 constraints: [
                                                    SimplexEquation(equationNumbers:[1, 0, 0], equationSolution:300, Relation.lessOrEqual),
                                                    SimplexEquation(equationNumbers:[0, 1, 0], equationSolution:200, Relation.lessOrEqual),
                                                    SimplexEquation(equationNumbers:[1, 3, 2], equationSolution:1000, Relation.lessOrEqual),
                                                    SimplexEquation(equationNumbers:[0, 1, 3], equationSolution:500, Relation.lessOrEqual),
                                                    SimplexEquation(equationNumbers:[1, 0, 0], equationSolution:0, Relation.greaterOrEqual),
                                                    SimplexEquation(equationNumbers:[0, 1, 0], equationSolution:0, Relation.greaterOrEqual),
                                                    SimplexEquation(equationNumbers:[0, 0, 1], equationSolution:0, Relation.greaterOrEqual)
                                                 ],
                                                 valueTarget: .max)
        XCTAssertEqual(output, 2400)
    }
    
    func testSimplexUnboundedExample1() {
        /**
         Find maximum of equation: 5x + 4y
         Unbounded conditions:
            1. x + y less than 7
            2. x - y less than 8
            3. x and y are greater than or equal to 0.
         */
        let isUnbounded = lp2.isEquationsUnbounded(mainEquation: SimplexEquation(equationNumbers:[5, 4]),
                                                   constraints: [
                                                    SimplexEquation(equationNumbers:[1, 0], equationSolution:7, Relation.lessOrEqual),
                                                    SimplexEquation(equationNumbers:[1, -1], equationSolution:8, Relation.lessOrEqual),
                                                    SimplexEquation(equationNumbers:[1, 0], equationSolution:0, Relation.greaterOrEqual),
                                                    SimplexEquation(equationNumbers:[0, 1], equationSolution:0, Relation.greaterOrEqual)
                                                   ],
                                                   valueTarget: .max)
        XCTAssertTrue(isUnbounded)
    }
    
    func testSimplexUnboundedExample2() {
        /**
         Find maximum of equation: 2x + y
         Bounded conditions:
            1. 4*x + 3*y less than 12
            2. 4*x + y less than 8
            3. 4*x + 2*y less than 8
            4. x and y are greater than or equal to 0.
         */
        let isUnbounded = lp2.isEquationsUnbounded(mainEquation: SimplexEquation(equationNumbers:[2, 1]),
                                                   constraints: [
                                                    SimplexEquation(equationNumbers:[4, 3], equationSolution:12, Relation.lessOrEqual),
                                                    SimplexEquation(equationNumbers:[4, 1], equationSolution:8, Relation.lessOrEqual),
                                                    SimplexEquation(equationNumbers:[4, 2], equationSolution:8, Relation.lessOrEqual),
                                                    SimplexEquation(equationNumbers:[1, 0], equationSolution:0, Relation.greaterOrEqual),
                                                    SimplexEquation(equationNumbers:[0, 1], equationSolution:0, Relation.greaterOrEqual)
                                                   ],
                                                   valueTarget: .max)
        XCTAssertFalse(isUnbounded)
    }
}
