//
//  HotpTest.swift
//  oath
//
//  Created by hamed akhlaghi on 8/2/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import XCTest
@testable import oath
@testable import CryptoSwift

class HotpTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHotp_10time() {
        let hexSecret = "3132333435363738393031323334353637383930"
        let secret: [UInt8] = hexSecret.hexaToBytes()
        let hotp =  Hotp(secret: secret, otpLength: 6, hashType: HashType.SHA1)
        XCTAssertEqual(hotp.generateHotp(), "755224")
        XCTAssertEqual(hotp.generateHotp(), "287082")
        XCTAssertEqual(hotp.generateHotp(), "359152")
        XCTAssertEqual(hotp.generateHotp(), "969429")
        XCTAssertEqual(hotp.generateHotp(), "338314")
        XCTAssertEqual(hotp.generateHotp(), "254676")
        XCTAssertEqual(hotp.generateHotp(), "287922")
        XCTAssertEqual(hotp.generateHotp(), "162583")
        XCTAssertEqual(hotp.generateHotp(), "399871")
        XCTAssertEqual(hotp.generateHotp(), "520489")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

