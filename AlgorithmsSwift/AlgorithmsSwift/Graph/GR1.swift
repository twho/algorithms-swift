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
        
        for vertex in graph.vertices {
            dfsHelper(vertex, graph.edges, &visited, &output)
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
    private func dfsHelper(_ vertex: Vertex, _ edges: Set<Edge>, _ visited: inout Set<Vertex>, _ output: inout [Int]) {
        if visited.contains(vertex) {
            return
        }
        
        visited.insert(vertex)
        output.append(vertex.val)
        for edge in edges {
            if edge.src == vertex {
                dfsHelper(edge.dest, edges, &visited, &output)
            }
        }
    }
    /**
     The function that output the value of vertices in topological order. In a edge in a directed graph, the vertex used as the source of the edge
     must be printed before the destination of the edge. Note that a graph could have multiple topological output. In addition, a graph has to be
     a directed acyclic graph (DAG) in order to be sorted topologically.
     
     - Parameter graph: An undirected graph.
     
     - Returns: An integer array of topological sorting result.
     */
    func topologicalSort(_ graph: Graph) -> [Int] {
        var output = [Int]()
        
        return output
    }
}
