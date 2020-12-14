//
//  HashMap.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/13/20.
//

/**
 HashMap implementation.
 Reference: https://github.com/raywenderlich/swift-algorithm-club/blob/master/Hash%20Table/HashTable.playground/Sources/HashTable.swift
 */
class HashMap<K: Hashable, V> {
    private typealias Element = (key: K, value: V)
    private typealias Bucket = [Element]
    private var bucketArray: [Bucket]
    // Current capacity of array list
    private var capacity: Int
    // Current size of array list
    private(set) var size: Int
    // Load factor threshold
    private var loadThreshold = 0.7
    // A Boolean value that indicates whether the hashmap is empty.
    public var isEmpty: Bool { return size == 0 }
    // Init
    public init(_ capacity: Int) {
        self.bucketArray = []
        self.capacity = capacity
        self.size = 0
        // Create empty chains
        bucketArray = Array(repeating: [], count: capacity)
    }
    /**
     The hash function to find the index of a key.
     - Parameter key: The key to input to hash function.
     
     - Returns: The index of the key the mapped to the array list.
     */
    private func hash(_ key: K) -> Int {
        return abs(key.hashValue % capacity)
    }
    /**
     Find the value for a key.
     
     - Parameter key: The key to query from hashmap.
     
     - Returns: A value for the key or nil is it does not exist.
     */
    func get(_ key: K) -> V? {
        let index = self.hash(key)
        for element in bucketArray[index] {
            if element.key == key {
                return element.value
            }
        }
        return nil
    }
    /**
     Adds a key value pair to hashmap
     
     - Parameter key:   The key of the data.
     - Parameter value: The value of the data.
     */
    public func add(_ value: V, forKey key: K) {
        let index = self.hash(key)
        // The key exists in the map.
        for (i, element) in bucketArray[index].enumerated() {
            if element.key == key {
                bucketArray[index][i].value = value
                return
            }
        }
        // The key does not exist in the map.
        bucketArray[index].append((key: key, value: value))
        size += 1
    }
    /**
     Method to remove a given key.
     
     - Parameter key: The key of the data.
     
     - Returns: The value stored in the given key.
     */
    public func remove(forKey key: K) -> V? {
        let index = self.hash(key)
        // Find the element in bucket chain.
        for (i, element) in bucketArray[index].enumerated() {
            if element.key == key {
                bucketArray[index].remove(at: i)
                size -= 1
                return element.value
            }
        }
        return nil
    }
}
