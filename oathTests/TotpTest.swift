//
//  TotpTest.swift
//  oath
//
//  Created by hamed akhlaghi on 8/3/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import XCTest
@testable import oath
@testable import CryptoSwift

class TotpTest: XCTestCase {
    let seed128 = "3132333435363738393031323334353637383930";
    let seed256 = "3132333435363738393031323334353637383930" + "313233343536373839303132";
    let seed512 = "3132333435363738393031323334353637383930" + "3132333435363738393031323334353637383930" + "3132333435363738393031323334353637383930" + "31323334"
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTotp_rfcTestCase1() {
        let hexSecret = seed128
        let secret:[UInt8] = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA1)
        let totp = otp.generateTotp(time: 59)
        XCTAssertEqual(totp, "94287082")
        
    }
    
    
    func testTotp_rfcTestCase2() {
        
        let hexSecret = seed256
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA256);
        let totp = otp.generateTotp(time: 59)
        XCTAssertEqual(totp, "46119246")
    }
    
    func testTotp_rfcTestCase3() {
        
        let hexSecret = seed512
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA512);
        let totp = otp.generateTotp(time: 59)
        XCTAssertEqual(totp,"90693936")
    }
    
    
    func testTotp_rfcTestCase4() {
        
        let hexSecret = seed128
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA1)
        let totp = otp.generateTotp(time: 1111111109)
        XCTAssertEqual(totp, "07081804")
    }
    
    func testTotp_rfcTestCase5() {
        
        let hexSecret = seed256
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA256)
        let totp = otp.generateTotp(time: 1111111109)
        XCTAssertEqual(totp, "68084774")
    }
    
    func testTotp_rfcTestCase6() {
        
        let hexSecret = seed512
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA512)
        let totp = otp.generateTotp(time: 1111111109)
        XCTAssertEqual(totp, "25091201")
    }
    
    func testTotp_rfcTestCase7() {
        
        let hexSecret = seed128
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA1);
        let totp = otp.generateTotp(time: 1111111111);
        XCTAssertEqual(totp, "14050471")
    }
    
    
    func testTotp_rfcTestCase8() {
        
        let hexSecret = seed256
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA256)
        let totp = otp.generateTotp(time: 1111111111)
        XCTAssertEqual(totp, "67062674")
    }
    
    
    func testTotp_rfcTestCase9() {
        
        let hexSecret = seed512
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA512)
        let totp = otp.generateTotp(time: 1111111111)
        XCTAssertEqual(totp, "99943326")
    }
    
    func testTotp_rfcTestCase10() {
        
        let hexSecret = seed128
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA1)
        let totp = otp.generateTotp(time: 1234567890)
        XCTAssertEqual(totp, "89005924")
    }
    
    func testTotp_rfcTestCase11() {
        
        let hexSecret = seed256
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA256)
        let totp = otp.generateTotp(time: 1234567890)
        XCTAssertEqual(totp, "91819424")
    }
    
    
    func testTotp_rfcTestCase12(){
        
        let hexSecret = seed512
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA512)
        let totp = otp.generateTotp(time: 1234567890)
        XCTAssertEqual(totp, "93441116")
    }
    
    func testTotp_rfcTestCase13() {
        
        let hexSecret = seed128
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA1)
        let totp = otp.generateTotp(time: 2000000000)
        XCTAssertEqual(totp, "69279037")
    }
    
    func testTotp_rfcTestCase14() {
        
        let hexSecret = seed256
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA256)
        let totp = otp.generateTotp(time: 2000000000)
        XCTAssertEqual(totp, "90698825")
    }
    
    func testTotp_rfcTestCase15() {
        
        let hexSecret = seed512
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA512)
        let totp = otp.generateTotp(time: 2000000000)
        XCTAssertEqual(totp, "38618901");
    }
    
    func testTotp_now8DigitNotNull() {
        
        let hexSecret = seed128
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA1)
        let totp = otp.generateTotp()
        XCTAssertNotNil(totp)
    }
    
    func testTotp_sha384NowNotNull() {
        
        let hexSecret = seed128
        let secret = hexSecret.hexaToBytes()
        let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA384)
        let totp = otp.generateTotp()
        XCTAssertNotNil(totp)
    }
    
}
