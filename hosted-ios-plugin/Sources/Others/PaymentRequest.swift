//
//  PaymentRequest.swift
//  
//

import Foundation

public class PaymentRequest {

    public var amount: String = ""
    public var actionCode: String = ""
    public var currency: String = ""

    public var email: String = ""
    public var address: String = ""
    public var city: String = ""
    public var stateCode: String = ""
    public var zip: String = ""
    public var countryCode: String = ""

    public var trackId: String = ""

    public var cardOperation: String = ""
    public var cardToken: String = ""
    public var tokenType: String = ""

    public var transactionId: String = ""

    public var metadata: String = ""
    public var paymentToken: [String: Any]?

    // Dynamic object like airline, hotel, insurance etc.
    public var airlineData: [String: Any]?

    public init() {
    }

    public func toDictionary() -> [String: Any] {

        var request: [String: Any] = [

            "paymentType": actionCode,

            "currency": currency,

            "amount": amount,

            "order": [
                "orderId": trackId,
                "description": ""
            ],

            "customer": [
                "customerEmail": email,
                "billingAddressStreet": address,
                "billingAddressCity": city,
                "billingAddressState": stateCode,
                "billingAddressPostalCode": zip,
                "billingAddressCountry": countryCode
            ],

            "additionalDetails": [
                "userData": metadata
            ],

            "tokenization": [
                "operation": cardOperation,
                "cardToken": cardToken,
                "tokenizationType": tokenType
            ],
            
        ]

        if let airline = airlineData {
            request["airline"] = airline
        }

        if !transactionId.isEmpty {
            request["referenceId"] = transactionId
        }

        if let paymentToken = paymentToken, !paymentToken.isEmpty {
            request["PaymentToken"] = paymentToken

            request["paymentInstrument"] = [
                "paymentMethod": "APPLEPAY"
            ]
        }
        return request
    }
}
