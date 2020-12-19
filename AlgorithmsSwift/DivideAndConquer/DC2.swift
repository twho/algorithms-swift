//
//  DC2.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/18/20.
//

class DC2 {
    /**
     This function takes last element as pivot, places the pivot element at its correct position
     in sorted array, and places all smaller (smaller than pivot) to left of pivot and all greater
     elements to right of pivot.
     Reference: https://github.com/raywenderlich/swift-algorithm-club/blob/master/Quicksort/Quicksort.swift
     
     - Parameter array: The array to be partitioned.
     - Parameter low:   The starting index.
     - Parameter high:  The ending index.
     
     - Returns: The index of the pivot, which is also the final index of the element in sorted array.
     */
    func partition(_ array: inout [Int], _ low: Int, _ high: Int) -> Int {
        // We always use the highest item as the pivot.
        let pivot = array[high]
        /*
         This loop partitions the array into four (possibly empty) regions:
         1. [low..<i] contains all values <= pivot,
         2. [i...high - 1] contains all values > pivot
         3. [high] is the pivot value.
         4. Excludes [high + 1..<array.count] and [0..<low], which are out of range.
         */
        var i = low
        for j in low..<high {
            if array[j] <= pivot {
                array.swapAt(i, j)
                i += 1
            }
        }
        // Swap the pivot element with the first element that is greater than the pivot.
        array.swapAt(i, high)
        return i
    }
    /**
     Quick select algorithm finds the kth smallest element in the unordered array.
     This algorithm can also be used to find median.
     Runtime: O(N). The worst case - O(N^2) happens when the worst pivot is selected every time.
     
     - Parameter array:  The array to be partitioned.
     - Parameter left:   The starting index.
     - Parameter right:  The ending index.
     - Parameter k:      The k for finding the kth smallest element.
     
     - Returns: The kth smallest element in the array.
     */
    func kthSmallest(_ array: [Int], _ left: Int, _ right: Int, _ k: Int) -> Int {
        guard k > 0, k <= right - left + 1 else {
            return Int.max
        }
        var resultArray = array
        let pivot = partition(&resultArray, left, right)
        
        if pivot - left == k - 1 {
            return resultArray[pivot]
        } else if pivot - left > k - 1 {
            // The current pivot has more than k - 1 elements smaller than it.
            return kthSmallest(resultArray, left, pivot - 1, k)
        } else {
            // The current pivot has less than k - 1 elements smaller than it.
            // We have to take the number of smaller elements (pivot - left + 1) into account
            return kthSmallest(resultArray, pivot + 1, right, k - (pivot - left + 1))
        }
    }
    /**
     Quick select algorithm helps find the kth largest element in the unsorted array.
     Runtime: O(N). The worst case - O(N^2) happens when the worst pivot is selected every time.
     
     - Parameter array:  The array to be partitioned.
     - Parameter left:   The starting index.
     - Parameter right:  The ending index.
     - Parameter k:      The k for finding the kth smallest element.
     
     - Returns: The kth smallest element in the array.
     */
    func kthLargest(_ array: [Int], _ left: Int, _ right: Int, _ k: Int) -> Int {
        guard k > 0, k <= right - left + 1 else {
            return Int.max
        }
        var resultArray = array
        let pivot = partition(&resultArray, left, right)
        
        if right - pivot == k - 1 {
            return resultArray[pivot]
        } else if right - pivot > k - 1 {
            // The current pivot has more than k - 1 elements larger than it.
            return kthLargest(resultArray, pivot + 1, right, k)
        } else {
            // The current pivot has less than k - 1 elements larger than it.
            // We have to take the number of larger elements (right - pivot + 1) into account
            return kthLargest(resultArray, left, pivot - 1, k - (right - pivot + 1))
        }
    }
    /**
     Quick sort algorithm. Runtime: O(N logN)
     
     - Parameter array: The unsorted array.
     
     - Returns: a sorted array.
     */
    func quickSort(_ array: [Int]) -> [Int] {
        var result = array
        quickSortHelper(&result, 0, result.count - 1)
        return result
    }
    /**
     The recursive method used for quick sort.
     */
    private func quickSortHelper(_ array: inout [Int], _ low: Int, _ high: Int) {
        guard low < high else { return }
        let pivot = partition(&array, low, high)
        quickSortHelper(&array, low, pivot - 1)
        quickSortHelper(&array, pivot + 1, high)
    }
}
