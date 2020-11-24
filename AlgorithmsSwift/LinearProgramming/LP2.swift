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
        simplex.iterate()
        return Int((simplex.solution?.optimumValue)!)
    }
}
