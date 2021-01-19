// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit
import SwiftUI
import TrustSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        TrustSDK.initialize(with: TrustSDK.Configuration(scheme: "trustsdk"))

		
		window = UIWindow(frame: UIScreen.main.bounds)
		
		if let window = window {
			window.backgroundColor = UIColor.white
			window.rootViewController = UIHostingController(rootView: AppView())
			window.makeKeyAndVisible()
		}
		
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return TrustSDK.application(app, open: url, options: options)
    }
}
