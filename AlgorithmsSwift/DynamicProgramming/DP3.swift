//
//  DP3.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/5/20.
//

class DP3 {
    /**
     The Dijkstra class contains method to solve shortest path problem using Dijkstra algorithm.
     */
    class Dijkstra {
        /**
         The Dijkstra's method used to calculate shortest path among vertices in a graph. This method does not
         consider negative cycles in the graph.
         Reference: https://www.geeksforgeeks.org/dijkstras-shortest-path-algorithm-greedy-algo-7/
         
         - Parameter graph: The graph data structure to find shortest path algorithm.
         - Parameter src:   The source (start point) of the graph.
         
         - Returns: An array represents the shortest paths from source to all vertices in the given graph.
         */
        func shortestPath(_ graph: Graph, _ src: Int) -> [Int] {
            /**
             if vertex i is included in shortest path tree or shortest distance
             from src to i is finalized
             */
            var sptSet = Set<Vertex>() // shortest path tree set
            var distances = [Vertex : Int]()
            for vertex in graph.adjacencyLists.keys {
                distances[vertex] = Int.max
            }
            // Distance of source vertex from itself is always 0
            let start = Vertex(src)
            distances[start] = 0
            // Find shortest path for all vertices
            for _ in 0..<graph.adjacencyLists.keys.count - 1 {
                /**
                 Pick the minimum distance vertex from the set of vertices not yet processed.
                 u is always equal to src in first iteration.
                 */
                let u = minDistance(graph.adjacencyLists, start, distances, sptSet)
                // Mark the picked vertex as processed
                sptSet.insert(u)
                for vertex in graph.adjacencyLists.keys {
                    /**
                     Update dist[v] only if it is not in sptSet, there is an edge from u to v,
                     and total weight of path from src to v through u is smaller than current
                     value of dist[v]
                     */
                    if let edges = graph.adjacencyLists[u] {
                        for edge in edges {
                            if !sptSet.contains(vertex) && edge.dest == vertex && distances[u] != nil &&
                                distances[u]! + edge.weight < distances[vertex]! {
                                distances[vertex] = distances[u]! + edge.weight
                            }
                        }
                    }
                }
            }
            return distances.sorted(by: { $0.key.val < $1.key.val }).map { $0.value }
        }
        /**
         Calculate the shortest distance of two vertices.
         
         - Parameter adjacency: The adjacency list of the graph.
         - Parameter src:    The starting vertex to find shortest path.
         - Parameter dist:   The distance array which is used to store shortest distance of src to other vertices.
         - Parameter sptSet: The boolean array that indicates whether the vertex is processed.
         
         - Returns: The minimum distance as an integer.
         */
        private func minDistance(_ adjacency: [Vertex : Set<Edge>], _ src: Vertex, _ dist: [Vertex : Int], _ sptSet: Set<Vertex>) -> Vertex {
            // Initialize min value
            var min = Int.max
            var minVertex = src
            for vertex in adjacency.keys {
                if !sptSet.contains(vertex), dist[vertex]! <= min {
                    min = dist[vertex]!
                    minVertex = vertex
                }
            }
            return minVertex
        }
    }
    /**
     The BellmanFord class contains method to solve shortest path problem using Bellman Ford algorithm.
     */
    class BellmanFord {
        /**
         The dynamic programming method used to calculate the shortest path among vertices with negative cycle.
         A negative cycle is one in which the overall sum of the cycle comes negative. Dijkstra’s algorithm
         requires all edge weight ≥ 0 while Bellman Ford algorithm address the issue. Bellman Ford algorithm
         detects negative cycle. The runtime is O(VE).
         Reference: https://www.geeksforgeeks.org/bellman-ford-algorithm-dp-23/
         
         - Parameter graph: The graph data structure to find shortest path algorithm.
         - Parameter src:   The source (start point) of the graph.
         
         - Returns: An array represents the shortest paths from source to all vertices in the given graph.
         */
        func shortestPath(_ graph: Graph, _ src: Int) -> (hasNegativeCycle: Bool, dist: [Int]) {
            var distances = [Vertex : Int]()
            for vertex in graph.adjacencyLists.keys {
                distances[vertex] = Int.max
            }
            // The distance to self is 0
            let start = Vertex(src)
            distances[start] = 0
            /**
             Relax all edges |V| - 1 times. A simple shortest path from src to any other vertex
             can have at-most |V| - 1 edges.
             */
            for _ in 0..<graph.adjacencyLists.keys.count - 1 {
                for edge in graph.directedEdges {
                    let u = edge.src
                    let v = edge.dest
                    // Update the current solution if there is a shorter one.
                    if (distances[u] != Int.max && distances[u]! + edge.weight < distances[v]!) {
                        distances[v] = distances[u]! + edge.weight
                    }
                }
            }
            /**
             Check for negative-weight cycles. The above step guarantees shortest distances
             if graph doesn't contain negative weight cycle. If we get a shorter path, then there is a cycle.
             */
            for edge in graph.directedEdges {
                let u = edge.src
                let v = edge.dest
                // Update the current solution if there is a shorter one.
                if (distances[u] != Int.max && distances[u]! + edge.weight < distances[v]!) {
                    // Graph contains negative weight cycle
                    return (true, [])
                }
            }
            return (false, distances.sorted(by: { $0.key.val < $1.key.val }).map { $0.value })
        }
    }
    /**
     Floyd Warshall
     Reference: https://www.geeksforgeeks.org/floyd-warshall-algorithm-dp-16/
     */
    class FloydWarshall {
        // Incomplete
    }
}
