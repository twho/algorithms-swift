//
//  GR2.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 10/26/20.
//

class GR2 {
    /**
     Function used to solve 2-Satisfiability (2-SAT) Problem. Determine if the given formula is satisfiable if the Boolean variables can be assigned values
     such that the formula turns out to be true. Otherwise it is unsatisfiable. 2-SAT is a restriction of the SAT problemin. In 2-SAT every clause has exactly
     two literals. for example: (x ∨ ¬y) ∧ (¬x ∨ y) ∧ (¬x ∨ ¬y), where ¬ is an inverse, ∨ is OR and ∧ is AND.
     
     Note that If there is an edge x -> y, then there also is an edge ¬y -> ¬x. Besides, if x is reachable from ¬x, and ¬x is reachable from x, then the problem has
     no solution. In order to find a solution, it is necessary that for any variable x the vertices x and ¬x are in different strongly connected components (SCCs) of
     the strong connection of the implication graph. Therefore, the runtime is O(V+E). For details: https://cp-algorithms.com/graph/2SAT.html
     
     - Returns: A boolean indicates if the formula is satisfiable.
     */
    func is2Satisfiable(_ variable: Int, _ clauses: Int, clauseLeft: [Int], clauseRigt: [Int]) -> Bool {
        let graph = Graph()
        var idx = 0
        while idx < clauseLeft.count && idx < clauseRigt.count {
            graph.addEdge(from: clauseLeft[idx], to: clauseRigt[idx])
            graph.addEdge(from: -clauseRigt[idx], to: -clauseLeft[idx])
            idx += 1
        }
        // Finding SCC is implemented in GR1.
        let gr1 = GR1()
        let SCCs = gr1.findSCCsByDFS(graph)
        for i in 1...variable {
            for SCC in SCCs {
                if SCC.contains(i) && SCC.contains(-i) {
                    return false
                }
            }
        }
        return true
    }
}
