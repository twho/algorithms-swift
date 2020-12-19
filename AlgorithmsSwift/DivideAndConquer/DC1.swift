//
//  DC1.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/18/20.
//

class DC1 {
    /**
     Merge sort an integer array.
     
     - Parameter array: An unsorted array.
     
     - Returns: An array sorted in ascending order.
     */
    func mergeSort(_ array: [Int]) -> [Int] {
        guard array.count > 1 else { return array }
        let mid = array.count / 2
        let leftArray = mergeSort(Array(array[0..<mid]))
        let rightArray = mergeSort(Array(array[mid..<array.count]))
        return merge(leftArray, rightArray)
    }
    /**
     Method to merge two sorted array.
     
     - Parameter array1: First sorted array.
     - Parameter array2: Second sorted array.
     
     - Returns: An array merged from two inpu arrays.
     */
    private func merge(_ array1: [Int], _ array2: [Int]) -> [Int] {
        var idx1 = 0
        var idx2 = 0
        var result = [Int]()
        while idx1 < array1.count || idx2 < array2.count {
            if idx1 < array1.count, idx2 < array2.count {
                if array1[idx1] < array2[idx2] {
                    result.append(array1[idx1])
                    idx1 += 1
                } else {
                    result.append(array2[idx2])
                    idx2 += 1
                }
            } else if idx1 < array1.count {
                result.append(array1[idx1])
                idx1 += 1
            } else {
                result.append(array2[idx2])
                idx2 += 1
            }
        }
        return result
    }
    /**
     Use divide and conquer approach (faster) to calculate binary.
     Reference: https://www.geeksforgeeks.org/karatsuba-algorithm-for-fast-multiplication-using-divide-and-conquer-algorithm/
     Runtime: O(N ^ log3)
     Practice example: https://leetcode.com/problems/multiply-strings/
     
     - Parameter binaryX: First binary number as a string.
     - Parameter binaryY: Second binary number as a string.
     
     - Returns: The calculation result.
     */
    func binaryMultiplication(_ binaryX: String, _ binaryY: String) -> Int {
        // Add zeros for the shorter string.
        var extra = ""
        if abs(binaryX.count - binaryY.count) > 0 {
            for _ in 0..<abs(binaryX.count - binaryY.count) {
                extra += "0"
            }
        }
        
        var x = binaryX
        var y = binaryY
        if x.count < y.count {
            x = extra + x
        } else {
            y = extra + y
        }
        let n = x.count
        // Base cases
        if n == 0 {
            return 0
        } else if n == 1 {
            return (Int(binaryX, radix: 2) ?? 0) * (Int(binaryY, radix: 2) ?? 0)
        }
        
        let firstHalf = n / 2 // First half of string, floor(n/2)
        let secondHalf = (n - firstHalf); // Second half of string, ceil(n/2)
        let arrX = Array(x)
        let arrY = Array(y)
        
        let xL = String(arrX[0..<firstHalf])
        let xR = String(arrX[firstHalf..<x.count])
        
        // Find the first half and second half of second string
        let yL = String(arrY[0..<firstHalf])
        let yR = String(arrY[firstHalf..<y.count])

        // Recursively calculate the three products of inputs of size n/2
        let A = binaryMultiplication(xL, yL);
        let B = binaryMultiplication(xR, yR);
        let C = binaryMultiplication(addBinary(xL, xR), addBinary(yL, yR));

        // Combine the three products to get the final result.
        return A*(1<<(secondHalf*2)) + (C - A - B)*(1<<(secondHalf)) + B;
    }
    /**
     Add two binary string together.
     
     - Parameter x: First binary number as a string.
     - Parameter y: Second binary number as a string.
     
     - Returns: The calculation result.
     */
    private func addBinary(_ x: String, _ y: String) -> String {
        if x.count == 0, y.count == 0{
            return ""
        } else if x.count == 0 {
            return y
        } else if y.count == 0{
            return x
        }
        let num1 = Int(x, radix: 2) ?? 0
        let num2 = Int(y, radix: 2) ?? 0
        return String(num1 + num2, radix: 2)
    }
}
