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

//// MARK: - Token Operation Type
//public enum PickerType: String {
//    case add = "A"
//    case update = "U"
//    case delete = "D"
//}
//
//// MARK: - UWInitializer
//public final class UWInitializer {
//
//    // MARK: - Required
//    public let amount: String
//    public let email: String
//    public let currency: String
//    public let country: String
//    public let actionCode: String
//    public let trackIdCode: String
//  
//
//    // MARK: - Optional / Configurable
//    public let zipCode: String?
//    public let city: String?
//    public let address: String?
//    public let state: String?
//    public let transid: String?
////    public let merchantIdentifier: String?
//
//    public let createTokenIsEnabled: Bool
//
//    // MARK: - Card / Token
//    public let cardToken: String?
//    public let cardOperation: String
////    public let paymentTokenString: String?
//
//
//
//    // MARK: - Metadata
//    public let metaData: String?
//    
//    // MARK: - New Request Object
//
//       public let request: [String: Any]
//
//       //=========================================================
//       // New Initializer (JSON Request)
//       //=========================================================
//
//       public init(request: [String: Any]) {
//
//
//           self.request = request
//          
//                  self.amount = ""
//                  self.email = ""
//                  self.currency = ""
//                  self.country = ""
//                  self.actionCode = ""
//                  self.trackIdCode = ""
//
//                  self.zipCode = nil
//                  self.city = nil
//                  self.address = nil
//                  self.state = nil
//                  self.transid = nil
//
//                  self.createTokenIsEnabled = false
//
//                  self.cardToken = nil
//                  self.cardOperation = ""
//
//                  self.metaData = nil
//              }
//    
//
//    // MARK: - Initializer
//    public init(
//        amount: String,
//        email: String,
//        zipCode: String? = nil,
//        currency: String,
//        country: String,
//        actionCode: String,
//        trackIdCode: String,
//        city: String? = nil,
//        address: String? = nil,
//        state: String? = nil,
//        transid: String? = nil,
//        
//        createTokenIsEnabled: Bool = true,
//        cardToken: String? = nil,
//        cardOper: String? = nil, // Make this optional too
//       
//       
//        metaData: String? = nil
//    ) {
//
//        self.amount = amount
//        self.email = email
//        self.zipCode = zipCode
//        self.currency = currency
//        self.country = country
//        self.actionCode = actionCode
//        self.trackIdCode = trackIdCode
//
//        self.city = city
//        self.address = address
//        self.state = state
//        self.transid = transid
//      
//
//        self.createTokenIsEnabled = createTokenIsEnabled
//
//        self.cardToken = cardToken
//        self.cardOperation = cardOper ?? ""
//    
//     
//
//
//        self.metaData = metaData
//        
//        self.request = [
//
//                    "paymentType": actionCode,
//
//                    "currency": currency,
//
//                    "amount": amount,
//
//                    "order": [
//                        "orderId": trackIdCode,
//                        "description": ""
//                    ],
//
//                    "customer": [
//                        "customerEmail": email,
//                        "billingAddressStreet": address ?? "",
//                        "billingAddressCity": city ?? "",
//                        "billingAddressState": state ?? "",
//                        "billingAddressPostalCode": zipCode ?? "",
//                        "billingAddressCountry": country
//                    ],
//
//                    "additionalDetails": [
//                        "userData": metaData ?? ""
//                    ],
//
//                    "tokenization": [
//                        "cardToken": cardToken ?? "",
//                        "operation": cardOper ?? ""
//                    ]
//                ]
//    }
//}
//
// MARK: - Apple Pay Helper
extension UWInitializer {

    /// Generates Apple Pay payment token payload (Swift-safe)


    public static func generatePaymentKey(payment: PKPayment) -> String {

        let paymentDataBase64 = payment.token.paymentData.base64EncodedString()
        let method = payment.token.paymentMethod

        let payload: [String: Any] = [
            "paymentData": paymentDataBase64,
            "paymentMethod": [
                "displayName": method.displayName ?? "",
                "network": method.network?.rawValue ?? "",
                "type": "debit"
            ],
            "transactionIdentifier": payment.token.transactionIdentifier
        ]

        guard
            let jsonData = try? JSONSerialization.data(
                withJSONObject: payload,
                options: []
            ),
            let jsonString = String(data: jsonData, encoding: .utf8)
        else {
            return ""
        }

        return jsonString
    }

}
