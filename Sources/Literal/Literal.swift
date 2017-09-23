//
//  Literal.swift
//  Literal
//
//  Created by Bernardo Breder on 09/01/17.
//
//

import Foundation

public enum LiteralType {
    case string
    case int
    case double
    case bool
}

public struct Literal {
    
    public let type: LiteralType
    
    public let value: Any
    
    public init(_ string: String) {
        self.type = .string
        self.value = string
    }
    
    public init(_ int: Int) {
        self.type = .int
        self.value = int
    }
    
    public init(_ double: Double) {
        self.type = .double
        self.value = double
    }
    
    public init(_ bool: Bool) {
        self.type = .bool
        self.value = bool
    }
    
    public var string: String? {
        return type == .string ? value as? String : nil
    }
    
    public var int: Int? {
        return type == .int ? value as? Int : nil
    }
    
    public var double: Double? {
        return type == .double ? value as? Double : nil
    }
    
    public var bool: Bool? {
        return type == .bool ? value as? Bool : nil
    }
    
    public func string(_ f: (String) -> Void) {
        if let string = self.string { f(string) }
    }
    
    public func int(_ f: (Int) -> Void) {
        if let int = self.int { f(int) }
    }
    
    public func double(_ f: (Double) -> Void) {
        if let double = self.double { f(double) }
    }
    
    public func bool(_ f: (Bool) -> Void) {
        if let bool = self.bool { f(bool) }
    }
    
    public var isInt: Bool { return type == .int }
    
    public var isDouble: Bool { return type == .double }
    
    public var isString: Bool { return type == .string }
    
    public var isBool: Bool { return type == .bool }
    
}

extension Literal {
    
    public init(encoded: String) throws {
        guard let c = encoded.characters.first else { throw LiteralError.decodeEmpty }
        let string = encoded.substring(from: encoded.index(after: encoded.startIndex))
        switch c {
        case "S":
            self.init(string)
        case "I":
            guard let int = Int(string) else { throw LiteralError.decodeInt(string) }
            self.init(int)
        case "B":
            guard let bool = Bool(string) else { throw LiteralError.decodeBool(string) }
            self.init(bool)
        case "D":
            guard let double = Double(string) else { throw LiteralError.decodeDouble(string) }
            self.init(double)
        default:
            throw LiteralError.decodeUnknown(c, string)
        }
    }
    
    public func encode() -> String {
        switch type {
        case .string:
            return "S" + (value as! String)
        case .int:
            return "I" + String(value as! Int)
        case .bool:
            return "B" + String(value as! Bool)
        case .double:
            return "D" + String(value as! Double)
        }
    }
    
}

extension Literal: ExpressibleByStringLiteral, ExpressibleByIntegerLiteral,ExpressibleByBooleanLiteral, ExpressibleByFloatLiteral {
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
    
    public init(booleanLiteral value: BooleanLiteralType) {
        self.init(value)
    }
    
    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)
    }
    
}

extension Literal: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        switch type {
        case .string: return value as! String
        case .int: return String(value as! Int)
        case .double: return String(value as! Double)
        case .bool: return String(value as! Bool)
        }
    }
    
    public var debugDescription: String {
        return description
    }
    
}

extension Literal: Hashable {
    
    public static func ==(lhs: Literal, rhs: Literal) -> Bool {
        switch (lhs.type, rhs.type) {
        case (.string, .string):
            return lhs.string == rhs.string
        case (.int, .int):
            return lhs.int == rhs.int
        case (.double, .double):
            return lhs.double == rhs.double
        case (.bool, .bool):
            return lhs.bool == rhs.bool
        default:
            return false
        }
    }
    
    public var hashValue: Int {
        switch (type) {
        case .string:
            return (value as! String).hash
        case .int:
            return value as! Int
        case .double:
            return (value as! Double).hashValue
        case .bool:
            return (value as! Bool).hashValue
        }
    }
    
}

public enum LiteralError: Error {
    case decodeEmpty
    case decodeInt(String)
    case decodeBool(String)
    case decodeDouble(String)
    case decodeUnknown(Character, String)
}
