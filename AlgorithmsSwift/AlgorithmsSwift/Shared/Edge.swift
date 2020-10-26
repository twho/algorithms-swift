//
//  Edge.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/25/20.
//

struct Edge: Hashable {
    var src: Vertex
    var dest: Vertex
    var weight: Int
    
    init() {
        self.src = Vertex(0)
        self.dest = Vertex(0)
        self.weight = 0
    }
    
    init(_ vertex1: Vertex, _ vertex2: Vertex, _ weight: Int = 0) {
        self.src = vertex1
        self.dest = vertex2
        self.weight = weight
    }
    
    static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.src == rhs.src && lhs.dest == rhs.dest && lhs.weight == rhs.weight
    }
}
