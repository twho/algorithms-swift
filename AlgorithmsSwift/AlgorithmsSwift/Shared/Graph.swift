//
//  Graph.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/25/20.
//

class Graph {
    // The adjacencyList does not have weight information stored.
    var adjacencyLists: [Vertex : Set<Vertex>]
    
    public init() {
        adjacencyLists = [Vertex : Set<Vertex>]()
    }
    
    public func addEdge(from val1: Int, to val2: Int) {
        let vertex1 = Vertex(val1)
        let vertex2 = Vertex(val2)
        
        if self.adjacencyLists[vertex1] == nil {
            self.adjacencyLists[vertex1] = Set<Vertex>()
        }
        
        if !self.adjacencyLists[vertex1]!.contains(vertex2) {
            self.adjacencyLists[vertex1]!.insert(vertex2)
        }
    }
    /**
     Calculate the in degree of a vertex. The number of vertices pointing to the vertex is called in-degree of the vertex, while
     the number of vertices the vertex is pointing to is called out-degree of the vertex.
     
     - Returns: A dictionary with Vertex as keys and the in degree of the Vertex as values.
     */
    public func calculateInDegreeOfVertices() -> [Vertex : Int] {
        var inDegrees = [Vertex: Int]()

        // Set the initial in degree of every vertex to be 0.
        for vertex in self.adjacencyLists.keys {
            inDegrees[vertex] = 0
        }

        // Calculate the in degree of each vertex in the graph.
        for vertex in self.adjacencyLists.keys {
            if let adjacencyList = self.adjacencyLists[vertex] {
                for otherVertex in adjacencyList {
                    inDegrees[otherVertex] = (inDegrees[otherVertex] ?? 0) + 1
                }
            }
        }
        
        
        return inDegrees
      }
}

struct Vertex: Hashable {
    var val: Int
    
    init(_ val: Int) {
        self.val = val
    }
    
    static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.val == rhs.val
    }
}
