//
//  LP3.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/12/20.
//

class LP3 {
    /**
     Determine if the maximize/minimize equation with given contraints is feasible. It is unbounded
     if there is no feasible solution.
     
     - Parameter mainEquation:  The main equation to find maximum/minimum values.
     - Parameter constraints:   Constraint equations to be considered when finding optimal solution.
     - Parameter valueTarget:   Determine the eqation should find maximum or minimum value.
     */
    func findEquationResultType(mainEquation: SimplexEquation, constraints: [SimplexEquation], valueTarget: Target) -> ResultType {
        let simplex = LP1.SimplexMethod(mainEquation: mainEquation, constraints: constraints, valueTarget: valueTarget)
        simplex.iterate()
        return simplex.resultType
    }
}
