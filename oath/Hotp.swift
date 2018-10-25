//
//  Hotp.swift
//  oath
//
//  Created by hamed akhlaghi on 8/2/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import Foundation

public class Hotp: Otp, HotpDelegate {
    
    private var mSecret: [UInt8]
    private var mHashType: HashType
    private var mOtpLength: Int
    private var mCounter: CLong = 0
    
    public init(secret: [UInt8], otpLength: Int, hashType: HashType) {
        mSecret = secret
        mOtpLength = otpLength
        mHashType = hashType
    }
    
    public func generateHotp() -> String? {
        let movingFactor = mCounter
        mCounter = mCounter + 1
        return super.generateOtp(moveFactor: movingFactor, mHashType: mHashType, secret: mSecret, otpLength: mOtpLength)
    }
    
    

}
