//
//  GR1.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/25/20.
//
/**
 Graph
 
 Terminology in Graph
 - Connected Component:             Components that are connected in the graph.
 - Strongly Connected Component:    A group of Components in a directed graph that have edges allow them to reach each other.
 - Source vertex:                   The vertex in the graph that has no incoming edges. (Topological Sorting)
 - Sink vertex:                     The vertex in the graph that has no outgoing edges. (Topological Sorting)
 */
class GR1 {
    /**
     The function traverses through the undirected graph using DFS method. Runtime: O(V + E), where V represents vertices and E represents edges.
     
     - Parameter graph: An undirected graph.
     
     - Returns: An integer array of DFS traverse result.
     */
    func dfs(_ graph: Graph) -> [Int] {
        var visited = Set<Vertex>()
        var output = [Int]()
        
        for vertex in graph.adjacencyLists.keys.sorted(by: { $0.val < $1.val }) {
            if !visited.contains(vertex) {
                dfsHelper(vertex, graph.adjacencyLists, &visited, &output)
            }
        }
        
        return output
    }
    /**
     The function is used as the recursive method in DFS.
     
     - Parameter vertex:    The vertex to explore its relevant edges.
     - Parameter edges:     The edges in the graph.
     - Parameter visited:   The visisted vertices in the current traverse.
     - Parameter output:    The pointer to the result of DFS traverse.
     */
    private func dfsHelper(_ vertex: Vertex, _ adjacencyLists: [Vertex : Set<Vertex>], _ visited: inout Set<Vertex>, _ output: inout [Int]) {
        visited.insert(vertex)
        output.append(vertex.val)
        if let adjacencyList = adjacencyLists[vertex] {
            for otherVertex in adjacencyList {
                if !visited.contains(otherVertex) {
                    dfsHelper(otherVertex, adjacencyLists, &visited, &output)
                }
            }
        }
    }
    /**
     The function that output the value of vertices in topological order using DFS method. In topological sort, the vertex used as the source of the edge
     must be printed before the destination of the edge. Note that a graph could have multiple topological output. In addition, a graph has to be
     a directed acyclic graph (DAG) in order to be sorted topologically.
     
     - Parameter graph: An undirected graph.
     
     - Returns: An integer array of topological sorting result.
     */
    func topologicalSortByDFS(_ graph: Graph) -> [Int] {
        var output = [Int]()
        var visited = Set<Vertex>()
        
        // Find the sink vertex to before sorting.
        let sinkVertices = graph.calculateInDegreeOfVertices().filter({ (_, indegree) -> Bool in
            return indegree == 0
        }).map { (vertex, _) -> Vertex in
            return vertex
        }
        
        for sinkVertex in sinkVertices {
            if !visited.contains(sinkVertex) {
                output = topologicalSortHelper(sinkVertex, graph.adjacencyLists, &visited) + output
            }
        }
        
        return output
    }
    
    private func topologicalSortHelper(_ vertex: Vertex, _ adjacencyLists: [Vertex : Set<Vertex>], _ visited: inout Set<Vertex>) -> [Int] {
        var result = [Int]()
        if let adjacencyList = adjacencyLists[vertex] {
            for otherVertex in adjacencyList {
                if !visited.contains(otherVertex) {
                    result += topologicalSortHelper(otherVertex, adjacencyLists, &visited)
                }
            }
        }
        visited.insert(vertex)
        return [vertex.val] + result
    }
}
