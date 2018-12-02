//
//  extension.swift
//  oath
//
//  Created by hamed akhlaghi on 8/3/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import Foundation

extension String {
    public func hexaToBytes() -> [UInt8] {
        var position = self.startIndex
        return (0..<self.count/2).compactMap { _ in
            defer { position = self.index(position, offsetBy: 2) }
            return UInt8(self[position...self.index(after: position)], radix: 16)
        }
    }
}



