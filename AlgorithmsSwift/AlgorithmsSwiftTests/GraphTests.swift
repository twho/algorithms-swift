//
//  GraphTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Michael Ho on 10/25/20.
//

import XCTest

class GraphTests: XCTestCase {
    let gr1 = GR1()

    func testDFSTraverse1() {
        let graph = Graph()
        graph.addEdge(0, 1, 1)  // add edge 0-1
        graph.addEdge(0, 2, 4)  // add edge 0-2
        graph.addEdge(2, 6, 1)  // add edge 2-6
        graph.addEdge(1, 3, 2)  // add edge 1-3
        graph.addEdge(3, 1, 1)  // add edge 3-1
        graph.addEdge(3, 4, 3)  // add edge 3-4
        graph.addEdge(4, 5, 1)  // add edge 4-5
        let possibleDFSPaths = [
            [0, 1, 3, 4, 5, 2, 6],
            [0, 2, 6, 1, 3, 4, 5]
        ]
        XCTAssertTrue(possibleDFSPaths.contains(gr1.dfs(graph)))
    }
}
