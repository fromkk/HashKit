[![Build Status](https://travis-ci.org/fromkk/HashKit.svg?branch=master)](https://travis-ci.org/fromkk/HashKit)

# HashKit

`HashKit` is wrapped C style library CommonCrypt in Swift.

---

# Install

If you don't have `Cartfile`, should make that file in your top of project.  
Add line to `Cartfile`  

```
github "fromkk/HashKit" == 1.0.2
```

Execute `carthage update` from command line.

---

# Usage

```swift
import HashKit

//NSData
let data = NSData(...)
print(data.md5())
print(data.sha1())
print(data.sha224())
print(data.sha256())
print(data.sha384())
print(data.sha512())

//String
let text = String(...)
print(text.md5())
print(text.sha1())
print(text.sha224())
print(text.sha256())
print(text.sha384())
print(text.sha512())

//hmac
text.hmac(algorithm: .md5, key: "some key")
```
