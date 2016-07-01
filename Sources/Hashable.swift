//
//  Hashable.swift
//  HashableDemo
//
//  Created by Kazuya Ueoka on 2016/06/30.
//  Copyright © 2016年 fromKK. All rights reserved.
//

import Foundation
import CommonCrypto

private protocol HashablePrivate {
    func hash(algorithm: (UnsafePointer<Void>, CC_LONG, UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8>,
 digestLength: Int32) -> String?
}

public protocol Hashable {
    func md5() -> String?
    func sha1() -> String?
    func sha224() -> String?
    func sha256() -> String?
    func sha384() -> String?
    func sha512() -> String?
}

extension NSData: Hashable, HashablePrivate {
    private func hash(algorithm: (UnsafePointer<Void>, CC_LONG, UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8>, digestLength: Int32) -> String? {
        let digestLen: Int = Int(digestLength)
        let fileLen: CUnsignedInt = CUnsignedInt(self.length)
        let buffer: UnsafeMutablePointer<CUnsignedChar> = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        algorithm(self.bytes, fileLen, buffer)

        var result: String = ""
        for i in 0..<digestLen {
            result = result.stringByAppendingFormat("%02x", buffer[i])
        }
        return result
    }

    public func md5() -> String? {
        return self.hash(CC_MD5, digestLength: CC_MD5_DIGEST_LENGTH)
    }

    public func sha1() -> String? {
        return self.hash(CC_SHA1, digestLength: CC_SHA1_DIGEST_LENGTH)
    }

    public func sha224() -> String? {
        return self.hash(CC_SHA224, digestLength: CC_SHA224_DIGEST_LENGTH)
    }

    public func sha256() -> String? {
        return self.hash(CC_SHA256, digestLength: CC_SHA256_DIGEST_LENGTH)
    }

    public func sha384() -> String? {
        return self.hash(CC_SHA384, digestLength: CC_SHA384_DIGEST_LENGTH)
    }

    public func sha512() -> String? {
        return self.hash(CC_SHA512, digestLength: CC_SHA512_DIGEST_LENGTH)
    }
}

extension String: Hashable {
    public func md5() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return data.md5()
    }

    public func sha1() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return data.sha1()
    }

    public func sha224() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return data.sha224()
    }

    public func sha256() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return data.sha256()
    }

    public func sha384() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return data.sha384()
    }

    public func sha512() -> String? {
        guard let data: NSData = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return data.sha512()
    }
}
