//
//  Graph.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/25/20.
//

class Graph {
    private var isDirected = true
    // The adjacencyList does not have weight information stored.
    var adjacencyLists: [Vertex : Set<Vertex>]
    
    public init(isDirected: Bool = true) {
        self.isDirected = isDirected
        adjacencyLists = [Vertex : Set<Vertex>]()
    }
    
    public func addEdge(from val1: Int, to val2: Int) {
        let vertex1 = Vertex(val1)
        let vertex2 = Vertex(val2)
        
        if self.adjacencyLists[vertex1] == nil {
            self.adjacencyLists[vertex1] = Set<Vertex>()
        }
        self.adjacencyLists[vertex1]!.insert(vertex2)
        
        if !self.isDirected {
            if self.adjacencyLists[vertex2] == nil {
                self.adjacencyLists[vertex2] = Set<Vertex>()
            }
            self.adjacencyLists[vertex2]!.insert(vertex1)
        }
    }
    /**
     Reverse a directed graph by reverse direction of all edges in the graph.
     
     - Returns: A reversed graph of self.
     */
    public func getReversedGraph() -> Graph {
        let reversedGraph = Graph()
        for vertex in self.adjacencyLists.keys {
            if let adjacencyList = self.adjacencyLists[vertex] {
                for otherVertex in adjacencyList {
                    if reversedGraph.adjacencyLists[otherVertex] == nil {
                        reversedGraph.adjacencyLists[otherVertex] = Set<Vertex>()
                    }
                    reversedGraph.adjacencyLists[otherVertex]!.insert(vertex)
                }
            }
        }
        return reversedGraph
    }
    /**
     Calculate the in degree of a vertex. The number of vertices pointing to the vertex is called in-degree of the vertex, while
     the number of vertices the vertex is pointing to is called out-degree of the vertex.
     
     - Returns: A dictionary with Vertex as keys and the in degree of the Vertex as values.
     */
    private func calculateInDegreeOfVertices() -> [Vertex : Int] {
        // Set the initial in degree of every vertex to be 0.
        var inDegrees = [Vertex: Int]()
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
    /**
     Find the source vertices in the graph. A source vertices are the ones do not have any incoming edges. In terms of
     in/outdegree, source vertices have zero indegree.
     
     - Returns: An array of vertices that are categorized as source vertices.
     */
    public func getSourceVertices() -> [Vertex] {
        let sourceVertices = self.calculateInDegreeOfVertices().filter({ (_, indegree) -> Bool in
            return indegree == 0
        }).map { (vertex, _) -> Vertex in
            return vertex
        }
        return sourceVertices
    }
    /**
     Find the sink vertices in the graph. A sink vertices are the ones do not have any outgoing edges. In terms of
     in/outdegree, source vertices have zero outdegree.
     
     - Returns: An array of vertices that are categorized as sink vertices.
     */
    public func getSinkVertices() -> [Vertex] {
        // It might not be as easy to find sink vertices in the original graph. However, we can find sink vertices by using
        // the same algorithm on a reversed graph. A source vertex in a reversed graph is a sink vertex in the original one.
        let reversedGraph = self.getReversedGraph()
        return reversedGraph.getSourceVertices()
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
