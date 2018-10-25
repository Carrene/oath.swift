//
//  Totp.swift
//  oath
//
//  Created by hamed akhlaghi on 8/3/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import Foundation

import UIKit

public class Totp: Otp, TotpDelegate {
    
    private var mSecret: [UInt8]
    private var mTimeInterval: Int
    private var mOtpLength: Int
    private var mHashType: HashType

    
    init(secret: [UInt8], timeInterval: Int, otpLength: Int, hashType: HashType) {
        
        mSecret = secret
        mTimeInterval = timeInterval
        mOtpLength = otpLength
        mHashType = hashType
    }
    
    public func generateTotp() -> String? {
    
        let date = Date()
        let time: CLong = CLong(date.timeIntervalSince1970)
        return generateTotp(time: time)
    }
    
    public func generateTotp(time: CLong) -> String? {
        let counter: CLong = time / mTimeInterval
        return super.generateOtp(moveFactor: counter, mHashType: mHashType, secret: mSecret, otpLength: mOtpLength)
    }
    
    
}
