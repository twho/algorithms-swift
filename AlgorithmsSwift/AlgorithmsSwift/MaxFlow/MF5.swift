//
//  MF5.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/5/20.
//

class MF5 {
    let mf4 = MF4()
    /**
     Rather than transporting flow from a single source to a single sink, there may be a collection
     of supply nodes/vertices that need to be shipped to a collection of demand nodes/vertices.
     Each supply node/vertex is associated with the amount of product it wants to ship and each
     demand node is associated with the amount that it wants receive. The issue to be addressed becomes
     whether there is some way to get the products from the supplies to the demands, subject to the
     capacity constraints. This is a decision problem (or feasibility problem), meaning that it has
     a yes-no answer, as opposed to maximum flow, which is an optimization problem.
     
     Reference: https://github.com/SleekPanther/circulation-with-demands-network-flow
     
     - Parameter graph: An directed graph.
     
     - Returns: A boolean indicates if the graph has circulation and max feasible flow.
     */
    func circulationWithDemands(_ graph: Graph, _ vertexDemands: [Vertex: Int]) -> Bool {
        // Initial state variables
        var sumOfDemands = 0
        var sumOfSupplies = 0
        var maxFlow = 0
        var demandVertices = [Vertex]()
        var supplyVertices = [Vertex]()
        var mutableDemands = vertexDemands
        for vertex in vertexDemands.keys {
            let demand = vertexDemands[vertex]!
            if demand > 0 {
                demandVertices.append(vertex)
                sumOfDemands += demand
            } else if demand < 0 {
                supplyVertices.append(vertex)
                sumOfSupplies -= demand
            }
            // Do nothing if demand = 0 since vertex is not connected to source or sink.
        }
        // Graph and weights
        var graphWeightMap = graph.buildtWeightDictionary()
        var lowerBounds = [String : Int]()  // ["src, dest" : weight]
        var upperBounds = [String : Int]()  // ["src, dest" : weight]
        var lowerBoundsUpdatedSumOfDemands = 0
        var lowerBoundsUpdatedSumOfSupplies = 0
        // Flags
        var isDemandsMatchSupplies = sumOfSupplies == sumOfDemands
        var hasLowerBounds = false
        // Updating supplies and demands
        if isDemandsMatchSupplies {
            for vertex in graph.adjacencyLists.keys {
                let edges = graph.adjacencyLists[vertex]!
                for edge in edges {
                    let edgeKey = Graph.getKey(edge.src, edge.dest)
                    if let lower = lowerBounds[edgeKey], lower != 0 {
                        hasLowerBounds = true
                        let oldLowerBound = lower
                        if graphWeightMap[edgeKey] == nil {
                            graphWeightMap[edgeKey] = 0
                        }
                        graphWeightMap[edgeKey]! = upperBounds[edgeKey] ?? 0 - oldLowerBound
                        upperBounds[edgeKey] = graphWeightMap[edgeKey]!
                        lowerBounds[edgeKey] = 0
                        
                        // Update supplies/demands for source and destination of the edge.
                        if mutableDemands[edge.src]! > 0 {
                            mutableDemands[edge.src]! -= oldLowerBound
                        } else {
                            mutableDemands[edge.src]! += oldLowerBound
                        }
                        
                        if mutableDemands[edge.dest]! > 0 {
                            mutableDemands[edge.dest]! -= oldLowerBound
                        } else {
                            mutableDemands[edge.dest]! += oldLowerBound
                        }
                    }
                }
            }
            // Recalculate the sum of supplies/demands with updated bounds.
            if hasLowerBounds {
                lowerBoundsUpdatedSumOfDemands = 0
                lowerBoundsUpdatedSumOfSupplies = 0
                for vertex in graph.adjacencyLists.keys {
                    // Update supplies/demands for source and destination of the edge.
                    if mutableDemands[vertex]! > 0 {
                        lowerBoundsUpdatedSumOfDemands += mutableDemands[vertex]!
                    } else if mutableDemands[vertex]! < 0 {
                        lowerBoundsUpdatedSumOfSupplies -= mutableDemands[vertex]!
                    }
                    // Do nothing if demand = 0
                }
                if lowerBoundsUpdatedSumOfSupplies != lowerBoundsUpdatedSumOfDemands {
                    isDemandsMatchSupplies = false
                }
            }
            
            if isDemandsMatchSupplies {
                let updatedGraph = Graph.buildGraphFromWeightDictionary(graphWeightMap)
                // Add s and t, connect to supply/demand vertices.
                let unuseVal = graph.adjacencyLists.keys.map { $0.val }.max()! + 1
                let sourceVal = unuseVal
                let sinkVal = unuseVal + 1
                
                // Connect demand vertices to sink.
                for vertex in demandVertices {
                    updatedGraph.addEdge(from: vertex.val, to: sinkVal, weight: vertexDemands[vertex]!)
                }
                
                // Connect source vertex to supply vertices.
                for vertex in supplyVertices {
                    updatedGraph.addEdge(from: sourceVal, to: vertex.val, weight: -vertexDemands[vertex]!)
                }
                // Run Edmonds-Karp algorithm to find the max flow.
                maxFlow = mf4.maximumFlowByEdmondsKarp(updatedGraph, sourceVal, sinkVal).maxFlow
            }
        }
        // Determine if the graph has circulation.
        if(!isDemandsMatchSupplies){
            return false
        } else if hasLowerBounds {
            if maxFlow != lowerBoundsUpdatedSumOfSupplies || maxFlow != lowerBoundsUpdatedSumOfDemands {
                return false
            }
        } else if maxFlow != sumOfSupplies || maxFlow != sumOfDemands {
            return false
        }
        return true
    }
}
