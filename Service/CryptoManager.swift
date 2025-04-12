//
//  CryptoManager.swift
//  art_words_v1.0
//
//  Created by TopDev on 16/3/2025.
//


import Foundation
import CommonCrypto

struct CryptoManager {
    public static let cryptKey = "LoveArtAndWords" // 16, 24, or 32 bytes
    public static let cryptIV = "InspirationsForYou" // Must be 16 bytes

    // Convert string to SHA-1 Hash (not encryption, just hashing)
    public static func sha1Hash(_ input: String) -> String {
        let data = Data(input.utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes { buffer in
            _ = CC_SHA1(buffer.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02x", $0) }.joined()
    }

    // AES Encrypt a string
    public static func encrypt(_ plainText: String) -> String? {
        guard let keyData = cryptKey.data(using: .utf8),
              let ivData = cryptIV.data(using: .utf8),
              let data = plainText.data(using: .utf8) else { return nil }

        let bufferSize = data.count + kCCBlockSizeAES128
        var buffer = Data(count: bufferSize)

        var numBytesEncrypted: size_t = 0
        let status = buffer.withUnsafeMutableBytes { bufferPointer in
            data.withUnsafeBytes { dataPointer in
                ivData.withUnsafeBytes { ivPointer in
                    keyData.withUnsafeBytes { keyPointer in
                        CCCrypt(
                            CCOperation(kCCEncrypt),
                            CCAlgorithm(kCCAlgorithmAES),
                            CCOptions(kCCOptionPKCS7Padding),
                            keyPointer.baseAddress, kCCKeySizeAES128,
                            ivPointer.baseAddress,
                            dataPointer.baseAddress, data.count,
                            bufferPointer.baseAddress, bufferSize,
                            &numBytesEncrypted
                        )
                    }
                }
            }
        }

        guard status == kCCSuccess else { return nil }
        return buffer.prefix(numBytesEncrypted).base64EncodedString()
    }

    // AES Decrypt a string
    public static func decrypt(_ encryptedText: String) -> String? {
        guard let keyData = cryptKey.data(using: .utf8),
              let ivData = cryptIV.data(using: .utf8),
              let data = Data(base64Encoded: encryptedText) else { return nil }

        let bufferSize = data.count + kCCBlockSizeAES128
        var buffer = Data(count: bufferSize)

        var numBytesDecrypted: size_t = 0
        let status = buffer.withUnsafeMutableBytes { bufferPointer in
            data.withUnsafeBytes { dataPointer in
                ivData.withUnsafeBytes { ivPointer in
                    keyData.withUnsafeBytes { keyPointer in
                        CCCrypt(
                            CCOperation(kCCDecrypt),
                            CCAlgorithm(kCCAlgorithmAES),
                            CCOptions(kCCOptionPKCS7Padding),
                            keyPointer.baseAddress, kCCKeySizeAES128,
                            ivPointer.baseAddress,
                            dataPointer.baseAddress, data.count,
                            bufferPointer.baseAddress, bufferSize,
                            &numBytesDecrypted
                        )
                    }
                }
            }
        }

        guard status == kCCSuccess else { return nil }
        return String(data: buffer.prefix(numBytesDecrypted), encoding: .utf8)
    }
}

