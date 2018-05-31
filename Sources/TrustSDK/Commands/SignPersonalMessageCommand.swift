// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import TrustCore

public final class SignPersonalMessageCommand: SignMessageCommand {
    override public var name: String {
        get {
            return "sign-personal-message"
        }
        set {}
    }
}
