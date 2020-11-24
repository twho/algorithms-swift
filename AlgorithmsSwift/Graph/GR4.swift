//
//  GR4.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/29/20.
//

class GR4 {
    /**
     PageRank (PR) is an algorithm used by Google to rank their search engine results. PR works by counting the number and quality of
     links to a page to estimate how important the website is. For example, page A has 3 incoming links, page B has 2 outgoing links,
     page C has 1 outgoing link, and page D has 3 outgoing links. In such case, the PageRank of A can be calculated by
     Page(A) = Page(B) / 2 + Page(C) / 1 + Page(D) / 3. Besides, the below function applies damping factor = 0.85 (generally used).
     
     - Parameter webGraph: The web graph used to calculate PageRank.
     
     - Returns: A set of web pages.
     */
    func performPageRank(_ webGraph: WebGraph) -> [Int] {
        guard let webAdjacencyLists = webGraph.adjacencyLists as? [Webpage : Set<Edge>] else {
            print("No valid adjacency list is found in web graph.")
            return []
        }
        // Set initial values
        let webCount = Double(webAdjacencyLists.keys.count)
        for webpage in webAdjacencyLists.keys {
            webpage.rank = 1/webCount
        }
        // Calculate PageRank
        let damping = 0.85
        for _ in 0..<100 {
            for webpage in webAdjacencyLists.keys {
                var inbound: Double = 0
                for otherWebpage in webAdjacencyLists.keys {
                    let edgeCount = Double(webAdjacencyLists[otherWebpage]!.count)
                    for edge in webAdjacencyLists[otherWebpage]! {
                        if(edge.dest == webpage){
                            inbound += otherWebpage.rank / edgeCount
                        }
                    }
                }
                webpage.rank =  (1 - damping) / webCount + damping * inbound
            }
        }
        return webAdjacencyLists.keys.sorted { $0.rank > $1.rank }.map { (webpage) -> Int in
            return webpage.val
        }
    }
}

class Webpage: Vertex {
    var rank: Double = 0
    
    static func == (lhs: Webpage, rhs: Webpage) -> Bool {
        return lhs.val == rhs.val && lhs.rank == rhs.rank
    }
}

class WebGraph: Graph {
    // The adjacencyList used to override the adjacencyLists in Graph class.
    private var _adjacencyLists: [Webpage : Set<Edge>]
    override var adjacencyLists: [Vertex : Set<Edge>] {
        get {
            return _adjacencyLists
        }
        set {
            guard let newLists = newValue as? [Webpage : Set<Edge>] else {
                fatalError("Adjacency list has to be in type of [Webpage : Set<Edge>].")
            }
            _adjacencyLists = newLists
        }
    }
    /**
     Initializer. Only directed graph is allowed in web graph.
     */
    public convenience init() {
        self.init(isDirected: true)
    }
    
    private override init(isDirected: Bool = true) {
        _adjacencyLists = [Webpage : Set<Edge>]()
        super.init(isDirected: isDirected)
    }
    /**
     Add edge to the graph.
     
     - Parameter from:      The source/start of the edge.
     - Parameter to:        The destination/end of the edge.
     - Parameter weight:    The weight of the edge.
     */
    override func addEdge(from: Int, to: Int, weight: Int = 0) {
        let web1 = Webpage(from)
        let web2 = Webpage(to)
        let edge = Edge(web1, web2, weight)
        
        if _adjacencyLists[web1] == nil {
            _adjacencyLists[web1] = Set<Edge>()
        }
        _adjacencyLists[web1]!.insert(edge)
        
        if _adjacencyLists[web2] == nil {
            _adjacencyLists[web2] = Set<Edge>()
        }
    }
}
