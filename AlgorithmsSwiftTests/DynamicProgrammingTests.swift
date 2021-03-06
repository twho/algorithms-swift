//
//  DynamicProgrammingTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Michael Ho on 11/12/20.
//

import XCTest

class DynamicProgrammingTests: XCTestCase {
    let fib = DP1.Fibonacci()
    let longestSubsequence = DP1.LongestSubsequence()
    let knapsack = DP2.KnapSack()
    let matrixMultiply = DP2.MatrixMultiply()
    let dijkstra = DP3.Dijkstra()
    let bellmanFord = DP3.BellmanFord()
    
    func testFibonacci() {
        var time = 0
        let expected = 55 // Fibonacci(10)
        XCTAssertEqual(expected, fib.fibonacci(10, &time))
    }
    
    func testFibonacciDP() {
        let expected = 102334155 // Fibonacci(40)
        var time2 = 0
        XCTAssertEqual(expected, fib.dpFibonacci(40, &time2))
        // Uncomment the following code to compare performance
        // var time1 = 0
        // let _ = fib.fibonacci(40, &time1)
        // XCTAssertTrue(time2 < time1) // time1 == 204668309, time2 == 38
    }
    
    func testLIS() {
        let input = [5, 7, 4, -3, 9, 1, 10, 4, 5, 8, 9, 3]
        let expected = 6
        XCTAssertEqual(expected, longestSubsequence.findLongestIncreasingSubsequence(input))
    }
    
    func testLCS() {
        let input = (str1: "BCDBCDA", str2: "ABECBA")
        let expected = 4
        XCTAssertEqual(expected, longestSubsequence.findLongestCommonSubsequence(input.str1, input.str2))
    }
    
    func testKnapsackLimitedSupply1() {
        let input = (weights: [10, 20, 30], values: [60, 100, 120], weightLimit: 50)
        let expected = 220
        XCTAssertEqual(expected, knapsack.maxValueWithLimitedSupply(input.weights, input.values, input.weightLimit))
    }
    
    func testKnapsackLimitedSupply2() {
        let input = (weights: [1, 2, 3], values: [10, 15, 40], weightLimit: 6)
        let expected = 65
        XCTAssertEqual(expected, knapsack.maxValueWithLimitedSupply(input.weights, input.values, input.weightLimit))
    }
    
    func testKnapsackUnlimitedSupply() {
        let input = (weights: [5, 10, 15], values: [10, 30, 20], weightLimit: 100)
        let expected = 300
        XCTAssertEqual(expected, knapsack.maxValueWithUnlimitedSupply(input.weights, input.values, input.weightLimit))
    }
    
    func testChainMatrixMultiply() {
        let input = [1, 2, 3, 4, 3]
        let expected = 30
        XCTAssertEqual(expected, matrixMultiply.chainMatrixMultiply(input, 1, input.count - 1))
    }
    
    func testChainMatrixMultiplyDP1() {
        let input = [1, 2, 3, 4, 3]
        let expected = 30
        XCTAssertEqual(expected, matrixMultiply.dpChainMatrixMultiply(input))
    }
    
    func testChainMatrixMultiplyDP2() {
        let input = [40, 20, 30, 10, 30]
        let expected = 26000
        XCTAssertEqual(expected, matrixMultiply.dpChainMatrixMultiply(input))
    }
    
    func testDijkstraShortestPath() {
        let graph = Graph(isDirected: true)
        graph.addEdge(from: 0, to: 1, weight: 1) // add edge 0-1
        graph.addEdge(from: 0, to: 2, weight: 4) // add edge 0-2
        graph.addEdge(from: 1, to: 2, weight: 3) // add edge 1-2
        graph.addEdge(from: 1, to: 3, weight: 2) // add edge 1-3
        graph.addEdge(from: 1, to: 4, weight: 2) // add edge 1-4
        graph.addEdge(from: 3, to: 2, weight: 5) // add edge 3-2
        graph.addEdge(from: 3, to: 1, weight: 1) // add edge 3-1
        graph.addEdge(from: 4, to: 3, weight: 3) // add edge 4-3
        let expected = [0, 1, 4, 3, 3]
        XCTAssertEqual(expected, dijkstra.shortestPath(graph, 0))
    }
    
    func testBellmanFordShortestPath() {
        let graph = Graph(isDirected: true)
        graph.addEdge(from: 0, to: 1, weight: -1) // add edge 0-1
        graph.addEdge(from: 0, to: 2, weight: 4)  // add edge 0-2
        graph.addEdge(from: 1, to: 2, weight: 3)  // add edge 1-2
        graph.addEdge(from: 1, to: 3, weight: 2)  // add edge 1-3
        graph.addEdge(from: 1, to: 4, weight: 2)  // add edge 1-4
        graph.addEdge(from: 3, to: 2, weight: 5)  // add edge 3-2
        graph.addEdge(from: 3, to: 1, weight: 1)  // add edge 3-1
        graph.addEdge(from: 4, to: 3, weight: -3) // add edge 4-3
        let expected = [0, -1, 2, -2, 1]
        let output = bellmanFord.shortestPath(graph, 0)
        XCTAssertEqual(expected, output.dist)
        XCTAssertFalse(output.hasNegativeCycle)
    }
    
    func testBellmanFordShortestPathWithNegativeCycle() {
        let graph = Graph(isDirected: true)
        graph.addEdge(from: 0, to: 1, weight: 1)   // add edge 0-1
        graph.addEdge(from: 1, to: 2, weight: -1)  // add edge 1-2
        graph.addEdge(from: 2, to: 3, weight: -1)  // add edge 2-3
        graph.addEdge(from: 3, to: 0, weight: -1)  // add edge 3-0
        let output = bellmanFord.shortestPath(graph, 0)
        XCTAssertEqual(0, output.dist.count)
        XCTAssertTrue(output.hasNegativeCycle)
    }
}
