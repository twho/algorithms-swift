//
//  DivideAndConquerTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Amy Shih on 12/18/20.
//

import XCTest

class DivideAndConquerTests: XCTestCase {
    let dc1 = DC1()
    
    // MARK: Merge Sort
    func testMergeSort() {
        let input = [2, 3, 100, 95, 33, 65, 43, 77, 10, 10, 10, 45]
        let expected = [2, 3, 10, 10, 10, 33, 43, 45, 65, 77, 95, 100]
        XCTAssertEqual(expected, dc1.mergeSort(input))
    }
    
    // MARK: Binary Multiplication
    func testBinaryMultiplication() {
        let input = (x: String(712, radix: 2), y: String(45, radix: 2))
        let expected = 32040
        XCTAssertEqual(expected, dc1.binaryMultiplication(input.x, input.y))
    }
}
