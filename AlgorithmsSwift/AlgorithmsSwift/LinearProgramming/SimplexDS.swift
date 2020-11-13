//
//  SimplexDataStructures.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/11/20.
//

/**
 Data structures used to calculate simplex.
 Reference: https://github.com/VladimirDinic/WDSimplexMethod
 */
enum Target {
    case min
    case max
}

enum Relation {
    case greaterOrEqual
    case equal
    case lessOrEqual
}

enum ResultType {
    case unbounded
    case infeasible
    case optimum
}

struct SimplexEquation {
    var equationNumbers = [SimplexValue]()
    var helpEquationNumbers = [SimplexValue]()
    var equationSolution: SimplexValue?
    var equality: Relation?
    
    init(equationNumbers: [Double], equationSolution: Double? = nil, _ equality: Relation? = nil) {
        self.equality = equality
        for singleNumber in equationNumbers {
            self.equationNumbers.append(SimplexValue(realValue: singleNumber))
        }
        self.equationSolution = SimplexValue(realValue: equationSolution ?? 0)
    }
}

struct SimplexVector {
    var vectorNumbers = [SimplexValue]()
    
    static func * ( left: SimplexVector, right: SimplexVector) -> SimplexValue {
        if left.vectorNumbers.count == right.vectorNumbers.count {
            var product = SimplexValue()
            for i in 0...left.vectorNumbers.count - 1 {
                product += left.vectorNumbers[i] * right.vectorNumbers[i]
            }
            return product
        }
        return SimplexValue()
    }
}

struct SimplexMatrix {
    var vectors = [SimplexVector]()
    
    func transposeMatrix() -> SimplexMatrix {
        var transposedMatrix = SimplexMatrix()
        for i in 0...self.vectors.count - 1 {
            var singleVector = SimplexVector()
            for j in 0...self.vectors.count - 1 {
                singleVector.vectorNumbers.append(self.vectors[j].vectorNumbers[i])
            }
            transposedMatrix.vectors.append(singleVector)
        }
        return transposedMatrix
    }
    
    func inverseMatrix() -> SimplexMatrix {
        let determinant = self.calculateDeterminant()
        var inverseMatrix = self.calculateAdjointMatrix()
        for i in 0...inverseMatrix.vectors.count - 1 {
            for j in 0...inverseMatrix.vectors[i].vectorNumbers.count - 1 {
                inverseMatrix.vectors[i].vectorNumbers[j] /= determinant
            }
        }
        return inverseMatrix
    }
    
    func calculateDeterminant() -> Double {
        let matrixSize = self.vectors.count
        switch matrixSize {
        case 0: return 0
        case 1: return self.vectors[0].vectorNumbers[0].realValue
        case 2: return (self.vectors[0].vectorNumbers[0] * self.vectors[1].vectorNumbers[1] - self.vectors[0].vectorNumbers[1] * self.vectors[1].vectorNumbers[0]).realValue
        default:
            var determinant = 0.0
            for i in 0...matrixSize - 1 {
                var subMatrix = self
                let firstVector = subMatrix.vectors.remove(at: 0)
                
                for j in 0...matrixSize - 2 {
                    subMatrix.vectors[j].vectorNumbers.remove(at: i)
                }
                determinant += ((2+i) % 2 == 0 ? 1.0 : -1.0) * firstVector.vectorNumbers[i].realValue * subMatrix.calculateDeterminant()
            }
            return determinant
        }
    }
    
    func calculateAdjointMatrix() -> SimplexMatrix {
        var adjointMatrix = self
        
        for i in 0...vectors.count - 1 {
            for j in 0...vectors.count - 1 {
                var subMatrix = self
                subMatrix.vectors.remove(at: i)
                for k in 0...subMatrix.vectors.count - 1 {
                    subMatrix.vectors[k].vectorNumbers.remove(at: j)
                }
                let subMatrixDeterminant = subMatrix.calculateDeterminant()
                adjointMatrix.vectors[j].vectorNumbers[i] = SimplexValue(realValue: ((2 + i + j) % 2 == 0 ? 1 : -1) * subMatrixDeterminant, mValue: 0)
            }
        }
        return adjointMatrix
    }
    
    static func *(left: SimplexMatrix, right: SimplexVector) -> SimplexVector {
        var product = SimplexVector()
        for i in 0...left.vectors.count - 1 {
            var x0value = SimplexValue()
            for j in 0...left.vectors[i].vectorNumbers.count - 1 {
                x0value += left.vectors[i].vectorNumbers[j] * right.vectorNumbers[j]
            }
            product.vectorNumbers.append(x0value)
        }
        return product
    }
}
