//
//  ChallengeResponseDelegate.swift
//  oath
//
//  Created by hamed akhlaghi on 8/5/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import Foundation
public protocol ChallengeResponseDelegate {
    func generateOcra(ocraSuite: String, secret: [UInt8], counter: String?, challenge: String, password: String?, sessionInformation: String?, timeStamp: String?) -> String?
}
