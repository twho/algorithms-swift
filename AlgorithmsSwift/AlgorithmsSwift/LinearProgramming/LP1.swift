//
//  LP1.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/10/20.
//

class LP1 {
    /**
     Solve 3D linear programming example using Simplex algorithm.
     Reference: https://github.com/VladimirDinic/WDSimplexMethod
     */
    class SimplexMethod {
        private var iteration = 0
        private var z0 = SimplexValue()
        var valueTarget: Target
        var numberOfCorrections = 0
        var mainEquation: SimplexEquation
        var constraintEquations: [SimplexEquation]
        var xMatrix = SimplexMatrix()
        var zcValues = [SimplexValue]()
        var bVectorSpaceBaseIndex = [Int]()
        var xVectorSpaceBaseIndex = [Int]()
        var x0Vector = SimplexVector()
        var cVector: SimplexVector?
        var c0Vector = SimplexVector()
        var a0Vector: SimplexVector?
        var aVectors = [SimplexVector]()
        var bMatrix = SimplexMatrix()
        var solution: SimplexSolution?
        var extendedSystemOfEquationsSize = 0
        var systemOfEquationsSize = 0
        
        init(mainEquation: SimplexEquation, constraintEquations: [SimplexEquation], valueTarget: Target) {
            self.mainEquation = mainEquation
            self.constraintEquations = constraintEquations
            self.valueTarget = valueTarget
            self.generateVectors()
        }
        
        func nextIteration() {
            iteration += 1
            if iteration == 1 {
                generateBMatrix()
                bVectorSpaceBaseIndex.removeAll()
                for i in 0...self.constraintEquations.count - 1 {
                    bVectorSpaceBaseIndex.append(self.extendedSystemOfEquationsSize-self.constraintEquations.count+i+1)
                }
                if let cVector = self.cVector {
                    c0Vector = SimplexVector()
                    for singleIndex in bVectorSpaceBaseIndex {
                        c0Vector.vectorNumbers.append(cVector.vectorNumbers[singleIndex-1])
                    }
                }
                let bInverse = self.bMatrix.transposeMatrix().inverseMatrix()
                if let a0Vector = a0Vector {
                    x0Vector = bInverse * a0Vector
                }
                for i in 0...aVectors.count - 1 {
                    if !bVectorSpaceBaseIndex.contains(i + 1) {
                        xMatrix.vectors.append(bInverse.transposeMatrix() * aVectors[i])
                        xVectorSpaceBaseIndex.append(i + 1)
                    }
                }
            } else {
                for i in 0...bVectorSpaceBaseIndex.count - 1 {
                    if self.bVectorSpaceBaseIndex[i] == solution!.outVectorIndex {
                        self.bVectorSpaceBaseIndex[i] = solution!.inVectorIndex
                    }
                }
                generateBMatrix()
                for i in 0...xVectorSpaceBaseIndex.count - 1 {
                    if self.xVectorSpaceBaseIndex[i] == solution!.inVectorIndex
                    {
                        self.xVectorSpaceBaseIndex[i] = solution!.outVectorIndex
                    }
                }
                let bInverse = self.bMatrix.transposeMatrix().inverseMatrix()
                if let a0Vector = a0Vector {
                    x0Vector = bInverse * a0Vector
                }
                xMatrix.vectors.removeAll()
                for singleIndex in xVectorSpaceBaseIndex {
                    xMatrix.vectors.append(bInverse * aVectors[singleIndex - 1])
                }
                if let cVector = self.cVector {
                    c0Vector = SimplexVector()
                    for singleIndex in bVectorSpaceBaseIndex {
                        c0Vector.vectorNumbers.append(cVector.vectorNumbers[singleIndex - 1])
                    }
                }
            }
            
            z0 = SimplexValue()
            for i in 0...c0Vector.vectorNumbers.count - 1 {
                z0 += c0Vector.vectorNumbers[i] * x0Vector.vectorNumbers[i]
            }
            
            zcValues.removeAll()
            for xIndex in xVectorSpaceBaseIndex {
                let index = xVectorSpaceBaseIndex.firstIndex(of: xIndex)!
                zcValues.append(c0Vector * xMatrix.vectors[index] - (cVector?.vectorNumbers[xIndex-1])!)
            }
            
            self.solution = SimplexSolution(equationTarget: valueTarget, zcVector: SimplexVector(vectorNumbers: zcValues), bVectorIndexes: bVectorSpaceBaseIndex,
                                            xMatrix: xMatrix, x0Vector: x0Vector, xVectorIndexes: xVectorSpaceBaseIndex, optimumSolution: z0)
        }
        
        func generateVectors() {
            // Calculate the system of equations size.
            for i in 0...self.constraintEquations.count - 1 {
                systemOfEquationsSize = max(self.constraintEquations[i].equationNumbers.count, systemOfEquationsSize)
            }
            calculateExtendedSystemOfEquationsSize()
            generateCVector()
            generateAVectors()
            generateA0Vector()
        }
        
        func generateBMatrix() {
            if iteration <= 1 {
                for i in self.extendedSystemOfEquationsSize - self.constraintEquations.count...self.extendedSystemOfEquationsSize - 1 {
                    self.bMatrix.vectors.append(self.aVectors[i])
                }
            } else {
                self.bMatrix.vectors.removeAll()
                for singleBaseIndex in self.bVectorSpaceBaseIndex {
                    self.bMatrix.vectors.append(self.aVectors[singleBaseIndex-1])
                }
            }
        }
        
        func calculateSystemOfEquationsSize() {
            for i in 0...self.constraintEquations.count - 1 {
                systemOfEquationsSize = max(self.constraintEquations[i].equationNumbers.count, systemOfEquationsSize)
            }
        }
        
        func calculateExtendedSystemOfEquationsSize() {
            extendedSystemOfEquationsSize = systemOfEquationsSize + self.constraintEquations.count
            for singleEquation in self.constraintEquations {
                if singleEquation.equality == Relation.greaterOrEqual {
                    numberOfCorrections += 1
                    extendedSystemOfEquationsSize += 1
                }
            }
        }
        
        func generateCVector() {
            self.cVector = SimplexVector(vectorNumbers: self.mainEquation.equationNumbers)
            if (self.cVector != nil) {
                if self.numberOfCorrections > 0 {
                    for _ in 1...self.numberOfCorrections {
                        self.cVector?.vectorNumbers.append(SimplexValue())
                    }
                }
                for _ in self.systemOfEquationsSize...self.extendedSystemOfEquationsSize-1-self.numberOfCorrections {
                    self.cVector?.vectorNumbers.append(SimplexValue())
                }
                for i in self.systemOfEquationsSize+numberOfCorrections...self.extendedSystemOfEquationsSize - 1 {
                    let singleEquation = self.constraintEquations[i - (self.systemOfEquationsSize+numberOfCorrections)]
                    if singleEquation.equality != Relation.lessOrEqual {
                        self.cVector?.vectorNumbers[i] = self.valueTarget == .max ? SimplexValue(mValue: -1) : SimplexValue(mValue: 1)
                    }
                }
            }
        }
        
        func generateA0Vector() {
            self.a0Vector = SimplexVector()
            for singleEquation in self.constraintEquations {
                if let equationSolution = singleEquation.equationSolution {
                    self.a0Vector?.vectorNumbers.append(equationSolution)
                }
            }
        }
        
        func generateAVectors() {
            for _ in 1...systemOfEquationsSize {
                self.aVectors.append(SimplexVector())
            }
            for i in 0...self.constraintEquations.count - 1 {
                for j in 0...self.aVectors.count - 1 {
                    self.aVectors[j].vectorNumbers.append(self.constraintEquations[i].equationNumbers[j])
                }
            }
            for i in 0...self.constraintEquations.count - 1 {
                var vectorNumbers = [SimplexValue]()
                for _ in 0...self.constraintEquations.count - 1 {
                    vectorNumbers.append(SimplexValue())
                }
                let singleEquation = self.constraintEquations[i]
                if singleEquation.equality == Relation.greaterOrEqual {
                    vectorNumbers[i] = SimplexValue(realValue: -1, mValue: 0)
                    self.aVectors.append(SimplexVector(vectorNumbers: vectorNumbers))
                }
            }
            for i in 0...self.constraintEquations.count - 1 {
                var vectorNumbers = [SimplexValue]()
                for _ in 0...self.constraintEquations.count - 1 {
                    vectorNumbers.append(SimplexValue())
                }
                vectorNumbers[i] = SimplexValue(realValue: 1, mValue: 0)
                self.aVectors.append(SimplexVector(vectorNumbers: vectorNumbers))
            }
        }
    }
    
    class SimplexSolution {
        var target: Target
        var zcVector: SimplexVector
        var optimumSolution: SimplexValue
        var xVectorIndexes: [Int]
        var bVectorIndexes: [Int]
        var x0Vector: SimplexVector
        var xMatrix: SimplexMatrix
        var inVectorIndex = 0
        var outVectorIndex = 0
        var solutionFound = false
        
        init(equationTarget: Target, zcVector: SimplexVector, bVectorIndexes: [Int], xMatrix: SimplexMatrix, x0Vector: SimplexVector, xVectorIndexes: [Int], optimumSolution: SimplexValue) {
            self.target = equationTarget
            self.zcVector = zcVector
            self.xVectorIndexes = xVectorIndexes
            self.optimumSolution = optimumSolution
            self.bVectorIndexes = bVectorIndexes
            self.x0Vector = x0Vector
            self.xMatrix = xMatrix
            self.checkIfSolutionIsFound()
            if !solutionFound {
                self.calculateInVectorIndex()
                self.calculateOutVectorIndex()
            }
        }
        
        func checkIfSolutionIsFound() {
            solutionFound = true
            for singleValue in zcVector.vectorNumbers {
                switch target {
                case .max:
                    if singleValue.mValue < 0 || (singleValue.mValue == 0 && singleValue.realValue < 0) {
                        solutionFound = false
                    }
                case .min:
                    if singleValue.mValue > 0 || (singleValue.mValue == 0 && singleValue.realValue > 0) {
                        solutionFound = false
                    }
                }
            }
        }
        
        func calculateInVectorIndex() {
            inVectorIndex = xVectorIndexes[0]
            var inVectorPositionIndex = 0
            for i in 1...zcVector.vectorNumbers.count - 1 {
                switch target {
                case .max:
                    let cond1 = zcVector.vectorNumbers[i] < 0
                    let number1 = zcVector.vectorNumbers[i].abs()
                    let number2 = zcVector.vectorNumbers[inVectorPositionIndex].abs()
                    let cond2 = number1 > number2
                    let cond3 = zcVector.vectorNumbers[inVectorPositionIndex] > 0
                    if cond1 && (cond3 || cond2) {
                        inVectorPositionIndex = i
                    }
                case .min:
                    for i in 1...zcVector.vectorNumbers.count - 1 {
                        let cond1 = zcVector.vectorNumbers[i] > 0
                        let cond2 = zcVector.vectorNumbers[i].abs() >= zcVector.vectorNumbers[inVectorPositionIndex].abs()
                        if cond1 && cond2
                        {
                            inVectorPositionIndex = i
                        }
                    }
                }
            }
            inVectorIndex = xVectorIndexes[inVectorPositionIndex]
        }
        
        func calculateOutVectorIndex() {
            outVectorIndex = bVectorIndexes[0]
            var outVectorPositionIndex = 0
            for i in 1...bVectorIndexes.count - 1 {
                let x0i = x0Vector.vectorNumbers[i].realValue
                let xi = xMatrix.vectors[inVectorIndex-1].vectorNumbers[i].realValue
                let bestx0i = x0Vector.vectorNumbers[outVectorPositionIndex].realValue
                let bestxi = xMatrix.vectors[inVectorIndex-1].vectorNumbers[outVectorPositionIndex].realValue
                if xi > 0 && x0i/xi < bestx0i/bestxi {
                    outVectorPositionIndex = i
                    outVectorIndex = bVectorIndexes[i]
                }
            }
        }
    }
}
