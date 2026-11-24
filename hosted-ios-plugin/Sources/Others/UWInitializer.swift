////
////  UWInitializer.swift
////  Hosted plugin
////

import Foundation
import UIKit
import PassKit
//


public final class UWInitializer {

    public let request: [String: Any]

    public init(paymentRequest: PaymentRequest) {
        self.request = paymentRequest.toDictionary()
    }
}


// MARK: - Apple Pay Helper
extension UWInitializer {

    /// Generates Apple Pay payment token payload (Swift-safe)


    public static func generatePaymentKey(payment: PKPayment) -> String {

        let method = payment.token.paymentMethod
        let paymentData = payment.token.paymentData




        print("Payment Data Length:", paymentData.count)

        // Step 1: Check empty data
        guard !paymentData.isEmpty else {
            print("ERROR: Apple Pay paymentData is empty")
            return ""
        }

        do {
            // Step 2: Convert Apple Pay Data to JSON object
            let paymentTokenJSON = try JSONSerialization.jsonObject(
                with: paymentData,
                options: []
            )

            // Step 3: Create payload
            let payload: [String: Any] = [
                "paymentData": paymentTokenJSON,
                "paymentMethod": [
                    "displayName": method.displayName ?? "",
                    "network": method.network?.rawValue ?? "",
                    "type": "debit"
                ],
                "transactionIdentifier": payment.token.transactionIdentifier
            ]

            // Step 4: Validate JSON
            guard JSONSerialization.isValidJSONObject(payload) else {
                print("ERROR: Invalid Apple Pay JSON payload")
                return ""
            }

            // Step 5: Convert payload into JSON Data
            let jsonData = try JSONSerialization.data(
                withJSONObject: payload,
                options: []
            )

            // Step 6: Convert JSON Data to String
            guard let jsonString = String(
                data: jsonData,
                encoding: .utf8
            ) else {
                print("ERROR: Unable to convert JSON Data to String")
                return ""
            }

            print("Apple Pay JSON generated successfully")

            return jsonString

        } catch {
            print("Apple Pay JSON conversion failed: \(error)")
            return ""
        }
    }

}
