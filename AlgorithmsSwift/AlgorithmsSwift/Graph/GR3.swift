//
//  GR3.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/28/20.
//

class GR3 {
    /**
     Union-find is used to detect if there is a cycle existing in a undirected graph.
     
     - Parameter graph: An undirected graph.
     
     - Returns: A boolean indicates if the cycle exists in the graph.
     */
    func isCycleExisting(_ graph: Graph) -> Bool {
        var parents = [Vertex : Vertex]()
        for edge in graph.undirectedEdges {
            let sourceParent = find(parents, edge.src)
            let destParent = find(parents, edge.dest)
            if sourceParent == destParent {
                return true
            }
            union(&parents, sourceParent, destParent)
        }
        
        return false
    }
    /**
     Utility function used to find the subset that has the given vertex.
     
     - Parameter parents:   A dictionary that maps parents and children vertices in the form of [child vertext : parent vertex].
     - Parameter vertex:    The vertex to search in parents.
     
     - Returns: The parent vertex of the given vertex.
     */
    private func find(_ parents: [Vertex : Vertex], _ vertex: Vertex) -> Vertex {
        if parents[vertex] == nil {
            return vertex
        } else {
            return find(parents, parents[vertex]!)
        }
    }
    /**
     Utility function used to union two vertices.
     
     - Parameter parents:   A dictionary that maps parents and children vertices.
     - Parameter vertex1:   The first vertex to be merged.
     - Parameter vertex2:   The second vertex that merges the first one.
     */
    private func union(_ parents: inout [Vertex : Vertex], _ vertex1: Vertex, _ vertex2: Vertex) {
        let parent1 = find(parents, vertex1)
        let parent2 = find(parents, vertex2)
        parents[parent2] = parent1
    }
    /**
     Miniumum Spinning Tree (MST) problem.
     */
    
}
