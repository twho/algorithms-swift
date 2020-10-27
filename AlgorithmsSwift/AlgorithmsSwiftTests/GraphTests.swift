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
            [5, 4, 3, 1, 6, 2, 0],
            [6, 2, 5, 4, 3, 1, 0]
        ]
        XCTAssertTrue(possibleDFSPaths.contains(gr1.dfs(graph)))
    }
    
    func testFindSCCs1() {
        let graph = Graph()
        graph.addEdge(from: 1, to: 0)   // add edge 1-0
        graph.addEdge(from: 0, to: 2)   // add edge 0-2
        graph.addEdge(from: 2, to: 1)   // add edge 2-1
        graph.addEdge(from: 0, to: 3)   // add edge 0-3
        graph.addEdge(from: 3, to: 4)   // add edge 3-4
        let SCCs: Set<Set<Int>> = [
            [0, 1, 2],
            [3],
            [4]
        ]
        XCTAssertEqual(SCCs, gr1.findSCCsByDFS(graph))
    }
    
    func testFindSCCs2() {
        let graph = Graph()
        graph.addEdge(from: 0, to: 1)   // add edge 0-1
        graph.addEdge(from: 1, to: 2)   // add edge 1-2
        graph.addEdge(from: 2, to: 3)   // add edge 2-3
        graph.addEdge(from: 3, to: 0)   // add edge 3-0
        graph.addEdge(from: 2, to: 4)   // add edge 2-4
        graph.addEdge(from: 4, to: 5)   // add edge 4-5
        graph.addEdge(from: 5, to: 6)   // add edge 5-6
        graph.addEdge(from: 6, to: 4)   // add edge 6-4
        graph.addEdge(from: 7, to: 6)   // add edge 7-6
        graph.addEdge(from: 7, to: 8)   // add edge 7-8
        let SCCs: Set<Set<Int>> = [
            [0, 1, 2, 3],
            [4, 5, 6],
            [7],
            [8]
        ]
        XCTAssertEqual(SCCs, gr1.findSCCsByDFS(graph))
    }
    
    func testTopologicalSort() {
        let graph = Graph()
        graph.addEdge(from: 5, to: 0)   // add edge 5-0
        graph.addEdge(from: 4, to: 0)   // add edge 4-0
        graph.addEdge(from: 5, to: 2)   // add edge 5-2
        graph.addEdge(from: 2, to: 3)   // add edge 2-3
        graph.addEdge(from: 3, to: 1)   // add edge 3-1
        graph.addEdge(from: 4, to: 1)   // add edge 4-1
        // Source vertices are 4 and 5.
        let possibleDFSPaths = [
            [4, 5, 0, 2, 3, 1],
            [4, 5, 2, 3, 1, 0],
            [5, 2, 3, 4, 0, 1],
            [5, 2, 3, 4, 1, 0]
        ]
        XCTAssertTrue(possibleDFSPaths.contains(gr1.topologicalSortByDFS(graph)))
    }
}
