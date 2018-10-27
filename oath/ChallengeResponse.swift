    //
//  ChallengeResponse.swift
//  oath
//
//  Created by hamed akhlaghi on 8/5/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//
import CryptoSwift
import Foundation
    public class ChallengeResponse: ChallengeResponseDelegate {
        
        private var mSeed: String?
        private var mTimeinterval: Int?
        private var mHashType: HashType?
        private var mResponseLength: Int?
        //TODO is this field necessary
        private var mCounter: CLong?
        
        public func generateOCRA(ocraSuite: String, key: String,Counter: String, question: String, password: String, sessionInformation: String, timeStamp: String) {
            var codeDigits = 0
            var crypto: HMAC.Variant?
            var result: String?
            var ocraSuiteLength = ocraSuite.hexaToBytes().count
            var counterLength = 0
            var questionLength = 0
            var passwordLength = 0
            var sessionInformationLength = 0
            var timeStampLength = 0
            
            // The OCRASuites components
            var CryptoFunction: String = ocraSuite.components(separatedBy: ":")[1]
            var DataInput: String = ocraSuite.components(separatedBy: ":")[2]
            
        
        }
        
        public func generateHashChallengeResponse(challenge: String) {
            
        }
        
        public func generateHashTimeChallengeResponse(challenge: String) {
            
        }
        
        public func generateHashTimeChallengeResponse(challenge: String, time: CLong) {
            
        }
        
        public func verifyChallengeResponse(challenge: String, response: String, windowSize: Int) -> Bool {
            return true
        }
        
    }
