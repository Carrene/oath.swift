//
//  HashType.swift
//  oath
//
//  Created by hamed akhlaghi on 8/2/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import Foundation
public enum HashType: String {
    case SHA1 = "SHA1"
    case SHA256 = "SHA2"
    case SHA384 = "SHA3"
    case SHA512 = "SHA4"
    
    public static func fromCode(hash: String) -> HashType {
        
        switch hash {
        case "SHA-1":
            return HashType.SHA1
        case "SHA-2":
            return HashType.SHA256
        case "SHA-3":
            return HashType.SHA384
        case "SHA-4":
            return HashType.SHA512
        default:
            return HashType.SHA1
        }
    }
    
}
