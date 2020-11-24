//
//  MF2.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/2/20.
//

class MF2 {
    let mf4 = MF4()
    /**
     Max-flow Min st-cut Theorem: size of max flow = min capacity of a s-t cut. Base on the theory, the function
     utiliizes Edmonds-Karp method to find max flow then uses its residual graph to find minimum s-t cut.
     
     - Parameter graph: An directed graph.
     - Parameter start: The start point of the flow.
     - Parameter end:   The end point of the flow.
     
     - Returns: A set of integer array that represents the edges in minimum s-t cut.
     */
    func minimumCut(_ graph: Graph, _ start: Int, _ end: Int) -> Set<[Int]> {
        // Use Edmonds-Karp method since it is guranteed to find shortest path and to terminate.
        let rGraph = Graph.buildGraphFromWeightDictionary(mf4.maximumFlowByEdmondsKarp(graph, start, end).residualGraph)
        var visited = Set<Vertex>()
        // Start DFS traverse from the starting vertex.
        dfsHelper(Vertex(start), rGraph.adjacencyLists, &visited)
        // Go through all edges to find the minimum cut.
        var output = Set<[Int]>()
        for vertex in graph.adjacencyLists.keys {
            let edges = graph.adjacencyLists[vertex]!
            for edge in edges {
                // Find edges that are from a reachable vertex to unreachable vertex in the original graph
                if edge.weight > 0, visited.contains(edge.src), !visited.contains(edge.dest) {
                    output.insert([edge.src.val, edge.dest.val])
                }
            }
        }
        return output
    }
    /**
     Utility function used to traverse the graph by DFS.
     
     - Parameter edges:             Edges represented by a dicionary in the form of ["src.val, dest.val" : weight].
     - Parameter adjacencyLists:    The adjacency lists used in the graph.
     - Parameter visited:           The visisted vertices in the current traverse.
     */
    func dfsHelper(_ vertex: Vertex, _ adjacencyLists: [Vertex : Set<Edge>], _ visited: inout Set<Vertex>) {
        visited.insert(vertex)
        if let list = adjacencyLists[vertex] {
            for edge in list {
                if edge.weight > 0, !visited.contains(edge.dest) {
                    dfsHelper(edge.dest, adjacencyLists, &visited)
                }
            }
        }
    }
}
