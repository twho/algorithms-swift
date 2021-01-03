//
//  GraphTests.swift
//  AlgorithmsSwiftTests
//
//  Created by Michael Ho on 10/25/20.
//

import XCTest

class GraphTests: XCTestCase {
    let gr1 = GR1()
    let gr2 = GR2()
    let gr3 = GR3()
    let gr4 = GR4()

    // MARK: - DFS
    func testDFSTraverse() {
        let graph = Graph(isDirected: true)
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
    
    // MARK: - BFS
    func testBFSTraverse() {
        let graph = Graph(isDirected: true)
        graph.addEdge(from: 0, to: 1)   // add edge 0-1
        graph.addEdge(from: 0, to: 3)   // add edge 0-3
        graph.addEdge(from: 0, to: 8)   // add edge 0-8
        graph.addEdge(from: 1, to: 7)   // add edge 1-7
        graph.addEdge(from: 2, to: 7)   // add edge 2-7
        graph.addEdge(from: 3, to: 2)   // add edge 3-2
        graph.addEdge(from: 2, to: 5)   // add edge 2-5
        graph.addEdge(from: 3, to: 4)   // add edge 3-4
        graph.addEdge(from: 4, to: 8)   // add edge 4-8
        graph.addEdge(from: 5, to: 6)   // add edge 5-6
        let expected = [0, 1, 3, 8, 7, 2, 4, 5, 6]
        XCTAssertEqual(expected, gr1.bfs(graph))
    }
    
    // MARK: - Bidirectional BFS
    func testBidirectionalBFS1() {
        let graph = Graph(isDirected: false)
        graph.addEdge(from: 0, to: 1)   // add edge 0-1
        graph.addEdge(from: 0, to: 3)   // add edge 0-3
        graph.addEdge(from: 3, to: 2)   // add edge 3-2
        graph.addEdge(from: 2, to: 5)   // add edge 2-5
        graph.addEdge(from: 3, to: 4)   // add edge 3-4
        graph.addEdge(from: 4, to: 6)   // add edge 4-8
        graph.addEdge(from: 5, to: 6)   // add edge 5-6
        XCTAssertEqual(3, gr1.bidirectionalBFS(graph, 0, 6))
        XCTAssertEqual(-1, gr1.bidirectionalBFS(graph, 0, 7))
        // Add another shorter path to graph
        graph.addEdge(from: 0, to: 7)   // add edge 0-7
        graph.addEdge(from: 7, to: 6)   // add edge 7-6
        XCTAssertEqual(2, gr1.bidirectionalBFS(graph, 0, 6))
    }
    
    func testBidirectionalBFS2() {
        let graph = Graph(isDirected: false)
        graph.addEdge(from: 0, to: 4)   // add edge 0-4
        graph.addEdge(from: 1, to: 4)   // add edge 1-4
        graph.addEdge(from: 2, to: 5)   // add edge 2-5
        graph.addEdge(from: 3, to: 5)   // add edge 3-5
        graph.addEdge(from: 4, to: 6)   // add edge 4-6
        graph.addEdge(from: 5, to: 6)   // add edge 5-6
        graph.addEdge(from: 6, to: 7)   // add edge 6-7
        graph.addEdge(from: 7, to: 8)   // add edge 7-8
        graph.addEdge(from: 8, to: 9)   // add edge 8-9
        graph.addEdge(from: 8, to: 10)  // add edge 8-10
        graph.addEdge(from: 9, to: 11)  // add edge 9-11
        graph.addEdge(from: 9, to: 12)  // add edge 9-12
        graph.addEdge(from: 10, to: 13) // add edge 10-13
        graph.addEdge(from: 10, to: 14) // add edge 10-14
        let expected = 6
        XCTAssertEqual(expected, gr1.bidirectionalBFS(graph, 0, 14))
    }
    
    // MARK: - Strongly Connected Components
    func testFindSCCs1() {
        let graph = Graph(isDirected: true)
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
        let graph = Graph(isDirected: true)
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
    
    // MARK: - Topological Sort
    func testTopologicalSort1() {
        let graph = Graph(isDirected: true)
        graph.addEdge(from: 5, to: 0)   // add edge 5-0
        graph.addEdge(from: 4, to: 0)   // add edge 4-0
        graph.addEdge(from: 0, to: 1)   // add edge 0-1
        graph.addEdge(from: 5, to: 2)   // add edge 5-2
        graph.addEdge(from: 2, to: 3)   // add edge 2-3
        graph.addEdge(from: 2, to: 0)   // add edge 2-0
        graph.addEdge(from: 3, to: 1)   // add edge 3-1
        graph.addEdge(from: 3, to: 0)   // add edge 3-0
        graph.addEdge(from: 4, to: 1)   // add edge 4-1
        // Source vertices are 4 and 5.
        let possiblePaths = [
            [4, 5, 2, 3, 0, 1],
            [5, 2, 3, 4, 0, 1],
            [5, 4, 2, 3, 0, 1]
        ]
        XCTAssertTrue(possiblePaths.contains(gr1.topologicalSortByDFS(graph)))
        XCTAssertTrue(possiblePaths.contains(gr1.topologicalSortByBFS(graph)))
    }
    
    func testTopologicalSort2() {
        let graph = Graph(isDirected: true)
        graph.addEdge(from: 4, to: 3)   // add edge 4-3
        graph.addEdge(from: 4, to: 2)   // add edge 4-2
        graph.addEdge(from: 3, to: 2)   // add edge 3-2
        graph.addEdge(from: 4, to: 1)   // add edge 4-1
        graph.addEdge(from: 1, to: 0)   // add edge 1-0
        graph.addEdge(from: 2, to: 0)   // add edge 2-0
        graph.addEdge(from: 2, to: 1)   // add edge 2-1
        // Source vertices is 4.
        let expected = [4, 3, 2, 1, 0]
        XCTAssertEqual(expected, gr1.topologicalSortByDFS(graph))
        XCTAssertEqual(expected, gr1.topologicalSortByBFS(graph))
    }
    
    func testDirectedGraphCycleDetection1() {
        let graph = Graph(isDirected: true)
        graph.addEdge(from: 4, to: 3)   // add edge 4-3
        graph.addEdge(from: 4, to: 2)   // add edge 4-2
        graph.addEdge(from: 3, to: 2)   // add edge 3-2
        graph.addEdge(from: 4, to: 1)   // add edge 4-1
        graph.addEdge(from: 1, to: 0)   // add edge 1-0
        graph.addEdge(from: 2, to: 0)   // add edge 2-0
        graph.addEdge(from: 2, to: 1)   // add edge 2-1
        XCTAssertFalse(gr1.detectCycleInDirectedGraph(graph))
    }
    
    func testDirectedGraphCycleDetection2() {
        let graph = Graph(isDirected: true)
        graph.addEdge(from: 0, to: 1)   // add edge 0-1
        graph.addEdge(from: 1, to: 2)   // add edge 1-2
        graph.addEdge(from: 0, to: 2)   // add edge 0-2
        graph.addEdge(from: 2, to: 0)   // add edge 2-0
        graph.addEdge(from: 2, to: 3)   // add edge 2-3
        graph.addEdge(from: 3, to: 3)   // add edge 3-3
        XCTAssertTrue(gr1.detectCycleInDirectedGraph(graph))
    }
    
    func testFindBridge() {
        let graph = Graph(isDirected: false)
        graph.addEdge(from: 0, to: 1)   // add edge 0-1
        graph.addEdge(from: 1, to: 2)   // add edge 1-2
        graph.addEdge(from: 2, to: 0)   // add edge 2-0
        graph.addEdge(from: 1, to: 3)   // add edge 1-3
        graph.addEdge(from: 3, to: 4)   // add edge 3-4
        graph.addEdge(from: 4, to: 5)   // add edge 4-5
        graph.addEdge(from: 5, to: 3)   // add edge 5-3
        let expected = [[3, 1], [1, 3]]
        let output = gr2.findBridge(graph)
        XCTAssertTrue(expected[0] == output.first! || expected[1] == output.first!)
    }
    
    // MARK: - 2-SAT Problem
    func test2SATProblem1() {
        /**
         The Conjunctive Normal Form (CNF) being handled is: (∨ is OR and ∧ is AND)
         (x1 ∨ x2) ∧ (¬x2 ∨ x3) ∧ (¬x1 ∨ ¬x2) ∧ (x3 ∨ x4) ∧ (¬x3 ∨ x5) ∧ (¬x4 ∨ ¬x5) ∧ (¬x3 ∨ x4)
         */
        let input = (
            variables: 5,
            clauses: 7,
            clause1: [1, -2, -1, 3, -3, -4, -3],    // Left side of each clause
            clause2: [2, 3, -2, 4, 5, -4, -5, 4]    // Right side of each clause
        )
        XCTAssertTrue(gr2.is2Satisfiable(input.variables, input.clauses, clauseLeft: input.clause1, clauseRigt: input.clause2))
    }
    
    func test2SATProblem2() {
        /**
         The Conjunctive Normal Form (CNF) being handled is: (∨ is OR and ∧ is AND)
         (x1 ∨ x2) ∧ (¬x1 ∨ x2) ∧ (x1 ∨ ¬x2) ∧ (¬x1 ∨ ¬x2)
         */
        let input = (
            variables: 2,
            clauses: 4,
            clause1: [1, -1, 1, -1],    // Left side of each clause
            clause2: [2, 2, -2, -2]     // Right side of each clause
        )
        XCTAssertFalse(gr2.is2Satisfiable(input.variables, input.clauses, clauseLeft: input.clause1, clauseRigt: input.clause2))
    }
    
    // MARK: - Union-Find
    func testUnionFind1() {
        let graph = Graph(isDirected: false)
        graph.addEdge(from: 0, to: 1)   // add edge 0-1
        graph.addEdge(from: 1, to: 2)   // add edge 1-2
        graph.addEdge(from: 2, to: 0)   // add edge 2-0
        graph.addEdge(from: 1, to: 3)   // add edge 1-3
        graph.addEdge(from: 3, to: 4)   // add edge 3-4
        graph.addEdge(from: 4, to: 5)   // add edge 4-5
        graph.addEdge(from: 5, to: 3)   // add edge 5-3
        XCTAssertTrue(gr3.isCycleExisting(graph))
    }
    
    func testUnionFind2() {
        let graph = Graph(isDirected: false)
        graph.addEdge(from: 0, to: 1)   // add edge 0-1
        graph.addEdge(from: 1, to: 2)   // add edge 1-2
        graph.addEdge(from: 2, to: 3)   // add edge 2-3
        graph.addEdge(from: 0, to: 4)   // add edge 0-4
        XCTAssertFalse(gr3.isCycleExisting(graph))
    }
    
    // MARK: - Bipartite
    func testBipartite1() {
        let graph = Graph(isDirected: false)
        graph.addEdge(from: 0, to: 1)   // add edge 0-1
        graph.addEdge(from: 0, to: 2)   // add edge 0-2
        graph.addEdge(from: 0, to: 3)   // add edge 0-3
        graph.addEdge(from: 1, to: 2)   // add edge 1-2
        graph.addEdge(from: 2, to: 3)   // add edge 2-3
        XCTAssertFalse(gr3.isBipartite(graph))
    }
    
    func testBipartite2() {
        let graph = Graph(isDirected: false)
        graph.addEdge(from: 0, to: 1)   // add edge 0-1
        graph.addEdge(from: 1, to: 2)   // add edge 1-2
        graph.addEdge(from: 2, to: 3)   // add edge 2-3
        graph.addEdge(from: 3, to: 0)   // add edge 3-0
        XCTAssertTrue(gr3.isBipartite(graph))
    }
    
    // MARK: - Miniumum Spanning Tree (MST)
    func testMST1() {
        let graph = Graph(isDirected: false)
        graph.addEdge(from: 0, to: 1, weight: 10)   // add edge 0-1
        graph.addEdge(from: 1, to: 3, weight: 15)   // add edge 1-3
        graph.addEdge(from: 0, to: 3, weight: 5)    // add edge 0-3
        graph.addEdge(from: 0, to: 2, weight: 6)    // add edge 0-2
        graph.addEdge(from: 2, to: 3, weight: 4)    // add edge 2-3
        let expected = 19
        XCTAssertEqual(expected, gr3.findMinimumSpanningTree(graph))
    }
    
    func testMST2() {
        let graph = Graph(isDirected: false)
        graph.addEdge(from: 0, to: 1, weight: 4)    // add edge 0-1
        graph.addEdge(from: 0, to: 7, weight: 8)    // add edge 0-7
        graph.addEdge(from: 1, to: 7, weight: 11)   // add edge 1-7
        graph.addEdge(from: 1, to: 2, weight: 8)    // add edge 1-2
        graph.addEdge(from: 7, to: 8, weight: 7)    // add edge 7-8
        graph.addEdge(from: 8, to: 6, weight: 6)    // add edge 8-6
        graph.addEdge(from: 7, to: 6, weight: 1)    // add edge 7-6
        graph.addEdge(from: 6, to: 5, weight: 2)    // add edge 6-5
        graph.addEdge(from: 2, to: 8, weight: 2)    // add edge 2-8
        graph.addEdge(from: 2, to: 5, weight: 4)    // add edge 2-5
        graph.addEdge(from: 2, to: 3, weight: 7)    // add edge 2-3
        graph.addEdge(from: 3, to: 5, weight: 14)   // add edge 3-5
        graph.addEdge(from: 3, to: 4, weight: 9)    // add edge 3-4
        graph.addEdge(from: 5, to: 4, weight: 10)   // add edge 5-4
        let expected = 37
        XCTAssertEqual(expected, gr3.findMinimumSpanningTree(graph))
    }
    
    // MARK: - PageRank
    func testPageRank1() {
        let webGraph = WebGraph()
        webGraph.addEdge(from: 1, to: 2, weight: 1)    // add edge 1-2
        webGraph.addEdge(from: 1, to: 3, weight: 1)    // add edge 1-3
        webGraph.addEdge(from: 2, to: 3, weight: 1)    // add edge 2-3
        webGraph.addEdge(from: 2, to: 4, weight: 1)    // add edge 2-4
        webGraph.addEdge(from: 3, to: 4, weight: 1)    // add edge 3-4
        webGraph.addEdge(from: 4, to: 1, weight: 1)    // add edge 4-1
        webGraph.addEdge(from: 4, to: 2, weight: 1)    // add edge 4-2
        webGraph.addEdge(from: 4, to: 3, weight: 1)    // add edge 4-3
        let expectedRank = [4, 3, 2, 1]
        XCTAssertEqual(expectedRank, gr4.performPageRank(webGraph))
    }
    
    func testPageRank2() {
        let webGraph = WebGraph()
        webGraph.addEdge(from: 1, to: 2, weight: 1)    // add edge 1-2
        webGraph.addEdge(from: 1, to: 3, weight: 1)    // add edge 1-3
        webGraph.addEdge(from: 2, to: 3, weight: 1)    // add edge 2-3
        webGraph.addEdge(from: 4, to: 3, weight: 1)    // add edge 4-3
        webGraph.addEdge(from: 3, to: 1, weight: 1)    // add edge 3-1
        let expectedRank = [3, 1, 2, 4]
        XCTAssertEqual(expectedRank, gr4.performPageRank(webGraph))
    }
}
