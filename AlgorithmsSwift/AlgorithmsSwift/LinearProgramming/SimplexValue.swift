//
//  SimplexValue.swift
//  AlgorithmsSwift
//
//  Created by Vladimir Dinic on 5/14/17.
//  Updated by Michael Ho on 11/11/20.
//

struct SimplexValue: Equatable {
    var realValue = 0.0
    var mValue = 0.0
    
    init() {
        realValue = 0.0
        mValue = 0.0
    }
    
    init(realValue: Double) {
        self.realValue = realValue
        self.mValue = 0.0
    }
    
    init(mValue: Double) {
        self.realValue = 0.0
        self.mValue = mValue
    }
    
    init(realValue: Double, mValue: Double) {
        self.realValue = realValue
        self.mValue = mValue
    }
    
    func abs() -> SimplexValue {
        return SimplexValue(realValue: mValue == 0 ? Swift.abs(realValue) : realValue, mValue: Swift.abs(mValue))
    }
    
    static func +(left: SimplexValue, right: SimplexValue) -> SimplexValue {
        return SimplexValue(
            realValue: left.realValue + right.realValue,
            mValue: left.mValue + right.mValue
        )
    }
    
    static func -(left: SimplexValue, right: SimplexValue) -> SimplexValue {
        return SimplexValue(
            realValue: left.realValue - right.realValue,
            mValue: left.mValue - right.mValue
        )
    }
    
    static func *(left: SimplexValue, right: SimplexValue) -> SimplexValue {
        return SimplexValue(
            realValue: left.realValue * right.realValue,
            mValue: left.mValue * right.realValue + left.realValue * right.mValue
        )
    }
    
    static func *(left: Double, right: SimplexValue) -> SimplexValue {
        return SimplexValue(
            realValue: left * right.realValue,
            mValue: left * right.mValue
        )
    }
    
    static func /(left: SimplexValue, right: Double) -> SimplexValue {
        return SimplexValue(
            realValue: left.realValue / right,
            mValue: left.mValue / right
        )
    }
    
    static func /= ( left: inout SimplexValue, right: Double) {
        left.realValue = left.realValue / right
        left.mValue = left.mValue / right
    }
    
    static func += ( left: inout SimplexValue, right: SimplexValue) {
        left.realValue = left.realValue + right.realValue
        left.mValue = left.mValue + right.mValue
    }
    
    static func == ( left: SimplexValue, right: SimplexValue) -> Bool {
        return left.realValue == right.realValue && left.mValue == right.mValue
    }
    
    static func > ( left: SimplexValue, right: SimplexValue) -> Bool {
        return left.mValue > right.mValue || (left.mValue == right.mValue && left.realValue > right.realValue)
    }
    
    static func < ( left: SimplexValue, right: SimplexValue) -> Bool {
        return left.mValue < right.mValue || (left.mValue == right.mValue && left.realValue < right.realValue)
    }
    
    static func >= ( left: SimplexValue, right: SimplexValue) -> Bool {
        return (left.mValue >= right.mValue) || (left.realValue == right.realValue && left.mValue >= right.mValue) || (left.mValue == right.mValue && left.realValue >= right.realValue)
    }
    
    static func <= ( left: SimplexValue, right: SimplexValue) -> Bool {
        return (left.mValue <= right.mValue) || (left.realValue == right.realValue && left.mValue <= right.mValue) || (left.mValue == right.mValue && left.realValue <= right.realValue)
    }
    
    static func > ( left: SimplexValue, right: Double) -> Bool {
        return left.mValue > 0 || (left.mValue == 0 && left.realValue > right)
    }
    
    static func < ( left: SimplexValue, right: Double) -> Bool {
        return left.mValue < 0 || (left.mValue == 0 && left.realValue < right)
    }
}
