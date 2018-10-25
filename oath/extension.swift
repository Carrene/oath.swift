//
//  extension.swift
//  oath
//
//  Created by hamed akhlaghi on 8/3/1397 AP.
//  Copyright © 1397 hamed akhlaghi. All rights reserved.
//

import Foundation

extension String {
    func hexaToBytes() -> [UInt8] {
        var position = self.startIndex
        return (0..<self.characters.count/2).flatMap { _ in
            defer { position = self.index(position, offsetBy: 2) }
            return UInt8(self[position...self.index(after: position)], radix: 16)
        }
    }
}



