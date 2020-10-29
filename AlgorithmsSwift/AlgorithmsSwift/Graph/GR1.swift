//
//  GR1.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/25/20.
//

class GR1 {
    /**
     The function traverses through the undirected graph using DFS method. Runtime: O(V + E), where V represents vertices and E represents edges.
     
     - Parameter graph: An undirected graph.
     
     - Returns: An integer array of DFS traverse result.
     */
    func dfs(_ graph: Graph) -> [Int] {
        var visited = Set<Vertex>()
        var output = [Vertex]()
        
        for vertex in graph.adjacencyLists.keys.sorted(by: { $0.val < $1.val }) {
            if !visited.contains(vertex) {
                dfsHelper(vertex, graph.adjacencyLists, &visited, &output)
            }
        }
        
        return output.map { (vertex) -> Int in
            return vertex.val
        }
    }
    /**
     The function is used as the recursive method in DFS.
     
     - Parameter vertex:            The vertex to explore its relevant edges.
     - Parameter adjacencyLists:    The adjacency lists used in the graph.
     - Parameter visited:           The visisted vertices in the current traverse.
     - Parameter output:            The pointer to the result of DFS traverse.
     */
    private func dfsHelper(_ vertex: Vertex, _ adjacencyLists: [Vertex : Set<Edge>], _ visited: inout Set<Vertex>, _ output: inout [Vertex]) {
        visited.insert(vertex)
        if let adjacencyList = adjacencyLists[vertex] {
            for edge in adjacencyList {
                if !visited.contains(edge.dest) {
                    dfsHelper(edge.dest, adjacencyLists, &visited, &output)
                }
            }
        }
        output.append(vertex)
    }
    /**
     Find strongly connected componenets by DFS. SCC is defined as a group of components in a directed graph that have edges allow them to reach each other.
     It takes two rounds of DFS to find SCCs. Runtime: O(V + E)
     
     - Parameter graph: An undirected graph.
     
     - Returns: A 2D set. Each element in the set represents a SCC, which is a group of components in the graph.
     */
    func findSCCsByDFS(_ graph: Graph) -> Set<Set<Int>> {
        // Perform a normal DFS.
        var visited = Set<Vertex>()
        var stack = [Vertex]()
        for vertex in graph.adjacencyLists.keys {
            if !visited.contains(vertex) {
                dfsHelper(vertex, graph.adjacencyLists, &visited, &stack)
            }
        }
        // Reverse the graph to for 2nd round DFS.
        visited = Set<Vertex>()
        var output = Set<Set<Int>>()
        let reversedGraph = graph.getReversedGraph()
        while !stack.isEmpty {
            var SCC = [Vertex]()
            let vertex = stack.removeLast()
            if !visited.contains(vertex) {
                dfsHelper(vertex, reversedGraph.adjacencyLists, &visited, &SCC)
                let set = Set(SCC.map({ (vertex) -> Int in
                    vertex.val
                }))
                output.insert(set)
            }
        }
        return output
    }
    /**
     The function that output the value of vertices in topological order using DFS method. In topological sort, the vertex used as the source of the edge
     must be printed before the destination of the edge. Note that a graph could have multiple topological output. In addition, a graph has to be
     a directed acyclic graph (DAG) in order to be sorted topologically. Runtime: O(V + E)
     
     - Parameter graph: An undirected graph.
     
     - Returns: An integer array of topological sorting result.
     */
    func topologicalSortByDFS(_ graph: Graph) -> [Int] {
        var output = [Vertex]()
        var visited = Set<Vertex>()
        let sourceVertices = graph.getSourceVertices()
        
        for sourceVertex in sourceVertices {
            if !visited.contains(sourceVertex) {
                dfsHelper(sourceVertex, graph.adjacencyLists, &visited, &output)
            }
        }
        
        return output.reversed().map { (vertex) -> Int in
            return vertex.val
        }
    }
}
