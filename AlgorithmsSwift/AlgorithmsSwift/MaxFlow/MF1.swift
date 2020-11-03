//
//  MF1.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/30/20.
//

class MF1 {
    /**
     Maximum flow problems involve finding a valid flow through a single-source, single-sink flow network that has maximum total weight.
     In Ford-Fulkerson method, a Residual Graph has edges with valuescalled residual capacity, which is equal to original capacity of the
     edge minus current flow. The Runtime of the algorithm is O(CE), where C is the count of possible maximum flows and E is the number of edges.
     
     - Parameter graph: An directed graph.
     - Parameter start: The start point of the flow.
     - Parameter end:   The end point of the flow.
     
     - Returns: An integer indicates the maximum flow and a weight dictionary represents a graph.
     */
    func maximumFlowByFordFulkerson(_ graph: Graph, _ start: Int, _ end: Int) -> (maxFlow: Int, residualGraph: [String : Int]) {
        // The parents dictionary for quick reference to the parent of the vertex.
        var parents = [Vertex : Vertex]()
        // The residual graph in the format of weight dictionary.
        var rGraph = buildtWeightDictionary(graph)
        var maxFlow = 0
        let vertices = Array(graph.adjacencyLists.keys)
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
    /**
     Utility function to build weight dictionary for quick reference.
     
     - Parameter graph: A residual graph of the original input graph.
     
     - Returns: A dicionary with the key in a string form of "src.val, dest.val" and the value is the weight of the edge.
     */
    private func buildtWeightDictionary(_ graph: Graph) -> [String : Int] {
        var dict = [String : Int]()
        for vertex in graph.adjacencyLists.keys {
            if let edges = graph.adjacencyLists[vertex] {
                for edge in edges {
                    dict[Graph.getKey(edge.src, edge.dest)] = edge.weight
                }
            }
        }
        return dict
    }
}
