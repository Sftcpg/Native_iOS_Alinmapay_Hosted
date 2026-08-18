import Foundation

extension Foundation.Bundle {
    static let module: Bundle = {
        let mainPath = Bundle.main.bundleURL.appendingPathComponent("hosted-ios-plugin_hosted-ios-plugin.bundle").path
        let buildPath = "/Users/admin/Documents/iOS/ClickPay/Bitbucket/iOS-Hosted-Plugin/.build/arm64-apple-macosx/debug/hosted-ios-plugin_hosted-ios-plugin.bundle"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle ?? Bundle(path: buildPath) else {
            // Users can write a function called fatalError themselves, we should be resilient against that.
            Swift.fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}