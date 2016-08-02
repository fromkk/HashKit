//
//  Hashable.swift
//  HashableDemo
//
//  Created by Kazuya Ueoka on 2016/06/30.
//  Copyright © 2016年 fromKK. All rights reserved.
//

import Foundation
import CommonCrypto

public enum HashableType {
    case md5
    case sha1
    case sha224
    case sha256
    case sha384
    case sha512

    func hash(data: NSData) -> String? {
        let algorithm: (UnsafePointer<Void>, CC_LONG, UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8>
        let digestLength: Int32
        switch self {
        case .md5:
            algorithm = CC_MD5
            digestLength = CC_MD5_DIGEST_LENGTH
            break
        case .sha1:
            algorithm = CC_SHA1
            digestLength = CC_SHA1_DIGEST_LENGTH
            break
        case .sha224:
            algorithm = CC_SHA224
            digestLength = CC_SHA224_DIGEST_LENGTH
            break
        case .sha256:
            algorithm = CC_SHA256
            digestLength = CC_SHA256_DIGEST_LENGTH
            break
        case .sha384:
            algorithm = CC_SHA384
            digestLength = CC_SHA384_DIGEST_LENGTH
            break
        case .sha512:
            algorithm = CC_SHA512
            digestLength = CC_SHA512_DIGEST_LENGTH
            break
        }
        let digestLen: Int = Int(digestLength)
        let buffer: UnsafeMutablePointer<CUnsignedChar> = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        algorithm(data.bytes, CUnsignedInt(data.length), buffer)
        var result: String = ""
        for i in 0..<digestLen {
            result = result.stringByAppendingFormat("%02x", buffer[i])
        }
        buffer.dealloc(digestLen)
        return result
    }
}

public protocol HashKit {
    func md5() -> String?
    func sha1() -> String?
    func sha224() -> String?
    func sha256() -> String?
    func sha384() -> String?
    func sha512() -> String?
}

extension NSData: HashKit {
    public func md5() -> String? {
        return HashableType.md5.hash(self)
    }

    public func sha1() -> String? {
        return HashableType.sha1.hash(self)
    }

    public func sha224() -> String? {
        return HashableType.sha224.hash(self)
    }

    public func sha256() -> String? {
        return HashableType.sha256.hash(self)
    }

    public func sha384() -> String? {
        return HashableType.sha384.hash(self)
    }

    public func sha512() -> String? {
        return HashableType.sha512.hash(self)
    }
}

extension String: HashKit {
    public func md5() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return HashableType.md5.hash(data)
    }

    public func sha1() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return HashableType.sha1.hash(data)
    }

    public func sha224() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return HashableType.sha224.hash(data)
    }

    public func sha256() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return HashableType.sha256.hash(data)
    }

    public func sha384() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return HashableType.sha384.hash(data)
    }

    public func sha512() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return HashableType.sha512.hash(data)
    }
}

public protocol HashableHmac {
    func hmac(algorithm: HashableType, key: String) -> String?
}

extension String: HashableHmac {
    public func hmac(algorithm: HashableType, key: String) -> String? {
        guard let str: [CChar] = self.cStringUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        guard let keyStr: [CChar] = key.cStringUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }

        let strLen: Int = Int(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))

        let algo: CCHmacAlgorithm
        let digestLength: Int32
        switch algorithm {
        case .md5:
            algo = CCHmacAlgorithm(kCCHmacAlgMD5)
            digestLength = CC_MD5_DIGEST_LENGTH
            break
        case .sha1:
            algo = CCHmacAlgorithm(kCCHmacAlgSHA1)
            digestLength = CC_SHA1_DIGEST_LENGTH
            break
        case .sha224:
            algo = CCHmacAlgorithm(kCCHmacAlgSHA224)
            digestLength = CC_SHA224_DIGEST_LENGTH
            break
        case .sha256:
            algo = CCHmacAlgorithm(kCCHmacAlgSHA256)
            digestLength = CC_SHA256_DIGEST_LENGTH
            break
        case .sha384:
            algo = CCHmacAlgorithm(kCCHmacAlgSHA384)
            digestLength = CC_SHA384_DIGEST_LENGTH
            break
        case .sha512:
            algo = CCHmacAlgorithm(kCCHmacAlgSHA512)
            digestLength = CC_SHA512_DIGEST_LENGTH
            break
        }
        let digestLen: Int = Int(digestLength)
        let buffer = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        let keyLen = Int(key.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))

        CCHmac(algo, keyStr, keyLen, str, strLen, buffer)

        var result: String = ""
        for i in 0..<digestLen {
            result = result.stringByAppendingFormat("%02x", buffer[i])
        }
        buffer.dealloc(digestLen)

        return result
    }
}
