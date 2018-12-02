//
//  Otp.swift
//  oath
//
//  Created by hamed akhlaghi on 8/2/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import Foundation
import CryptoSwift
public class Otp {
                            //  0  1   2     3    4        5        6       7         8
    
    private let DIGITS_POWER = [1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000]
    
    
    internal func generateOtp(moveFactor: CLong, mHashType: HashType, secret: [UInt8], otpLength: Int ) -> String? {
        var counter = [UInt8](repeating: 0, count: 8)
        var movingFactor = moveFactor
        
        for i in stride(from: counter.count-1, to: 0, by: -1){
            
            counter[i] = UInt8(movingFactor & 0xff)
            movingFactor = movingFactor >> 8
        }
        
        var hmac = [UInt8]()
        do {
            hmac = try calculteHMAC(hashType: Otp.hashTypeToHmacType(hashType: mHashType), secret: secret, data: counter)!
            
        } catch {
            return nil
        }
        
        let offset = hmac[hmac.count - 1] & 0xf
        var otpBinary = Int((hmac[Int(offset)] & 0x7f)) << 24
        otpBinary = otpBinary | Int((hmac[Int(offset+1)] & 0xff)) << 16
        otpBinary = otpBinary | Int((hmac[Int(offset+2)] & 0xff)) << 8
        otpBinary = otpBinary | Int((hmac[Int(offset+3)] & 0xff))
        
        let otp = Int(otpBinary) % DIGITS_POWER [otpLength]
        var result = String(otp)
        
        while (result.count < otpLength){
            result = "0"+result
        }
        return result
    }
    
    func calculteHMAC(hashType:HMAC.Variant , secret:Array<UInt8>, data:Array<UInt8>) throws -> Array<UInt8>?{
        
        let hmac = try HMAC(key: secret, variant: hashType).authenticate(data)
        return hmac
    }
    
    private static func  hashTypeToHmacType( hashType: HashType) -> HMAC.Variant {
        
        switch hashType {
        case .SHA1:
            return HMAC.Variant.sha1
        case .SHA256:
            return HMAC.Variant.sha256
        case .SHA384:
            return HMAC.Variant.sha384
        case .SHA512:
            return HMAC.Variant.sha512
        }
    }
    
}


