//
//  GR3.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/28/20.
//

class GR3 {
    /**
     Union-find is used to detect if there is a cycle existing in a undirected graph. Note that we cannot use union-find
     to detect cycles in a directed graphs since a directed graph cannot be represented using the disjoint-set. Since I
     apply union by rank and path compression to optimize the algorithm, the runtime is O(logN).
     
     - Parameter graph: An undirected graph.
     
     - Returns: A boolean indicates if the cycle exists in the graph.
     */
    func isCycleExisting(_ graph: Graph) -> Bool {
        guard !graph.isDirected else {
            fatalError("we cannot use union-find to detect cycles in a directed graphs")
        }
        
        var parents = [Vertex : Vertex]()
        var rank = [Vertex : Int]()
        for edge in graph.undirectedEdges {
            let sourceParent = find(&parents, &rank, edge.src)
            let destParent = find(&parents, &rank, edge.dest)
            if sourceParent == destParent {
                return true
            }
            union(&parents, &rank, sourceParent, destParent)
        }
        
        return false
    }
    /**
     Utility function used to union two vertices. Union by rank applied.
     
     - Parameter parents:   A dictionary that maps parents and children vertices.
     - Parameter rank:      The rank used by union by rank method.
     - Parameter vertex1:   The first vertex to be merged.
     - Parameter vertex2:   The second vertex that merges the first one.
     */
    private func union(_ parents: inout [Vertex : Vertex], _ rank: inout [Vertex : Int], _ vertex1: Vertex, _ vertex2: Vertex) {
        let parent1 = find(&parents, &rank, vertex1)
        let parent2 = find(&parents, &rank, vertex2)
        // After find(), each vertex should have rank value initializd/assigned.
        if rank[parent1]! > rank[parent2]! {
            parents[parent2] = parent1
        } else if rank[parent2]! > rank[parent1]! {
            parents[parent1] = parent2
        } else {
            parents[parent2] = parent1
            rank[parent1]! += 1
        }
    }
    /**
     Utility function used to find the subset that has the given vertex. Path compression applied.
     
     - Parameter parents:   A dictionary that maps parents and children vertices in the form of [child vertext : parent vertex].
     - Parameter rank:      The rank used by union by rank method.
     - Parameter vertex:    The vertex to search in parents.
     
     - Returns: The parent vertex of the given vertex.
     */
    private func find(_ parents: inout [Vertex : Vertex], _ rank: inout [Vertex : Int], _ vertex: Vertex) -> Vertex {
        if let parent = parents[vertex] {
            if parent != vertex {
                parents[vertex] = find(&parents, &rank, parent)
            }
            return parents[vertex]!
        } else {
            // Set the default value
            rank[vertex] = 0
            return vertex
        }
    }
    /**
     A graph is bipartite if we can split its set of vertices into two independent subsets A and B, such that every edge connects vertex from
     A to B or vice versa. If there is any edge connecting vertices internally in a subset, then the graph is not bipartite.
     
     - Parameter graph: An undirected graph.
     
     - Returns: A boolean indicates if the graph is bipartite.
     */
    func isBipartite(_ graph: Graph) -> Bool {
        guard !graph.isDirected else {
            fatalError("we cannot use union-find to determine bipartite if a graph is directed.")
        }
        
        var parents = [Vertex : Vertex]()
        var rank = [Vertex : Int]()
        for vertex in graph.adjacencyLists.keys {
            let list = Array(graph.adjacencyLists[vertex]!)
            for idx in 0..<list.count {
                let sourceParent = find(&parents, &rank, vertex)
                let destParent = find(&parents, &rank, list[idx].dest)
                if sourceParent == destParent {
                    return false
                }
                
                // All other vertices connected to the current should be unioned in the other subset.
                if idx > 0 {
                    union(&parents, &rank, list[idx - 1].dest, list[idx].dest)
                }
            }
        }
        
        return true
    }
    /**
     Function to solve Miniumum Spanning Tree (MST) problem. Given a connected and undirected graph, a spanning tree of that graph is a subgraph in a tree form
     that has (V – 1) edges, where V is the number of vertices. A graph can have multiple spanning trees. A MST for a weighted, connected and undirected graph
     is a spanning tree with weight less than or equal to all other spanning trees. Runtime: O(ELogE + ELogV), where O(ELogE) comes from sorting and O(ELogV)
     comes from union-find on each edge.
     
     - Parameter graph: An undirected graph.
     
     - Returns: An integer represents the total weight of minimum spanning tree.
     */
    func findMinimumSpanningTree(_ graph: Graph) -> Int {
        let edges = graph.undirectedEdges.sorted { $0.weight < $1.weight }
        var minWeight = 0
        var parents = [Vertex : Vertex]()
        var rank = [Vertex : Int]()
        var edgeCount = 0
        for edge in edges {
            if edgeCount == graph.adjacencyLists.keys.count - 1 {
                // Stop when edge count is equal to V - 1.
                break
            }
            let sourceParent = find(&parents, &rank, edge.src)
            let destParent = find(&parents, &rank, edge.dest)
            if sourceParent != destParent {
                union(&parents, &rank, sourceParent, destParent)
                edgeCount += 1
                minWeight += edge.weight
            }
        }
        return minWeight
    }
}
