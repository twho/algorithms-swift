//
//  MaxFlowTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Michael Ho on 10/30/20.
//

import XCTest

class MaxFlowTests: XCTestCase {
    let mf1 = MF1()
    let mf2 = MF2()
    let mf4 = MF4()
    
    // MARK: - Maximum Flow by Ford-Fulkerson (DFS)
    func testMaxiumumFlowByFF() {
        let graph = Graph()
        graph.addEdge(from: 0, to: 1, weight: 16)   // add edge 0-1
        graph.addEdge(from: 0, to: 2, weight: 13)   // add edge 0-2
        graph.addEdge(from: 1, to: 2, weight: 10)   // add edge 1-2
        graph.addEdge(from: 1, to: 3, weight: 12)   // add edge 1-3
        graph.addEdge(from: 2, to: 1, weight: 4)    // add edge 2-1
        graph.addEdge(from: 2, to: 4, weight: 14)   // add edge 2-4
        graph.addEdge(from: 3, to: 2, weight: 9)    // add edge 3-2
        graph.addEdge(from: 3, to: 5, weight: 20)   // add edge 3-5
        graph.addEdge(from: 4, to: 3, weight: 7)    // add edge 4-3
        graph.addEdge(from: 4, to: 5, weight: 4)    // add edge 4-5
        let expected = 23
        /**
         While Ford-Fulkerson seems to be a very reasonable algorithm, and will generally produce a valid
         flow, it may fail to find the maximum one. The greedy algorithm sometimes gets stuck before
         finding the maximum flow.
         */
        var findMaximum = false
        while !findMaximum {
            if mf1.maximumFlowByFordFulkerson(graph, 0, 5) == expected {
                findMaximum = true
            }
        }
        XCTAssertTrue(findMaximum)
    }
    
    // MARK: - Max-flow Min st-cut by Edmonds-Karp
    func testMaxFlowMinCutByEK() {
        let graph = Graph()
        graph.addEdge(from: 0, to: 1, weight: 16)   // add edge 0-1
        graph.addEdge(from: 0, to: 2, weight: 13)   // add edge 0-2
        graph.addEdge(from: 1, to: 2, weight: 10)   // add edge 1-2
        graph.addEdge(from: 1, to: 3, weight: 12)   // add edge 1-3
        graph.addEdge(from: 2, to: 1, weight: 4)    // add edge 2-1
        graph.addEdge(from: 2, to: 4, weight: 14)   // add edge 2-4
        graph.addEdge(from: 3, to: 2, weight: 9)    // add edge 3-2
        graph.addEdge(from: 3, to: 5, weight: 20)   // add edge 3-5
        graph.addEdge(from: 4, to: 3, weight: 7)    // add edge 4-3
        graph.addEdge(from: 4, to: 5, weight: 4)    // add edge 4-5
        let expected = Set([[1, 3], [4, 3], [4, 5]])
        XCTAssertEqual(expected, mf2.minimumCut(graph, 0, 5))
    }
    
    // MARK: - Maximum Flow by Edmonds-Karp
    func testMaxiumumFlowByEK() {
        let graph = Graph()
        graph.addEdge(from: 0, to: 1, weight: 16)   // add edge 0-1
        graph.addEdge(from: 0, to: 2, weight: 13)   // add edge 0-2
        graph.addEdge(from: 1, to: 2, weight: 10)   // add edge 1-2
        graph.addEdge(from: 1, to: 3, weight: 12)   // add edge 1-3
        graph.addEdge(from: 2, to: 1, weight: 4)    // add edge 2-1
        graph.addEdge(from: 2, to: 4, weight: 14)   // add edge 2-4
        graph.addEdge(from: 3, to: 2, weight: 9)    // add edge 3-2
        graph.addEdge(from: 3, to: 5, weight: 20)   // add edge 3-5
        graph.addEdge(from: 4, to: 3, weight: 7)    // add edge 4-3
        graph.addEdge(from: 4, to: 5, weight: 4)    // add edge 4-5
        let expected = 23
        XCTAssertEqual(expected, mf4.maximumFlowByEdmondsKarp(graph, 0, 5).maxFlow)
    }
}
