//
//  LP2.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/11/20.
//

class LP2 {
    
    func findOptimumIntegerValue(mainEquation: SimplexEquation, constraintEquations: [SimplexEquation], valueTarget: Target) -> Int {
        let simplex = LP1.SimplexMethod(mainEquation: mainEquation, constraintEquations: constraintEquations, valueTarget: valueTarget)
        self.calculateWhileDontFindOptimum(simplex)
        return Int((simplex.solution?.optimumSolution.realValue)!)
    }
    
    func calculateWhileDontFindOptimum(_ simplex: LP1.SimplexMethod) {
        simplex.nextIteration()
        while let solution = simplex.solution, !solution.solutionFound {
            simplex.nextIteration()
        }
    }
}
