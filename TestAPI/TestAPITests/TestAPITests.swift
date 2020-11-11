//
//  TestAPITests.swift
//  TestAPITests
//
//  Created by 胡生才 on 2020/11/12.
//

import XCTest
@testable import TestAPI

class TestAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDate() {
        let dateString = DateHelper().dateString()
        XCTAssert(dateString.count > 0)
    }
    
    func testSave() {
        SaveHelper().set(value: "a", key: "key")
        let json = SaveHelper().get(key: "key")?.first as! Dictionary<String,String>
        let value = json["value"]
        XCTAssert("a" == value)
        
        SaveHelper().remove(key: "key")
        let array = SaveHelper().get(key: "key")
        XCTAssertNil(array)
    }
}
