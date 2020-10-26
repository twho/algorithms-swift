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
        let graph = Graph.createDefaultGraph(withNegativeEdge: false)
        let possibleDFSPaths = [
            [0, 1, 3, 4, 5, 2, 6],
            [0, 2, 6, 1, 3, 4, 5]
        ]
        XCTAssertTrue(possibleDFSPaths.contains(gr1.dfs(graph)))
    }
}
