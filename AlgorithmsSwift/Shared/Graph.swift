//
//  Graph.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/25/20.
//

class Graph {
    var isDirected = true
    // The adjacencyList does not have weight information stored.
    open var adjacencyLists: [Vertex : Set<Edge>]
    /**
     Returns all the undirected edges if the graph is undirected.
     For example, edges [1, 0] and [0, 1] are counted once and output as either [1, 0] or [0, 1].
     */
    var undirectedEdges: Set<Edge> {
        guard !self.isDirected else { return [] }
        
        var edges = Set<Edge>()
        for vertex in self.adjacencyLists.keys {
            for edge in self.adjacencyLists[vertex]! {
                edges.insert(edge)
                // Remove the counterpart in the adjacencyLists.
                let reversed = Edge(edge.dest, edge.src, edge.weight)
                adjacencyLists[edge.dest]!.remove(reversed)
            }
        }
        return edges
    }
    /**
     Returns all directed edges if the graph is directed.
     */
    var directedEdges: Set<Edge> {
        guard self.isDirected else { return [] }
        
        var edges = Set<Edge>()
        for vertex in self.adjacencyLists.keys {
            for edge in self.adjacencyLists[vertex]! {
                edges.insert(edge)
            }
        }
        return edges
    }
    /**
     Instantiation.
     
     - Parameter isDirected: Determine if the graph is directed or undirected.
     */
    public init(isDirected: Bool) {
        self.isDirected = isDirected
        adjacencyLists = [Vertex : Set<Edge>]()
    }
    /**
     Add edge to the graph.
     
     - Parameter from:      The source/start of the edge.
     - Parameter to:        The destination/end of the edge.
     - Parameter weight:    The weight of the edge.
     */
    public func addEdge(from: Int, to: Int, weight: Int = 0) {
        let vertex1 = Vertex(from)
        let vertex2 = Vertex(to)
        let edge = Edge(vertex1, vertex2, weight)
        self.adjacencyLists[vertex1, default: []].insert(edge)
        
        // Create a list for the other vertex so it appears in graph.
        if self.adjacencyLists[vertex2] == nil {
            self.adjacencyLists[vertex2] = Set<Edge>()
        }
        
        if !self.isDirected {
            let otherEdge = Edge(vertex2, vertex1, weight)
            self.adjacencyLists[vertex2]!.insert(otherEdge)
        }
    }
    /**
     Reverse a directed graph by reverse direction of all edges in the graph.
     
     - Returns: A reversed graph of self.
     */
    public func getReversedGraph() -> Graph {
        guard self.isDirected else { fatalError("Graph is reversible only when it is directed.") }
        let reversedGraph = Graph(isDirected: true)
        for vertex in self.adjacencyLists.keys {
            if let edges = self.adjacencyLists[vertex] {
                for edge in edges {
                    if reversedGraph.adjacencyLists[edge.dest] == nil {
                        reversedGraph.adjacencyLists[edge.dest] = Set<Edge>()
                    }
                    let reversed = Edge(edge.dest, edge.src, edge.weight)
                    reversedGraph.adjacencyLists[edge.dest]!.insert(reversed)
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
    public func calculateInDegreeOfVertices() -> [Vertex : Int] {
        guard self.isDirected else { fatalError("Only calculates in degree in directed graph.") }
        // Set the initial in degree of every vertex to be 0.
        var inDegrees = [Vertex: Int]()
        for vertex in self.adjacencyLists.keys {
            inDegrees[vertex] = 0
        }
        // Calculate the in degree of each vertex in the graph.
        for vertex in self.adjacencyLists.keys {
            if let edges = self.adjacencyLists[vertex] {
                for edge in edges {
                    inDegrees[edge.dest, default: 0] += 1
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
        guard self.isDirected else { fatalError("Source vertices can only be found in directed graph.") }
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
        guard self.isDirected else { fatalError("Sink vertices can only be found in directed graph.") }
        // It might not be as easy to find sink vertices in the original graph. However, we can find sink vertices by using
        // the same algorithm on a reversed graph. A source vertex in a reversed graph is a sink vertex in the original one.
        let reversedGraph = self.getReversedGraph()
        return reversedGraph.getSourceVertices()
    }
    /**
     Utility function to format a key for the weight dicionary.
     
     - Parameter src:   The source vertex of the edge.
     - Parameter dest:  The destination vertex of the edge.
     
     - Returns: A string in the format of "src.val, dest.val".
     */
    public static func getKey(_ src: Vertex, _ dest: Vertex) -> String {
        return "\(src.val),\(dest.val)"
    }
    /**
     Utility function to build weight dictionary for quick reference.
     
     - Parameter graph: A residual graph of the original input graph.
     
     - Returns: A dicionary with the key in a string form of "src.val, dest.val" and the value is the weight of the edge.
     */
    public func buildtWeightDictionary() -> [String : Int] {
        var dict = [String : Int]()
        for vertex in self.adjacencyLists.keys {
            if let edges = self.adjacencyLists[vertex] {
                for edge in edges {
                    dict[Graph.getKey(edge.src, edge.dest)] = edge.weight
                }
            }
        }
        return dict
    }
    /**
     Build a graph based on the weight dictionary.
     
     - Parameter weightDict: A weight dictionary in the form of ["src.val, dest.val" : weight].
     
     - Returns: A graph in its normal form.
     */
    public static func buildGraphFromWeightDictionary(_ weightDict: [String : Int]) -> Graph {
        let graph = Graph(isDirected: true)
        for key in weightDict.keys {
            let keyArr = key.components(separatedBy: ",")
            let source = Int(keyArr[0])!
            let destination = Int(keyArr[1])!
            let weight = weightDict[key]!
            graph.addEdge(from: source, to: destination, weight: weight)
        }
        return graph
    }
}

class Vertex: Hashable {
    var val: Int
    
    init(_ val: Int) {
        self.val = val
    }
    
    static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.val == rhs.val
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.val)
    }
}

struct Edge: Hashable {
    var src: Vertex
    var dest: Vertex
    var weight: Int
    
    init(_ src: Vertex, _ dest: Vertex, _ weight: Int) {
        self.src = src
        self.dest = dest
        self.weight = weight
    }
    
    static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.src == rhs.src && lhs.dest == rhs.dest && lhs.weight == rhs.weight
    }
}
