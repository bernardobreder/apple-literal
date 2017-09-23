//
//  Literal.swift
//  Literal
//
//  Created by Bernardo Breder on 09/01/17.
//
//

import XCTest
@testable import Literal

class LiteralTests: XCTestCase {
    
    func testValue() throws {
        XCTAssertEqual("abc", Literal("abc").string)
        XCTAssertEqual(1, Literal(1).int)
        XCTAssertEqual(1.2, Literal(1.2).double)
        XCTAssertEqual(true, Literal(true).bool)
        
        XCTAssertNil(Literal(1).string)
        XCTAssertNil(Literal(1.2).int)
        XCTAssertNil(Literal(true).double)
        XCTAssertNil(Literal(1).bool)
        
        XCTAssertTrue(Literal("abc").isString)
        XCTAssertTrue(Literal(1).isInt)
        XCTAssertTrue(Literal(1.2).isDouble)
        XCTAssertTrue(Literal(true).isBool)
        
        XCTAssertFalse(Literal(1).isString)
        XCTAssertFalse(Literal(1.2).isInt)
        XCTAssertFalse(Literal(true).isDouble)
        XCTAssertFalse(Literal(1).isBool)
    }
    
    func testFunction() {
        var count = 0
        
        Literal("abc").string { _ in count += 1 }
        Literal(1).int { _ in count += 1 }
        Literal(1.2).double { _ in count += 1 }
        Literal(true).bool { _ in count += 1 }
        
        XCTAssertEqual(4, count)
        
        Literal(1).string { _ in count += 1 }
        Literal(1.2).int { _ in count += 1 }
        Literal(true).double { _ in count += 1 }
        Literal(1).bool { _ in count += 1 }
        
        XCTAssertEqual(4, count)
    }
    
    func testCodec() throws {
        XCTAssertEqual(Literal("ação"), try Literal(encoded: Literal("ação").encode()))
        XCTAssertEqual(Literal(1), try Literal(encoded: Literal(1).encode()))
        XCTAssertEqual(Literal(1.2), try Literal(encoded: Literal(1.2).encode()))
        XCTAssertEqual(Literal(true), try Literal(encoded: Literal(true).encode()))
    }
    
    func testDescription() throws {
        XCTAssertEqual("abc", Literal("abc").description)
        XCTAssertEqual("1", Literal(1).description)
        XCTAssertEqual("1.2", Literal(1.2).description)
        XCTAssertEqual("true", Literal(true).description)
        
        XCTAssertEqual("abc", Literal("abc").debugDescription)
        XCTAssertEqual("1", Literal(1).debugDescription)
        XCTAssertEqual("1.2", Literal(1.2).debugDescription)
        XCTAssertEqual("true", Literal(true).debugDescription)
    }

}

