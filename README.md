# Native iOS AlinmaPay Hosted SDK

The AlinmaPay Hosted iOS SDK enables merchants to integrate hosted payment functionality into their iOS applications.

The SDK supports installation using **CocoaPods** and **Swift Package Manager (SPM)**.

## Requirements

- iOS 12.0 or later
- Xcode
- Swift 5 or later

## Installation

### Option 1: CocoaPods

The AlinmaPay Hosted iOS SDK is available through CocoaPods.

Add the following dependency to your application's `Podfile`:

```ruby
pod 'hosted-ios-alinmapay', '1.0.0'
```

Install the dependency:

```bash
pod install
```

Open the generated `.xcworkspace` file in Xcode.

**Note:** CocoaPods integration remains supported at version `1.0.0`.

### Option 2: Swift Package Manager (SPM)

The AlinmaPay Hosted iOS SDK supports source-based integration through Swift Package Manager.

**SPM Repository URL:**

```text
https://github.com/Sftcpg/Native_iOS_Alinmapay_Hosted.git
```

**Available SPM version:** `1.0.1`

#### Installation using Xcode

1. Open your iOS application in Xcode.
2. Navigate to **File → Add Package Dependencies**.
3. Enter the SPM repository URL provided above.
4. Select **Exact Version** and enter `1.0.1`.
5. Click **Add Package**.
6. Select the `HostedIOSAlinmapay` library product and add it to your application target.
7. Build your application to verify integration.

#### Import the SDK

Add the following import statement to the Swift file where you want to use the SDK:

```swift
import HostedIOSAlinmapay
```


## Repository

https://github.com/Sftcpg/Native_iOS_Alinmapay_Hosted



## License

This project is distributed under the MIT License. See the [LICENSE](LICENSE) file for details.
