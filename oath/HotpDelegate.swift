//
//  HotpDelegate.swift
//  oath
//
//  Created by hamed akhlaghi on 8/2/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import Foundation

public protocol HotpDelegate {
    func generateHotp() -> String?
}
