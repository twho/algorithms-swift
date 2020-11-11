//
//  LP1.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/10/20.
//

class LP1 {
    /**
     Solve basic 3D linear programming example using Simplex algorithm.
     Find maximum of equation: x1 + 6*x2 + 10*x3
     Conditions:
        1. x1 less than 300
        2. x2 less than 200
        3. x1 + 3*x2 + 2*x3 less than 1000. (cost)
        4. x2 + 3*x3 less than 500. (packaging)
        5. x1, x2, x3 are all greater than or equal to 0.
     Referring to: https://people.richland.edu/james/ictcm/2006/simplex.html, convert to a table.
     
       x1  x2  x3  s1  s2  s3  s4  s5  s6  s7
     [ 1,  0,  0,  1,  0,  0,  0,  0,  0,  0,  300]
     [ 0,  1,  0,  0,  1,  0,  0,  0,  0,  0,  200]
     [ 1,  3,  2,  0,  0,  1,  0,  0,  0,  0, 1000]
     [ 0,  1,  3,  0,  0,  0,  1,  0,  0,  0,  500]
     [ 1,  0,  0,  0,  0,  0,  0,  1,  0,  0,  0]
     [ 0,  1,  0,  0,  0,  0,  0,  0,  1,  0,  0]
     [ 0,  0,  1,  0,  0,  0,  0,  0,  0,  1,  0]
     
     [-1, -6, -10, 0,  0,  0,  0,  0,  0,  0,  0]
        
     - Parameter products:
     https://github.com/kennyledet/Algorithm-Implementations/blob/master/Simplex_Method/Java/mike168m/Simplex.java
     */
    var rows = 0
    var columns = 0
    var table = [[Double]]()
    var count = 0
    func loadData(_ data: [[Double]], _ numOfConstraints: Int, _ numOfUnknowns: Int) {
        guard data.count > 0 else { return }
        rows = numOfConstraints + 1
        columns = numOfUnknowns + 1
        
        table = Array(repeating: Array(repeating: 0.0, count: columns), count: rows)
        for i in 0..<table.count {
            table[i] = data[i]
        }
    }
    
    func findMaxProfit() -> [[Double]] {
        let pivotColumn = findEnteringColumn(table)
        
        var unbounded = false
        let ratios = calculateRatios(table, pivotColumn, &unbounded)
        if unbounded {
            return []
        }
        let prev = table
        let pivotRow = ratios.firstIndex(of: ratios.min()!)! // Find the smallest value
        formNextTableau(&table, pivotRow, pivotColumn)
        
        print(prev == table)
        print(table.last!.last!)
        return table
    }
    
    private func formNextTableau(_ table: inout [[Double]], _ pivotColumn: Int, _ pivotRow: Int) {
        let pivotValue = table[pivotRow][pivotColumn]
        var pivotRowVals = Array(repeating: 0.0, count: columns)
        var pivotColumnVals = Array(repeating: 0.0, count: columns)
        var rowNew = Array(repeating: 0.0, count: columns)

        // divide all entries in pivot row by entry inpivot column
        // get entry in pivot row
        pivotRowVals = table[pivotRow]
                
        // get entry inpivot colum
        for i in 0..<rows {
            pivotColumnVals[i] = table[i][pivotColumn]
        }
                
        // divide values in pivot row by pivot value
        for i in 0..<columns {
            rowNew[i] = pivotRowVals[i] / pivotValue
        }
        
        // subtract from each of the other rows
        for i in 0..<rows {
            if i != pivotRow {
                for j in 0..<columns {
                    let c = pivotColumnVals[i]
                    table[i][j] = table[i][j] - (c * rowNew[j])
                }
            }
        }
                
        // replace the row
        table[pivotRow] = rowNew
    }
    
    private func findEnteringColumn(_ table: [[Double]]) -> Int {
        guard table.count > 0 else { return 0 }
        // Set inital state
        var values = Array(repeating: 0.0, count: columns)
        var location = 0, count = 0
        // Find column
        for pos in 0..<columns - 1 {
            if table[rows - 1][pos] < 0 {
                count += 1
            }
        }
        
        if count > 1 {
            for pos in 0..<columns - 1 {
                values[pos] = abs(table[rows - 1][pos])
            }
            // Find the index of the largest value
            location = values.firstIndex(of: values.max()!)!
        } else {
            location = count - 1
        }
        return location
    }
    
    // calculates the pivot row ratios
    private func calculateRatios(_ table: [[Double]], _ currentColumn: Int, _ isUnbounded: inout Bool) -> [Double] {
        guard table.count > 0 else { return [] }
        var positiveEntries = Array(repeating: 0.0, count: rows)
        var res = Array(repeating: 0.0, count: rows)
        var allNegativeCount = 0
        for i in 0..<rows {
            if table[i][currentColumn] > 0 {
                positiveEntries[i] = table[i][currentColumn]
            } else {
                positiveEntries[i] = 0
                allNegativeCount += 1
            }
        }
        
        if allNegativeCount == rows {
            isUnbounded = true
        } else {
            for i in 0..<rows {
                let val = positiveEntries[i]
                if val > 0 {
                    res[i] = table[i][columns - 1] / val
                }
            }
        }
        
        return res
    }
}

struct SampleProduct {
    var profit: Int
    var demand: Int
    var supply: Int
    var packaging: Int
    
    init(_ profit: Int, _ demand: Int, _ supply: Int, _ packaging: Int) {
        self.profit = profit
        self.demand = demand
        self.supply = supply
        self.packaging = packaging
    }
}
