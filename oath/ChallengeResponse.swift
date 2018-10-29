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
                                //  0  1   2     3    4        5        6       7         8
        
        private let DIGITS_POWER = [1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000]
        private var mSeed: String?
        private var mTimeInterval: Int?
        private var mHashType: HashType?
        private var mResponseLength: Int?
        //TODO is this field necessary
        private var mCounter: CLong?
        
        public func generateOCRA(ocraSuite: String, key: String, counter: String, question: String, password: String, sessionInformation: String, timeStamp: String) {
            var counter = counter
            var question = question
            var password = password
            var timeStamp = timeStamp
            
            var sessionInformation = sessionInformation
            var codeDigits = 0
            var crypto: HMAC.Variant?
            var result: String?
            let ocraSuiteLength = ocraSuite.hexaToBytes().count
            var counterLength = 0
            var questionLength = 0
            var passwordLength = 0
            var sessionInformationLength = 0
            var timeStampLength = 0
            
            // The OCRASuites components
            let CryptoFunction: String = ocraSuite.components(separatedBy: ":")[1]
            let DataInput: String = ocraSuite.components(separatedBy: ":")[2]
            if CryptoFunction.lowercased().contains("sha1") {
                crypto = HMAC.Variant.sha1
            }
            
            if CryptoFunction.lowercased().contains("sha256") {
                crypto = HMAC.Variant.sha256
            }
            
            if CryptoFunction.lowercased().contains("sha512") {
                crypto = HMAC.Variant.sha512
            }
            
            //How many digits should be return
            let subCryptoFunction = CryptoFunction.components(separatedBy: "-").last
            codeDigits = Int(subCryptoFunction!)!
            
            // The size of the byte array message to be encrypted
            // Counter
            if DataInput.lowercased().hasPrefix("c") {
                // Fix the length of the HEX string
                while (counter.characters.count < 16) {
                    counter = "0" + counter
                }
                counterLength = 8
            }
            
            // Question - always 128 bytes
            if DataInput.lowercased().hasPrefix("q") || DataInput.lowercased().contains("-q") {
                while (question.characters.count < 256) {
                    question = "0" + question
                }
                questionLength = 128
            }
            
            if DataInput.lowercased().contains("psha1") {
                while password.characters.count < 40 {
                    password = "0" + password
                }
                passwordLength = 20
            }
            
            // Password -sha256
            if DataInput.lowercased().contains("psha256") {
                while password.characters.count < 64 {
                    password = "0" + password
                }
                passwordLength = 32
            }
            
           
            if DataInput.lowercased().contains("psha512") {
                while password.characters.count < 128 {
                    password = "0" + password
                }
                passwordLength = 64
            }
            
            // session information - s064
            if DataInput.lowercased().contains("s064") {
                while sessionInformation.characters.count < 128 {
                    sessionInformation = "0" + sessionInformation
                }
                sessionInformationLength = 64
            }
            
            // session information - s128
            if DataInput.lowercased().contains("s128") {
                while sessionInformation.characters.count < 256 {
                    sessionInformation = "0" + sessionInformation
                }
                sessionInformationLength = 256
            }

            // session information - s512
            if DataInput.lowercased().contains("s512") {
                while sessionInformation.characters.count < 1028 {
                    sessionInformation = "0" + sessionInformation
                }
                sessionInformationLength = 512
            }
            
            // TimeStamp
            if DataInput.lowercased().contains("t") {
                while timeStamp.characters.count < 16 {
                    timeStamp = "0" + timeStamp
                }
                timeStampLength = 8
            }
            
            // Remember to add "1" for the "00" byte delimiter
            let msgLength = ocraSuiteLength +
                counterLength +
                questionLength +
                passwordLength +
                sessionInformationLength +
                timeStampLength +
                1
            var msg = [UInt8](repeating: 0, count: msgLength)
            
            // Put the bytes of "ocraSuite" parameters into the message
            var bArray: [UInt8] = [UInt8](ocraSuite.utf8)
            for i in 0...bArray.count-1 {
                msg[i] = bArray[i]
            }
            msg = bArray.map{$0}
            
            // Delimiter
            msg[bArray.count] = 0x00
            
            // Put the bytes of "Counter" to the message
            // Input is HEX encoded
            if (counterLength > 0) {
                bArray = counter.hexaToBytes()
                for i in 0...bArray.count-1 {
                    msg[counterLength + 1 + i] = bArray[i]
                }
            }

            // Put the bytes of "question" to the message
            // Input is text encoded
            if (questionLength > 0) {
                bArray = question.hexaToBytes()
                for i in 0...bArray.count-1 {
                    msg[counterLength + 1 + counterLength + i] = bArray[i]
                }
            }
            
            // Put the bytes of "password" to the message
            // Input is HEX encoded
            if (passwordLength > 0) {
                bArray = password.hexaToBytes()
                for i in 0...bArray.count-1 {
                    msg[counterLength + 1 + counterLength + questionLength + i] = bArray[i]
                }
            }
            
            // Put the bytes of "sessionInformation" to the message
            // Input is text encoded
            if (sessionInformationLength > 0) {
                bArray = sessionInformation.hexaToBytes()
                for i in 0...bArray.count-1 {
                    msg[counterLength + 1 + counterLength + questionLength + passwordLength + i] = bArray[i]
                }
            }
            
            // Put the bytes of "time" to the message
            // Input is text value of minutes
            if (timeStampLength > 0) {
                bArray = timeStamp.hexaToBytes()
                for i in 0...bArray.count-1 {
                    msg[counterLength + 1 + counterLength + questionLength + passwordLength + sessionInformationLength + i] = bArray[i]
                }
            }
            
            bArray = key.hexaToBytes()
            
            var hash = [UInt8]()
            do{
                hash = try HMAC(key: key, variant: crypto!).authenticate(msg)
            } catch{
                
            }
            
            // put selected bytes
            let offset = hash[hash.count - 1] & 0xf
            var binary = Int((hash[Int(offset)] & 0x7f)) << 24
            binary = binary | Int((hash[Int(offset+1)] & 0xff)) << 16
            binary = binary | Int((hash[Int(offset+2)] & 0xff)) << 8
            binary = binary | Int((hash[Int(offset+3)] & 0xff))
            let otp = Int(binary) % DIGITS_POWER [codeDigits]
            result = String(otp)

            while ((result?.characters.count)! < codeDigits){
                result = "0"+result!
            }
        
            
        }
        
        public func generateHashChallengeResponse(challenge: String) -> String {
            let ocraSuite: String = buildOcraSuit(version: "1", challengeLimit: 8)
            
            var counter = [UInt8](repeating: 0, count: 8)
            var movingFactor: CLong = mCounter!
            for i in stride(from: counter.count - 1, through: 0, by: -1) {
                counter[i] = UInt8(movingFactor & 0xff)
                 movingFactor = movingFactor >> 8
            }
            // Build question buffer
            var question = [UInt8](repeating: 0, count: 8)
            let challengeBytes = [UInt8](challenge.utf8)
            for i in 0...question.count-1 {
                question[i] = challengeBytes[i]
            }
            
            // Build message
            let messageLength = ocraSuite.characters.count + question.count + counter.count + 1
            var message = [UInt8](repeating: 0, count: messageLength)

            // put bytes of Ocra Suite into message
            let ocraBytes = [UInt8](challenge.utf8)
            for i in 0...ocraSuite.characters.count-1 {
                message[i] = ocraBytes[i]
            }
            
            // add delimeter
            message[ocraSuite.characters.count] = 0x00

            // put question to message
            for i in 0...question.count-1 {
                message[i + ocraSuite.characters.count + 1] = question[i]
            }

            // put timeStamp to message
            for i in 0...counter.count-1 {
                message[i + ocraSuite.characters.count + 1 + question.count] = counter[i]
            }

            let seed = [UInt8](mSeed!.utf8)

            var hash = [UInt8]()
            do {
                hash = try HMAC(key: seed, variant: HMAC.Variant.sha1).authenticate(message)
            }catch {
                
            }

            let offset = hash[hash.count - 1] & 0xf
            var responseBinary = Int((hash[Int(offset)] & 0x7f)) << 24
            responseBinary = responseBinary | Int((hash[Int(offset+1)] & 0xff)) << 16
            responseBinary = responseBinary | Int((hash[Int(offset+2)] & 0xff)) << 8
            responseBinary = responseBinary | Int((hash[Int(offset+3)] & 0xff))
            let otp = Int(responseBinary) % DIGITS_POWER [mResponseLength!]
            var result = String(otp)
            
            while (result.characters.count < mResponseLength!){
                result = "0"+result
            }
            
            return result
        }
        
        public func generateHashTimeChallengeResponse(challenge: String) -> String {
            
            let date = Date()
            let time: CLong = CLong(date.timeIntervalSince1970)
            mCounter = time / mTimeInterval!
            let TOTP: String = generateHashChallengeResponse(challenge: challenge)
            return TOTP
        }
        
        public func generateHashTimeChallengeResponse(challenge: String, time: CLong) -> String? {
            return nil
        }
        
        public func verifyChallengeResponse(challenge: String, response: String, windowSize: Int) -> Bool {
            return true
        }
        
        private func formatTime(timeInterval: Int) -> String {
            var timeInterval = timeInterval
            if (timeInterval >= 60) {
                timeInterval = timeInterval / 60
                
                if (timeInterval > 60) {
                    timeInterval = timeInterval / 60
                    return "\(timeInterval)" + "H"
                }
                
                return "\(timeInterval)" + "M"
            }
            
            return "\(timeInterval)" + "S"
        }
        
        private func buildOcraSuit(version: String, challengeLimit: Int) -> String {
            
            var algorithm = "OCRA-" + version
            algorithm = algorithm + " : HOTP-" + (mHashType?.rawValue)!
            algorithm = algorithm + "-" + "\(mResponseLength!)"
            
            if (mCounter != 0) {
                algorithm = algorithm + " : C-QA" + "\(challengeLimit)"
            } else if (mTimeInterval != 0) {
                algorithm = algorithm + " : QA" + "\(challengeLimit)" + "-T" + formatTime(timeInterval: mTimeInterval!)
            }
            return algorithm
        }
        
    }
