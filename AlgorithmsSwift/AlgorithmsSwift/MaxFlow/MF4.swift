//
//  MF4.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/4/20.
//

class MF4 {
    /**
     Edmonds-Karp algorithm is another example of finding maximum flow. The algorithm uses BFS to find
     augmenting paths instead of DFS (Ford-Fulkerson can use DFS or BFS). Note that the algorithm runs
     without any assumptions on capacities. The runtime is O(V(E^2)), where V is the number of vertices
     and E is the number of edges.
     
     Reference: https://cp-algorithms.com/graph/edmonds_karp.html#toc-tgt-1
     
     - Parameter graph: An directed graph.
     - Parameter start: The start point of the flow.
     - Parameter end:   The end point of the flow.
     
     - Returns: An integer indicates the maximum flow and a weight dictionary represents a graph.
     */
    func maximumFlowByEdmondsKarp(_ graph: Graph, _ start: Int, _ end: Int) -> (maxFlow: Int, residualGraph: [String : Int]) {
        // The parents dictionary for quick reference to the parent of the vertex.
        var parents = [Vertex : Vertex]()
        // The residual graph in the format of weight dictionary.
        var rGraph = graph.buildtWeightDictionary()
        var maxFlow = 0
        let vertices = Array(graph.adjacencyLists.keys)
        // Use BFS to find augmented paths
        while bfs(vertices, rGraph, Vertex(start), Vertex(end), &parents) {
            var pathFlow = Int.max
            var vertex = Vertex(end)
            while vertex != Vertex(start) {
                let source = parents[vertex]!
                let sourceKey = Graph.getKey(source, vertex)
                if rGraph[sourceKey] != nil {
                    pathFlow = min(rGraph[sourceKey]!, pathFlow)
                }
                // Track back the path.
                vertex = parents[vertex]!
            }
            
            vertex = Vertex(end)
            while vertex != Vertex(start) {
                let source = parents[vertex]!
                // Update residual capacities of the edges.
                let sourceKey = Graph.getKey(source, vertex)
                if rGraph[sourceKey] == nil {
                    rGraph[sourceKey] = 0
                }
                rGraph[sourceKey]! -= pathFlow
                
                // Update residual capacities of the reverse edges.
                let destinationKey = Graph.getKey(vertex, source)
                if rGraph[destinationKey] == nil {
                    rGraph[destinationKey] = 0
                }
                rGraph[destinationKey]! += pathFlow
                
                // Track back the path.
                vertex = parents[vertex]!
            }
            maxFlow += pathFlow
        }
        return (maxFlow, rGraph)
    }
    /**
     Utility function that utilizes BFS to find path from start to end.
     
     - Parameter vertexCount: The count of the vertices in the graph.
     - Parameter graph:       A residual graph of the original input graph.
     - Parameter start:       The start point of the flow.
     - Parameter end:   The end point of the flow.
     
     - Returns: The boolean indicates if there is a path from start to end. Return true if there is, otherwise, return false.
     */
    private func bfs(_ vertices: [Vertex], _ residualGraph: [String : Int], _ start: Vertex, _ end: Vertex, _ parents: inout [Vertex : Vertex]) -> Bool {
        var visited = Set([start])
        var queue = [start]
        parents[start] = Vertex(-1)
        while !queue.isEmpty {
            let vertex = queue.removeFirst()
            for otherVertex in vertices {
                if !visited.contains(otherVertex), let weight = residualGraph[Graph.getKey(vertex, otherVertex)], weight > 0 {
                    queue.append(otherVertex)
                    visited.insert(otherVertex)
                    parents[otherVertex] = vertex
                }
            }
        }
        // The path is found if BFS reached sink from source.
        return visited.contains(end)
    }
}
