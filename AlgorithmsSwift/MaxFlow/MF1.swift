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
     edge minus current flow. Besides, using DFS only promises to find a path from source to sink in the residual graph, not necessarily a
     shortest possible path. The Runtime of the algorithm is O(CE), where C is the count of possible maximum flows and E is the number of edges.
     Note that Ford-Fulkerson 
     
     Reference: https://www.cs.umd.edu/class/fall2017/cmsc451-0101/Lects/lect15-flow-ford-fulk.pdf
     
     - Parameter graph: An directed graph.
     - Parameter start: The start point of the flow.
     - Parameter end:   The end point of the flow.
     
     - Returns: An integer indicates the maximum flow.
     */
    func maximumFlowByFordFulkerson(_ graph: Graph, _ start: Int, _ end: Int) -> Int {
        var rGraph = graph.buildtWeightDictionary()
        var maxFlow = 0
        var flow = 0
        repeat {
            var visited = Set<Vertex>()
            flow = dfs(Vertex(start), Vertex(end), Int.max, graph.adjacencyLists, &rGraph, &visited)
            maxFlow += flow
        } while flow != 0
        return maxFlow
    }
    
    private func dfs(_ start: Vertex, _ end: Vertex, _ currentFlow: Int, _ adjacencyLists: [Vertex : Set<Edge>],
                     _ rGraph: inout [String : Int], _ visited: inout Set<Vertex>) -> Int {
        guard start != end else { return currentFlow }
        visited.insert(start)
        if let edges = adjacencyLists[start] {
            // Shuffling is required by the tests but not the implementation itself. We need to
            // huffle to get different results since the algorithm does not guarantee good results.
            let shuffledEdges = edges.shuffled()
            for edge in shuffledEdges {
                let sourceKey = Graph.getKey(edge.src, edge.dest)
                if !visited.contains(edge.dest), let weight = rGraph[sourceKey], weight > 0 {
                    let flow = min(currentFlow, weight)
                    let dfsFlow = dfs(edge.dest, end, flow, adjacencyLists, &rGraph, &visited)
                    // Update capacities
                    if dfsFlow > 0 {
                        // Update residual capacities of the edges.
                        if rGraph[sourceKey] == nil {
                            rGraph[sourceKey] = 0
                        }
                        rGraph[sourceKey]! -= dfsFlow
                        
                        // Update residual capacities of the reverse edges.
                        let destinationKey = Graph.getKey(edge.dest, edge.src)
                        if rGraph[destinationKey] == nil {
                            rGraph[destinationKey] = 0
                        }
                        rGraph[destinationKey]! += dfsFlow
                        return dfsFlow
                    }
                }
            }
        }
        return 0
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
