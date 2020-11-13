//
//  LP2.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/11/20.
//

class LP2 {
    /**
     Find the optimal output from the given main quation and its contraints.
     
     - Parameter mainEquation:  The main equation to find maximum/minimum values.
     - Parameter constraints:   Constraint equations to be considered when finding optimal solution.
     - Parameter valueTarget:   Determine the eqation should find maximum or minimum value.
     */
    func findOptimumIntegerValue(mainEquation: SimplexEquation, constraints: [SimplexEquation], valueTarget: Target) -> Int {
        let simplex = LP1.SimplexMethod(mainEquation: mainEquation, constraints: constraints, valueTarget: valueTarget)
        self.iterate(simplex)
        return Int((simplex.solution?.optimumValue)!)
    }
    /**
     Iterate and generate updated Simplex tableau until the terminal condition is met.
     
     - Parameter simplex: The Simplex method object.
     */
    func iterate(_ simplex: LP1.SimplexMethod) {
        simplex.nextIteration()
        while let solution = simplex.solution, !solution.isSolutionFound {
            simplex.nextIteration()
        }
    }
    /**
     Determine if the maximize/minimize equation with given contraints is feasible. It is unbounded
     if there is no feasible solution.
     
     - Parameter mainEquation:  The main equation to find maximum/minimum values.
     - Parameter constraints:   Constraint equations to be considered when finding optimal solution.
     - Parameter valueTarget:   Determine the eqation should find maximum or minimum value.
     */
    func isEquationsUnbounded(mainEquation: SimplexEquation, constraints: [SimplexEquation], valueTarget: Target) -> Bool {
        return findOptimumIntegerValue(mainEquation: mainEquation, constraints: constraints, valueTarget: valueTarget) == -1
    }
}
