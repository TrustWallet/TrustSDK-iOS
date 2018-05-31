// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import BigInt
import TrustCore

public final class SignTransactionCommand: Command {
    public let name = "sign-transaction"

    /// Transaction to sign
    public var transaction: Transaction

    /// Completion closure
    public var completion: (Data) -> Void

    /// Callback scheme
    public var callbackScheme: String

    public var callback: URL {
        var components = URLComponents()
        components.scheme = callbackScheme
        components.host = name
        return components.url!
    }

    public init(transaction: Transaction, callbackScheme: String, completion: @escaping (Data) -> Void) {
        self.transaction = transaction
        self.completion = completion
        self.callbackScheme = callbackScheme
    }

    public func requestURL(scheme: String) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = name
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "gasPrice", value: transaction.gasPrice.description))
        queryItems.append(URLQueryItem(name: "gasLimit", value: transaction.gasLimit.description))
        queryItems.append(URLQueryItem(name: "to", value: transaction.to.description))
        queryItems.append(URLQueryItem(name: "amount", value: transaction.amount.description))
        if let payload = transaction.payload {
            queryItems.append(URLQueryItem(name: "data", value: payload.hexString))
        }
        queryItems.append(URLQueryItem(name: "nonce", value: transaction.nonce.description))
        queryItems.append(URLQueryItem(name: "callback", value: callback.absoluteString))
        components.queryItems = queryItems
        return components.url!
    }

    public func handleCallback(url: URL) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false), components.host == name else {
            return false
        }
        guard let result = components.queryItems?.first(where: { $0.name == "result" })?.value else {
            return false
        }
        guard let data = Data(base64Encoded: result) else {
            return false
        }
        completion(data)
        return true
    }
}
