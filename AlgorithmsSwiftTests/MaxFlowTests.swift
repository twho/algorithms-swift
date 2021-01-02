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
    let mf5 = MF5()
    
    // MARK: - Maximum Flow by Ford-Fulkerson (DFS)
    func testMaxiumumFlowByFF() {
        let graph = Graph(isDirected: true)
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
        let graph = Graph(isDirected: true)
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
        let graph = Graph(isDirected: true)
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
    
    // MARK: - Graph circulation
    func testGraphCirculation1() {
        let graph = Graph(isDirected: true)
        graph.addEdge(from: 0, to: 2, weight: 3)    // add edge 0-2
        graph.addEdge(from: 0, to: 3, weight: 1)    // add edge 0-3
        graph.addEdge(from: 1, to: 0, weight: 2)    // add edge 1-0
        graph.addEdge(from: 1, to: 3, weight: 3)    // add edge 1-3
        graph.addEdge(from: 3, to: 2, weight: 2)    // add edge 3-2
        let vertexDemands = [
            Vertex(0) : -3,
            Vertex(1) : -4,
            Vertex(2) : 2,
            Vertex(3) : 4
        ]
        XCTAssertFalse(mf5.circulationWithDemands(graph, vertexDemands))
    }
    
    func testGraphCirculation2() {
        let graph = Graph(isDirected: true)
        graph.addEdge(from: 0, to: 3, weight: 6)    // add edge 0-3
        graph.addEdge(from: 0, to: 4, weight: 7)    // add edge 0-4
        graph.addEdge(from: 1, to: 3, weight: 7)    // add edge 1-3
        graph.addEdge(from: 1, to: 5, weight: 9)    // add edge 1-5
        graph.addEdge(from: 2, to: 0, weight: 10)   // add edge 2-0
        graph.addEdge(from: 2, to: 3, weight: 3)    // add edge 2-3
        graph.addEdge(from: 4, to: 1, weight: 4)    // add edge 4-1
        graph.addEdge(from: 4, to: 5, weight: 4)    // add edge 4-5
        let vertexDemands = [
            Vertex(0) : -8,
            Vertex(1) : -6,
            Vertex(2) : -7,
            Vertex(3) : 10,
            Vertex(4) : 0,
            Vertex(5) : 11
        ]
        XCTAssertTrue(mf5.circulationWithDemands(graph, vertexDemands))
    }
}
