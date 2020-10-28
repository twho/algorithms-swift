//
//  GR2.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/26/20.
//

class GR2 {
    /**
     Function used to solve 2-Satisfiability (2-SAT) Problem. Determine if the given formula is satisfiable if the Boolean variables can be assigned values
     such that the formula turns out to be true. Otherwise it is unsatisfiable. 2-SAT is a restriction of the SAT problemin. In 2-SAT every clause has exactly
     two literals. for example: (x ∨ ¬y) ∧ (¬x ∨ y) ∧ (¬x ∨ ¬y), where ¬ is an inverse, ∨ is OR and ∧ is AND.
     
     Note that If there is an edge x -> y, then there also is an edge ¬y -> ¬x. Besides, if x is reachable from ¬x, and ¬x is reachable from x, then the problem has
     no solution. In order to find a solution, it is necessary that for any variable x the vertices x and ¬x are in different strongly connected components (SCCs) of
     the strong connection of the implication graph. Therefore, the runtime is O(V+E). For details: https://cp-algorithms.com/graph/2SAT.html
     
     - Returns: A boolean indicates if the formula is satisfiable.
     */
    func is2Satisfiable(_ variable: Int, _ clauses: Int, clauseLeft: [Int], clauseRigt: [Int]) -> Bool {
        let graph = Graph()
        var idx = 0
        while idx < clauseLeft.count && idx < clauseRigt.count {
            graph.addEdge(from: clauseLeft[idx], to: clauseRigt[idx])
            graph.addEdge(from: -clauseRigt[idx], to: -clauseLeft[idx])
            idx += 1
        }
        // Finding SCC is implemented in GR1.
        let gr1 = GR1()
        let SCCs = gr1.findSCCsByDFS(graph)
        for i in 1...variable {
            for SCC in SCCs {
                if SCC.contains(i) && SCC.contains(-i) {
                    return false
                }
            }
        }
        return true
    }
    /**
     Bridge problem. An edge in an undirected connected graph is a bridge if removing it disconnects the graph. The solution uses DFS and
     find if the current edge (a, b) is a bridge by checking if there are other ways from a to b. If there isn't any, then the current edge (a, b) is a bridge.
     Runtime: O(V+E) by Tarjan's algorithm. Example: https://leetcode.com/problems/critical-connections-in-a-network/
     
     - Parameter graph: An undirected graph.
     
     - Returns: A 2D integer array of bridges. Each bridge element is in the form of [x, y].
     */
    func findBridge(_ graph: Graph) -> [[Int]] {
        var output = [[Int]]()
        var visited = Set<Vertex>()
        // Note the discover time and the discover time of the earliest reachable vertex for a vertex.
        var orders = [Vertex : (parent: Vertex?, discover: Int, low: Int)]()
        var counter = 0
        for vertex in graph.adjacencyLists.keys {
            if !visited.contains(vertex) {
                findBridgeHelper(vertex, graph.adjacencyLists, &counter, &visited, &orders, &output)
            }
        }
        return output
    }
    /**
     The recursive method used to perform DFS search and find bridges.
     
     - Parameter vertex:            The vertex to perform DFS on.
     - Parameter adjacencyLists:    The adjacency lists used in the graph.
     - Parameter counter:           The counter used to record discover time and lowest value (earliest reachable time).
     - Parameter visited:           The visited vertices in the current search.
     - Parameter orders:            The dictionary that stores parent, discover time and lowest value.
     - Parameter output:            The output used to store bridges in the graph.
     */
    private func findBridgeHelper(_ vertex: Vertex, _ adjacencyLists: [Vertex : Set<Vertex>], _ counter: inout Int, _ visited: inout Set<Vertex>,
                                  _ orders: inout [Vertex : (parent: Vertex?, discover: Int, low: Int)], _ output: inout [[Int]]) {
        visited.insert(vertex)
        counter += 1
        orders[vertex] = (orders[vertex]?.parent, counter, counter)
        if let adjacencyList = adjacencyLists[vertex] {
            for child in adjacencyList {
                if !visited.contains(child) {
                    // Initialize the numbers for the child
                    orders[child] = (vertex, counter, counter)
                    // Perform DFS
                    findBridgeHelper(child, adjacencyLists, &counter, &visited, &orders, &output)
                    // Check if the child has other ancestors
                    orders[vertex]!.low = min(orders[child]!.low, orders[vertex]!.low)
                    // If the lowest (found earliest in DFS) vertex reachable from child is still after
                    // the current vertex, then it is a bridge.
                    if orders[child]!.low > orders[vertex]!.discover {
                        output.append([vertex.val, child.val])
                    }
                } else if child != orders[vertex]?.parent {
                    // Update the lowest reachable value if needed (the child's parent is not the current vertex.)
                    orders[vertex]!.low = min(orders[child]!.low, orders[vertex]!.low)
                }
            }
        }
    }
}
