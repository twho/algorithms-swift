//
//  DivideAndConquerTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Amy Shih on 12/18/20.
//

import XCTest

class DivideAndConquerTests: XCTestCase {
    let dc1 = DC1()
    let dc2 = DC2()
    let dc3 = DC3()
    
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
    
    // MARK: Quick Select
    func testKthSmallest1() {
        let input = (array: [2, 3, 100, 95, 33, 65, 43, 77, 10, 10, 10, 45], k: 5)
        let expected = 10
        XCTAssertEqual(expected, dc2.kthSmallest(input.array, 0, input.array.count - 1, input.k))
    }
    
    func testKthSmallest2() {
        let input = (array: [2, 3, 100, 95, 33, 65, 43, 77, 10, 10, 10, 45], k: 3)
        let expected = 95
        XCTAssertEqual(expected, dc2.kthSmallest(input.array, 0, 3, input.k))
    }
    
    func testKthLargest1() {
        let input = (array: [2, 3, 100, 95, 33, 65, 43, 77, 10, 10, 10, 45], k: 4)
        let expected = 65
        XCTAssertEqual(expected, dc2.kthLargest(input.array, 0, input.array.count - 1, input.k))
    }
    
    func testKthLargest2() {
        let input = (array: [2, 3, 100, 95, 33, 65, 43, 77, 10, 10, 10, 45], k: 3)
        let expected = 65
        XCTAssertEqual(expected, dc2.kthLargest(input.array, 0, 5, input.k))
    }
    
    // MARK: Quick Sort
    func testPartition() {
        var input = [2, 3, 100, 95, 33, 65, 43, 77, 10, 10, 10, 45]
        _ = dc2.partition(&input, 0, input.count - 1)
        XCTAssertEqual([2, 3, 33, 43, 10, 10, 10, 45, 100, 65, 95, 77], input)
    }
    
    func testQuickSort1() {
        let input = [2, 3, 1, 7, 6, 5, 4, 8]
        let expected = [1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertEqual(expected, dc2.quickSort(input))
    }
    
    func testQuickSort2() {
        let input = [2, 3, 100, 95, 33, 65, 43, 77, 10, 10, 10, 45]
        let expected = [2, 3, 10, 10, 10, 33, 43, 45, 65, 77, 95, 100]
        XCTAssertEqual(expected, dc2.quickSort(input))
    }
    
    // MARK: Geometric Series
    func testGeometricSeriesSum() {
        let input = (a: 1.0, r: 0.5, n: 10)
        let expected = 1.99805
        XCTAssertEqual(expected, dc3.sumOfGeometricSeries(input.a, input.r, input.n), accuracy: 0.01 * expected)
    }
    
    func testGeometricSeriesSumByFormula() {
        let input = (a: 1.0, r: 0.5, n: 10)
        let expected = 1.99805
        XCTAssertEqual(expected, dc3.sumOfGSByFormula(input.a, input.r, input.n), accuracy: 0.01 * expected)
    }
}
