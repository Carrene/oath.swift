# oath.swift
OATH algorithms in swift
## Features
- TOTP
- HOTP
- Challenge and response

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate oath.swift into your Xcode project using CocoaPods, specify it in your `Podfile`:

Swift 4.2
```ruby
pod 'oath', :git => 'https://github.com/Carrene/oath.swift.git', :tag => '0.4.0'
```

Swift 3
```ruby
pod 'oath', :git => 'https://github.com/Carrene/oath.swift.git', :tag => '0.3.0'

```
## Usage

```swift
//TOTP
let otp = Totp(secret: secret, timeInterval: 30, otpLength: 8, hashType: HashType.SHA1)
let totp = otp.generateTotp(time: 59)

//HOTP
let hotp = Hotp(secret: secret, otpLength: 6, hashType: HashType.SHA1)
let hotp = hotp.generateHotp()
```
For more information consider [oath.swift tests](https://github.com/Carrene/oath.swift/tree/master/oathTests)
