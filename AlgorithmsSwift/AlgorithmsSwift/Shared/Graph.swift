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
    
    public static func createDefaultGraph(withNegativeEdge: Bool) -> Graph {
        let graph = Graph()
        graph.addEdge(0, 1, withNegativeEdge ? -1 : 1)  // add edge 0-1
        graph.addEdge(0, 2, 4);                         // add edge 0-2
        graph.addEdge(2, 6, 1);                         // add edge 2-6
        graph.addEdge(1, 3, 2);                         // add edge 1-3
        graph.addEdge(3, 1, 1);                         // add edge 3-1
        graph.addEdge(4, 3, withNegativeEdge ? -3 : 3); // add edge 4-3
        graph.addEdge(4, 5, 1);                         // add edge 4-5
        return graph
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
