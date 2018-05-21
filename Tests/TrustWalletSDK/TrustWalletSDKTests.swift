// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import BigInt
import TrustCore
import TrustWalletSDK
import XCTest

class TrustWalletSDKTests: XCTestCase {
    var delegate: MockWalletDelegate! // swiftlint:disable:this weak_delegate

    override func setUp() {
        super.setUp()
        delegate = MockWalletDelegate()
    }

    func testHandleSignMessage() {
        let sdk = TrustWalletSDK(delegate: delegate)
        let url = URL(string: "trust://sign-message?message=EjQ%3D&callback=app://sign-message")!
        let handled = sdk.handleOpen(url: url)

        XCTAssertTrue(handled)
        XCTAssertEqual(delegate.providedMessage, Data(hexString: "1234"))
    }

    func testHandleSignTransaction() {
        let sdk = TrustWalletSDK(delegate: delegate)
        let url = URL(string: "trust://sign-transaction?gasPrice=0&gasLimit=10&to=0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed&amount=100&callback=app://sign-transaction")!
        let handled = sdk.handleOpen(url: url)

        XCTAssertTrue(handled)
        XCTAssertEqual(delegate.providedTransaction?.gasPrice, 0)
        XCTAssertEqual(delegate.providedTransaction?.gasLimit, 10)
        XCTAssertEqual(delegate.providedTransaction?.to, Address(string: "0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed"))
        XCTAssertEqual(delegate.providedTransaction?.amount, 100)
    }

    func testHandleError() {
        delegate.shouldFail = true
        let sdk = TrustWalletSDK(delegate: delegate)
        let url = URL(string: "trust://sign-transaction?gasPrice=0&gasLimit=10&to=0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed&amount=100&callback=app://sign-transaction")!
        let handled = sdk.handleOpen(url: url)

        XCTAssertTrue(handled)
    }
}

class MockWalletDelegate: WalletDelegate {
    var providedMessage: Data?
    var providedTransaction: Transaction?
    var shouldFail = false

    func signMessage(_ message: Data, address: Address?, completion: @escaping (Data?) -> Void) -> Void {
        if shouldFail {
            completion(nil)
            return
        }
        providedMessage = message
        completion(message)
    }

    func signTransaction(_ transaction: Transaction, completion: @escaping (Transaction?) -> Void) -> Void {
        if shouldFail {
            completion(nil)
            return
        }
        providedTransaction = transaction
        var signed = transaction
        signed.v = BigInt(1)
        signed.r = BigInt(2)
        signed.s = BigInt(3)
        completion(signed)
    }
}
