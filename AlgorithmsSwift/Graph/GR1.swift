//
//  GR1.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/25/20.
//

class GR1 {
    /**
     The function traverses through a directed graph using DFS method. Runtime: O(V + E), where V represents vertices and E represents edges.
     
     - Parameter graph: A directed graph.
     
     - Returns: An integer array of DFS traverse result.
     */
    func dfs(_ graph: Graph) -> [Int] {
        var visited = Set<Vertex>()
        var output = [Vertex]()
        
        for vertex in graph.adjacencyLists.keys.sorted(by: { $0.val < $1.val }) {
            if !visited.contains(vertex) {
                dfsHelper(vertex, graph.adjacencyLists, &visited, &output)
            }
        }
        
        return output.map { (vertex) -> Int in
            return vertex.val
        }
    }
    /**
     The function is used as the recursive method in DFS.
     
     - Parameter vertex:            The vertex to explore its relevant edges.
     - Parameter adjacencyLists:    The adjacency lists used in the graph.
     - Parameter visited:           The visisted vertices in the current traverse.
     - Parameter output:            The pointer to the result of DFS traverse.
     */
    private func dfsHelper(_ vertex: Vertex, _ adjacencyLists: [Vertex : Set<Edge>], _ visited: inout Set<Vertex>, _ output: inout [Vertex]) {
        visited.insert(vertex)
        if let adjacencyList = adjacencyLists[vertex] {
            for edge in adjacencyList {
                if !visited.contains(edge.dest) {
                    dfsHelper(edge.dest, adjacencyLists, &visited, &output)
                }
            }
        }
        output.append(vertex)
    }
    /**
     The function traverses through a directed graph using BFS method. Runtime: O(V + E), where V represents vertices and E represents edges.
     
     - Parameter graph: A directed graph.
     
     - Returns: An integer array of BFS traverse result.
     */
    func bfs(_ graph: Graph) -> [Int] {
        var visited = Set<Vertex>()
        var queue = [Vertex]()
        queue.append(graph.adjacencyLists.keys.sorted { $0.val < $1.val }[0])
        
        var output = queue
        while queue.count > 0 {
            let vertex = queue.removeFirst()
            if let list = graph.adjacencyLists[vertex] {
                // This sorting is not required in BFS, it is done for the test specifically
                let edges = Array(list).sorted { $0.dest.val < $1.dest.val }
                for edge in edges {
                    let otherVertex = edge.dest
                    if !visited.contains(otherVertex) {
                        queue.append(otherVertex)
                        visited.insert(otherVertex)
                        output.append(otherVertex)
                    }
                }
            }
        }
        
        return output.map { (vertex) -> Int in
            return vertex.val
        }
    }
    /**
     Search the graph from both sides. It is useful while searching a path between known start and end points.
     
     - Parameter graph: An undirected graph.
     
     - Returns: The distance of shortest path from start to end.
     */
    func bidirectionalBFS(_ graph: Graph, _ start: Int, _ end: Int) -> Int {
        let startV = Vertex(start)
        let endV = Vertex(end)
        // Set up inital state
        // Record visited vertices from the start point
        var sVisited = Set([startV])
        // Record visited vertices from the end point
        var eVisited = Set([endV])
        // Use two queues
        var begins = [startV]
        var ends = [endV]
        var distance = 0
        while !begins.isEmpty, !ends.isEmpty {
            let tempBegins = begins
            begins = []
            for begin in tempBegins {
                if eVisited.contains(begin) {
                    return distance * 2
                }
                if let startEdges = graph.adjacencyLists[begin] {
                    for startEdge in startEdges {
                        if !sVisited.contains(startEdge.dest) {
                            sVisited.insert(startEdge.dest)
                            begins.append(startEdge.dest)
                        }
                        if eVisited.contains(startEdge.dest) {
                            return distance * 2 + 1
                        }
                    }
                }
            }
            let tempEnds = ends
            ends = []
            for end in tempEnds {
                if let endEdges = graph.adjacencyLists[end] {
                    for endEdge in endEdges {
                        if !eVisited.contains(endEdge.dest) {
                            eVisited.insert(endEdge.dest)
                            ends.append(endEdge.dest)
                        }
                        if sVisited.contains(endEdge.dest) {
                            return distance * 2 + 2
                        }
                    }
                }
            }
            distance += 1
        }
        return -1
    }
    /**
     Find strongly connected componenets by DFS. SCC is defined as a group of components in a directed graph that have edges allow them to reach each other.
     It takes two rounds of DFS to find SCCs. Runtime: O(V + E)
     
     - Parameter graph: A directed graph.
     
     - Returns: A 2D set. Each element in the set represents a SCC, which is a group of components in the graph.
     */
    func findSCCsByDFS(_ graph: Graph) -> Set<Set<Int>> {
        // Perform a normal DFS.
        var visited = Set<Vertex>()
        var stack = [Vertex]()
        for vertex in graph.adjacencyLists.keys {
            if !visited.contains(vertex) {
                dfsHelper(vertex, graph.adjacencyLists, &visited, &stack)
            }
        }
        // Reverse the graph to for 2nd round DFS.
        visited = Set<Vertex>()
        var output = Set<Set<Int>>()
        let reversedGraph = graph.getReversedGraph()
        while !stack.isEmpty {
            var SCC = [Vertex]()
            let vertex = stack.removeLast()
            if !visited.contains(vertex) {
                dfsHelper(vertex, reversedGraph.adjacencyLists, &visited, &SCC)
                let set = Set(SCC.map({ (vertex) -> Int in
                    vertex.val
                }))
                output.insert(set)
            }
        }
        return output
    }
    /**
     The function adapts topological sorting method and add a set to record current exploration.
     
     - Parameter graph: A directed graph.
     
     - Returns: A boolean indicates if the directed graph has a cycle.
     */
    func detectCycleInDirectedGraph(_ graph: Graph) -> Bool {
        var visited = Set<Vertex>()
        var exploration = Set<Vertex>()
        for vertex in graph.adjacencyLists.keys {
            if !visited.contains(vertex) {
                if cycleDetectionHelper(vertex, graph.adjacencyLists, &visited, &exploration) {
                    return true
                }
            }
        }
        return false
    }
    /**
     The function is used as a DFS recursive method.
     
     - Parameter vertex:        The vertex to explore its relevant edges.
     - Parameter adjacency:     The adjacency lists used in the graph.
     - Parameter visited:       The visisted vertices in the current traverse.
     - Parameter exploration:   The vertices in the current exploration, which will be removed after the current exploration is done.
     */
    private func cycleDetectionHelper(_ vertex: Vertex, _ adjacency: [Vertex : Set<Edge>], _ visited: inout Set<Vertex>, _ exploration: inout Set<Vertex>) -> Bool {
        if exploration.contains(vertex) {
            return true
        }
        visited.insert(vertex)
        exploration.insert(vertex)
        if let edges = adjacency[vertex] {
            for edge in edges {
                if !visited.contains(edge.dest) {
                    if cycleDetectionHelper(edge.dest, adjacency, &visited, &exploration) {
                        return true
                    }
                } else if edge.dest == vertex {
                    return true
                }
            }
        }
        exploration.remove(vertex)
        return false
    }
    // MARK: - Topological Sort
    /**
     Topological order using DFS method. In topological sort, the vertex used as the source of the edge
     must be printed before the destination of the edge. Note that a graph could have multiple topological output.
     In addition, a graph has to be a directed acyclic graph (DAG) in order to be sorted topologically. Runtime: O(V + E)
     
     - Parameter graph: A directed graph.
     
     - Returns: An integer array of topological sorting result.
     */
    func topologicalSortByDFS(_ graph: Graph) -> [Int] {
        var output = [Vertex]()
        var visited = Set<Vertex>()
        let sourceVertices = graph.getSourceVertices()
        
        for sourceVertex in sourceVertices {
            if !visited.contains(sourceVertex) {
                dfsHelper(sourceVertex, graph.adjacencyLists, &visited, &output)
            }
        }
        // The reverse order of DFS reflects topological sort. Use a stack during traversal.
        return output.reversed().map { (vertex) -> Int in
            return vertex.val
        }
    }
    /**
     Topological order using BFS method. In topological sort.
     
     - Parameter graph: A directed graph.
     
     - Returns: An integer array of topological sorting result.
     */
    func topologicalSortByBFS(_ graph: Graph) -> [Int] {
        var output = [Vertex]()
        var indegrees = graph.calculateInDegreeOfVertices()
        var queue = indegrees.keys.filter { indegrees[$0]! == 0 }
        var visited = Set<Vertex>()
        while !queue.isEmpty {
            let first = queue.removeFirst()
            output.append(first)
            visited.insert(first)
            if let edges = graph.adjacencyLists[first] {
                for edge in edges {
                    indegrees[edge.dest]! -= 1
                    if !visited.contains(edge.dest), indegrees[edge.dest]! == 0 {
                        queue.append(edge.dest)
                    }
                }
            }
        }
        // The reverse order of BFS reflects topological sort.
        return output.map { (vertex) -> Int in
            return vertex.val
        }
    }
}
