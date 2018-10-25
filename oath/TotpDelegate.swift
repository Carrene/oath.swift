//
//  TotpDelegate.swift
//  oath
//
//  Created by hamed akhlaghi on 8/3/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import Foundation
public protocol TotpDelegate {
    func generateTotp() -> String?
    func generateTotp(time: CLong) -> String?
}
