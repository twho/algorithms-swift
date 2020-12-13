//
//  RA2.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 12/12/20.
//

import Foundation

class RA2 {
    /**
     Euler Totient Function, count all number under n and is a co-prime number of n.
     For example, phi(5) = 4 since 1, 2, 3, 4 are the 4 numbers that are co-prime of 5 and are under 5.
     
     - Parameter n: The number to find the count of co-primes.
     
     - Returns: The count of co-primes.
     */
    func phi(_ n: Int) -> Int {
        var result = 1
        for i in 2..<n {
            if RA1.GreatestCommonDivisor.euclidAlgorithm(i, n) == 1 {
                result += 1
            }
        }
        return result
    }
    /**
     Determine if the number is a prime number.
     
     - Parameter number: The number to be determined.
     
     - Returns: A boolean indicate whether the number is a prime number.
     */
    func isPrime(_ number: Int) -> Bool {
        // Corner case
        if number <= 1 {
            return false
        }
        let sqrtAtInt = Int(sqrt(Double(number)))
        for i in 2...sqrtAtInt {
            if number % i == 0 {
                return false
            }
        }
        return true
    }
    /**
     Determine if the number is a prime number using Fermat's method.
     Reference: https://www.geeksforgeeks.org/primality-test-set-2-fermet-method/
     
     - Parameter number: The number to be determined.
     - Parameter k:      Try k times.
     
     - Returns: A boolean indicate whether the number is a prime number.
     */
    func isPrimeByFermat(_ number: Int, _ k: Int) -> Bool {
        // Handle edge cases where n = 1, 2, 3, 4
        if number <= 1 || number == 4 {
            return true
        } else if number <= 3 {
            return true
        }
        var k = k
        // Try k times.
        while k > 0 {
            // Pick a random number in [2..n-2]
            let x = 2 + Int.random(in: 0...number) % (number - 4)
            // Fermat's little theorem
            if RA1.modularExp(x, number - 1, number) != 1 {
                return false
            }
            k -= 1
        }
        return true
    }
    /**
     This class consists of algorithms required to perform RSA, which are generating public key pair,
     private key pair, encryption, and decryption.
     
     Steps for receiver setup:
     1. Pick 2 n-bit random primes p and q.
     2. Choose e relatively prime to (p - 1)(q - 1), e.g., e = 3, 5, 7, 11...
     3. Publish a public key (N, e)
     4. Computes private key: d = (e^-1)mod(p - 1)(q - 1)
     
     Steps for sender:
     1. Look up public key (N, e)
     2. Send a message m, encrypt it to y, where y = (m^e)mod(N)
     3. Send y.
     
     Steps for receiver receiving:
     1. Receive y.
     2. Use d from private key to descrypt.
     3. Decrypt by computing (y^d)mod(N) = m, where m is the original messsage.
     */
    class RSA {
        
        /**
         Generate public key pair. The current recommendation for n = pq is n to be at least 2048 bits.
         
         - Parameter p: First selected prime number.
         - Parameter q: Second selected prime number.
         
         - Returns: A tuple represents the public key pair.
         */
        func getPublicKeyPair(_ p: Int, _ q: Int) -> (N: Int, e: Int) {
            var e = 2
            // In practice, it's recommended to pick e as one of a set of known prime values.
            let phi = (p - 1)*(q - 1)
            while e < phi {
                if RA1.GreatestCommonDivisor.euclidAlgorithm(e, phi) == 1 {
                    break
                } else {
                    e += 1
                }
            }
            let N = p*q
            return (N, e)
        }
        /**
         Generate private key.
         
         - Parameter p: The p chosen in public key.
         - Parameter q: The q chosen in public key.
         - Parameter e: The e computed when public key genereated.
         
         - Returns: A tuple represents the public key pair.
         */
        func getPrivateKey(_ p: Int, _ q: Int, _ e: Int) -> Int {
            return RA1.multiplicativeInverse(e, (p - 1)*(q - 1))
        }
        /**
         The implementation of RSA encryption, which requires public key.
         Encryption c = (msg ^ e) % n
         
         - Parameter message:       The message to be encrypted.
         - Parameter publicKeyPair: The public key pair which must have N (=p*q) and e.
         
         - Returns: The encrypted message.
         */
        func encrypt(_ message: Int, _ publicKeyPair: (N: Int, e: Int)) -> Int {
            return RA1.modularExp(message, publicKeyPair.e, publicKeyPair.N)
        }
        /**
         The implementation of RSA decryption, which requires private key.
         
         - Parameter encryptedMessage: The encrypted message to be decrypted.
         - Parameter N:                The number where N = p*q.
         - Parameter privateKey:       The private key (d).
         
         - Returns: The decrypted message.
         */
        func decrypt(_ encryptedMessage: Int, _ N: Int, _ privateKey: Int) -> Int {
            return RA1.modularExp(encryptedMessage, privateKey, N)
        }
    }
}
