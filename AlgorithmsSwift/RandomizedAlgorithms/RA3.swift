//
//  RA3.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/13/20.
//

import Foundation
import CommonCrypto

class RA3 {
    // See HashMap class for full implementation.
    private let hashmap = HashMap<Int, Int>(1)
    /**
     Implementation of a bloom filter. Running example: unacceptable passwords.
     Reference: https://github.com/raywenderlich/swift-algorithm-club/blob/master/Bloom%20Filter/BloomFilter.playground/Contents.swift
     */
    class BloomFilter {
        private var bitArray: [Bool]
        private var size: Int, hashCount: Int
        private let hashingMethods = [Hashing.djb2, Hashing.sdbm]
        // Init
        init(_ capacity: Int, _ falsePositiveProbability: Float) {
            self.size = BloomFilter.getSize(capacity, falsePositiveProbability)
            self.hashCount = BloomFilter.getHashCount(self.size, capacity)
            self.bitArray = Array(repeating: false, count: capacity)
        }
        /**
         Calculate the size of bit array(m) to used using the following formula.
         m = -(count * log(prob)) / (log(2)^2)
         
         - Parameter count:       The number of items expected to be stored in filter.
         - Parameter probability: The false positive probability.
         
         - Returns: The size of bit array to used.
         */
        static func getSize(_ count: Int, _ probability: Float) -> Int {
            let m = -(Float(count) * log(probability) / pow(log(2), 2))
            return Int(m)
        }
        /**
         Calculate the number of hash functions using the following formula.
         k = (size/count) * log(2)
         
         - Parameter size:  The size of bit array.
         - Parameter count: The number of items expected to be stored in filter.
         
         - Returns: The hash function(k) to be used.
         */
        static func getHashCount(_ size: Int, _ count: Int) -> Int {
            let k = Double(size / count) * log(2)
            return Int(k)
        }
        /**
         Add values to bloom filter.
         
         - Parameter values: A string.
         */
        public func add(_ string: String) {
            let keys = computeHashes(string, self.hashingMethods)
            for key in keys {
                bitArray[key] = true
            }
        }
        /**
         Add values in batch.
         
         - Parameter values: A string data array.
         */
        public func add(_ values: [String]) {
            values.forEach {
                add($0)
            }
        }
        /**
         Compute a couple of hashes for the input string data. It is recommended that we have
         at least 2 hashing functions to compute hashes.
         
         - Parameter stringData:     A string.
         - Parameter hashingMethods: Hashing methods used in the bloom filter.
         
         - Returns: An integer array that is already converted to keys for use in bit array.
         */
        private func computeHashes(_ stringData: String, _ hashingMethods: [(String) -> Int]) -> [Int] {
            var hashKeys = [Int]()
            for hashingMethod in hashingMethods {
                let hash = abs(hashingMethod(stringData) % self.bitArray.count)
                hashKeys.append(hash)
            }
            return hashKeys
        }
        /**
         Determine if the bloom filter contains the input string.
         
         - Parameter string: A string to be tested.
         
         - Returns: A boolean determine if the input string exists in the bloom filter.
         */
        public func contains(_ string: String) -> Bool {
            let keys = computeHashes(string, self.hashingMethods)
            for key in keys {
                if !self.bitArray[key] {
                    return false
                }
            }
            return true
        }
        /**
         Hash functions, adapted from http://www.cse.yorku.ca/~oz/hash.html
         */
        struct Hashing {
            
            static func djb2(_ input: String) -> Int {
                var hash = 5381
                for char in input {
                    hash = ((hash << 5) &+ hash) &+ char.hashValue
                }
                return Int(hash)
            }
            
            static func sdbm(input: String) -> Int {
                var hash = 0
                for char in input {
                    hash = char.hashValue &+ (hash << 6) &+ (hash << 16) &- hash
                }
                return Int(hash)
            }
        }
    }
}
