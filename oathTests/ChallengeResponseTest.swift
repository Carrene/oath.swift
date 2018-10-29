//
//  ChallengeResponseTest.swift
//  oath
//
//  Created by hamed akhlaghi on 8/7/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import XCTest
@testable import oath
@testable import CryptoSwift

class ChallengeResponseTest: XCTestCase {
    static let SEED_128 = "3132333435363738393031323334353637383930"
    static let SEED_256 = "3132333435363738393031323334353637383930313233343536373839303132"
    static let SEED_512 = "31323334353637383930313233343536373839303132333435363738393031323334353637383930313233343536373839303132333435363738393031323334"
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFirstTable() {
        let challengeArray = ["00000000","11111111", "22222222", "33333333","44444444", "55555555", "66666666", "77777777", "88888888", "99999999"]
        let responseArray = ["237653", "243178", "653583", "740991", "608993", "388898", "816933", "224598", "750600", "294470"]
        let secretByte = ChallengeResponseTest.SEED_128.hexaToBytes()
        for i in 0..<challengeArray.count {
            let challenge = challengeArray[i]
            let big = Int(challenge,radix: 10)
            let hexChallenge = String(big!, radix: 16).uppercased()
            let challengeResponse = ChallengeResponse()
            let ocra = challengeResponse.generateOcra(ocraSuite: "OCRA-1:HOTP-SHA1-6:QN08", secret: secretByte, counter: nil, challenge: hexChallenge, password: nil, sessionInformation: nil, timeStamp: nil)
            XCTAssertEqual(ocra, responseArray[i], "with challenge " + challengeArray[i] + "response must be" + responseArray[i])
        }
    }
    
    func testOcraSecondTable() {
        let challengeArray = ["12345678","12345678", "12345678", "12345678","12345678", "12345678", "12345678", "12345678", "12345678", "12345678"]
        let responseArray = ["65347737", "86775851", "78192410", "71565254", "10104329", "65983500", "70069104", "91771096", "75011558", "08522129"]
        let counterArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        let secretByte = ChallengeResponseTest.SEED_256.hexaToBytes()
        for i in 0..<challengeArray.count {
            let challenge = challengeArray[i]
            let big = Int(challenge,radix: 10)
            let hexChallenge = String(big!, radix: 16).uppercased()
            let challengeResponse = ChallengeResponse()
            let ocra = challengeResponse.generateOcra(ocraSuite: "OCRA-1:HOTP-SHA256-8:C-QN08-PSHA1", secret: secretByte, counter: counterArray[i], challenge: hexChallenge, password: "7110eda4d09e062aa5e4a390b0a572ac0d2c0220", sessionInformation: nil, timeStamp: nil)
            XCTAssertEqual(ocra, responseArray[i],"with counter " + counterArray[i] + " and challenge " + challengeArray[i] + " response must be" + responseArray[i])
        }

    }
    
    func testOcraThirdTable() {
        let challengeArray = ["00000000","11111111", "22222222", "33333333","44444444"]
        let responseArray = ["83238735", "01501458", "17957585", "86776967", "86807031"]
        let secretByte = ChallengeResponseTest.SEED_256.hexaToBytes()
        for i in 0..<challengeArray.count {
            let challenge = challengeArray[i]
            let big = Int(challenge,radix: 10)
            let hexChallenge = String(big!, radix: 16).uppercased()
            let challengeResponse = ChallengeResponse()
            let ocra = challengeResponse.generateOcra(ocraSuite: "OCRA-1:HOTP-SHA256-8:QN08-PSHA1", secret: secretByte, counter: nil, challenge: hexChallenge, password: "7110eda4d09e062aa5e4a390b0a572ac0d2c0220", sessionInformation: nil, timeStamp: nil)
            XCTAssertEqual(ocra, responseArray[i],"with challenge " + challengeArray[i] + "response must be" + responseArray[i])
        }

    }
    
    func testOcraForthTable() {
        let challengeArray = ["00000000","11111111", "22222222", "33333333","44444444", "55555555", "66666666", "77777777", "88888888", "99999999"]
        let responseArray = ["07016083", "63947962", "70123924", "25341727", "33203315", "34205738", "44343969", "51946085", "20403879", "31409299"]
        let counterArray = ["00000", "00001", "00002", "00003", "00004", "00005", "00006", "00007", "00008", "00009"]
        let secretByte = ChallengeResponseTest.SEED_512.hexaToBytes()
        for i in 0..<challengeArray.count {
            let challenge = challengeArray[i]
            let big = Int(challenge,radix: 10)
            let hexChallenge = String(big!, radix: 16).uppercased()
            let challengeResponse = ChallengeResponse()
            let ocra = challengeResponse.generateOcra(ocraSuite: "OCRA-1:HOTP-SHA512-8:C-QN08", secret: secretByte, counter: counterArray[i], challenge: hexChallenge, password: nil, sessionInformation: nil, timeStamp: nil)
            XCTAssertEqual(ocra, responseArray[i], "with counter " + counterArray[i] + " and challenge " + challengeArray[i] + " response must be" + responseArray[i])
        }

    }
    
    func testOcraFifthTable() {
        let timeArray = ["132d0b6", "132d0b6", "132d0b6", "132d0b6", "132d0b6"]
        let responseArray = ["95209754", "55907591", "22048402", "24218844", "36209546"]
        let challengeArray = ["00000000","11111111", "22222222", "33333333","44444444"]
        let secretByte = ChallengeResponseTest.SEED_512.hexaToBytes()
        
        for i in 0..<challengeArray.count {
            let challenge = challengeArray[i]
            let big = Int(challenge,radix: 10)
            let hexChallenge = String(big!, radix: 16).uppercased()
            let challengeResponse = ChallengeResponse()
            let ocra = challengeResponse.generateOcra(ocraSuite: "OCRA-1:HOTP-SHA512-8:QN08-T1M", secret: secretByte, counter: nil, challenge: hexChallenge, password: nil, sessionInformation: nil, timeStamp: timeArray[i])
            XCTAssertEqual(ocra, responseArray[i],"with time " + timeArray[i] + " and challenge " + challengeArray[i] + " response must be " + responseArray[i])
        }

    }
}
