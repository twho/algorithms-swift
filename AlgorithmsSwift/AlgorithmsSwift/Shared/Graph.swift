//
//  Graph.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/25/20.
//

class Graph {
    var vertices: [Vertex]
    var edges: Set<Edge>
    
    public init() {
        vertices = [Vertex]()
        edges = Set<Edge>()
    }
    
    public func addEdge(_ val1: Int, _ val2: Int, _ weight: Int) {
        let vertex1 = Vertex(val1)
        if !self.vertices.contains(vertex1) {
            self.vertices.append(vertex1)
        }
        
        let vertex2 = Vertex(val2)
        if !self.vertices.contains(vertex2) {
            self.vertices.append(vertex2)
        }
        
        let edge = Edge(vertex1, vertex2, weight)
        if !self.edges.contains(edge) {
            self.edges.insert(edge)
        }
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
