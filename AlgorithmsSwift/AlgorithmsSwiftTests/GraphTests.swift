//
//  GraphTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Michael Ho on 10/25/20.
//

import XCTest

class GraphTests: XCTestCase {
    let gr1 = GR1()

    func testDFSTraverse() {
        let graph = Graph()
        graph.addEdge(from: 0, to: 1)   // add edge 0-1
        graph.addEdge(from: 0, to: 2)   // add edge 0-2
        graph.addEdge(from: 2, to: 6)   // add edge 2-6
        graph.addEdge(from: 1, to: 3)   // add edge 1-3
        graph.addEdge(from: 3, to: 1)   // add edge 3-1
        graph.addEdge(from: 3, to: 4)   // add edge 3-4
        graph.addEdge(from: 4, to: 5)   // add edge 4-5
        let possibleDFSPaths = [
            [0, 1, 3, 4, 5, 2, 6],
            [0, 2, 6, 1, 3, 4, 5]
        ]
        XCTAssertTrue(possibleDFSPaths.contains(gr1.dfs(graph)))
    }
    
    func testTopologicalSort() {
        let graph = Graph()
        graph.addEdge(from: 5, to: 0)   // add edge 5-0
        graph.addEdge(from: 4, to: 0)   // add edge 4-0
        graph.addEdge(from: 5, to: 2)   // add edge 5-2
        graph.addEdge(from: 2, to: 3)   // add edge 2-3
        graph.addEdge(from: 3, to: 1)   // add edge 3-1
        graph.addEdge(from: 4, to: 1)   // add edge 4-1
        // Sink vertices are 4 and 5.
        let possibleDFSPaths = [
            [4, 5, 0, 2, 3, 1],
            [4, 5, 2, 3, 1, 0],
            [5, 2, 3, 4, 0, 1],
            [5, 2, 3, 4, 1, 0]
        ]
        XCTAssertTrue(possibleDFSPaths.contains(gr1.topologicalSortByDFS(graph)))
    }
}
