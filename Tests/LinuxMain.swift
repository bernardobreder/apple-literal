//
//  LiteralTests.swift
//  Literal
//
//  Created by Bernardo Breder.
//
//

import XCTest
@testable import LiteralTests

extension LiteralTests {

	static var allTests : [(String, (LiteralTests) -> () throws -> Void)] {
		return [
			("testCodec", testCodec),
			("testDescription", testDescription),
			("testFunction", testFunction),
			("testValue", testValue),
		]
	}

}

XCTMain([
	testCase(LiteralTests.allTests),
])

