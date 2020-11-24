//
//  LP4.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/12/20.
//

class LP4 {
    /**
     The content in this lecture is another example of SAT problem - Max SAT problem. In the previous graph lecutres,
     2-SAT and 3-SAT problems were discussed. The major difference between those and Max SAT is that those problems has
     certain answers while Max SAT problem only has optimal answers. We need to keep iterating through the equations in
     order to approach the best answer. Real world examples that Max SAT can apply to are:
         1. Find a shortest path/plan/execution/...to a goal state
         2. Find a smallest explanation
         3. Find a least resource-consuming schedule
         4. Find a most probable explanation (MAP)
     
     Reference: https://www.cs.helsinki.fi/group/coreo/aaai16-tutorial/aaai16-maxsat-tutorial.pdf
     Course ref: https://gt-algorithms.com/lp-approx/
     P.S. I haven't done enough research on this algorithm, please feel free to contribute.
     */
    func calculateMaxSAT(_ variable: Int, _ clauses: Int, clauseLeft: [Int], clauseRigt: [Int]) -> Int {
        // Max SAT solvers
        // 1. Branch-and-bound
        // 2. Iterative, model-based
        // 3. Integer Linear Programming (ILP)
        return 0
    }
}
