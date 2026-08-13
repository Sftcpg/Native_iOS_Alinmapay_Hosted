//
//  UWInitializer.swift
//  directpg
//
//  Created by Concerto on 10/10/24.
//


import Foundation
import UIKit
import PassKit

public enum pickerType: String {
    case add = "Add"
    case update = "Update"
    case delete = "Delete"
    
    func getValue() -> String {
        switch self {
        case .add:
            return "A"
        case .update:
            return "U"
        case .delete:
            return "D"
        }
    }
}

public class UWInitializer {
    var amount: String = ""
    var email: String = ""
    var currency: String = ""
    var country: String = ""
    var actionCode: String = ""
    var trackIdCode: String = ""
    
    var createTokenIsEnabled: Bool?
    var merchantIP: String?
    var address: String?
    var city: String?
    var cardToken: String?
    var cardOperation: String!
    var state: String?
    var zipCode: String?

    var transid: String?
    
    var merchantidentifier: String?
    var tokenizationType: String?
    var cardNumber: String?
    var cvv: String?
    var expMonth: String?
    var expYear: String?
    var holderName: String?
    var metaData: String?
    
    
    public init(amount: String ,
         email: String ,
         zipCode: String? = nil ,
         currency: String ,
         country: String ,
         actionCode: String,
         trackIdCode: String,

         city: String? = nil ,
         address: String? = nil,
                
         createTokenIsEnabled: Bool? = true,
         merchantIP: String? = nil,
         cardToken: String? = nil,
         cardOper: String,
         state: String? = nil,
         transid: String? = nil,
         merchantidentifier: String? = nil,
         tokenizationType: String,
         cardNumber: String? = nil,
         cvv: String? = nil,
         expMonth: String? = nil,
         expYear: String? = nil,
         holderName: String? = nil,
         metaData:String? = nil
         
    ){
        
        self.amount = amount
        self.email = email
        self.zipCode = zipCode
        self.currency = currency
        self.country = country
        self.actionCode = actionCode
        self.trackIdCode = trackIdCode

        self.state = state
        self.city = city
        self.address = address
        self.createTokenIsEnabled = createTokenIsEnabled
        self.merchantIP = merchantIP
        self.cardToken = cardToken
        self.cardOperation = cardOper
        //self.state = state
        
        self.tokenizationType = tokenizationType
        self.transid=transid
        self.merchantidentifier = merchantidentifier
        self.cardNumber = cardNumber
        self.cvv = cvv
        self.expMonth = expMonth
        self.expYear = expYear
        self.holderName = holderName
        self.metaData = metaData
    }

    public static func generatePaymentKey(payment: PKPayment) -> NSString {
        
        let data12 = payment.token.paymentData
        let method = payment.token.paymentMethod
        
        if let jsonString = NSString(data: data12, encoding: .zero) {
            
            let prefixString: NSString = "\("{ \"paymentData\"  : ")" as NSString
            let finalSuffixString: NSString = """
                , "paymentMethod": {
                "displayName": "\(method.displayName ?? "")",
                "network": "\(method.network?.rawValue ?? "")",
                "type": "debit"
                },
                "transactionIdentifier": "\(payment.token.transactionIdentifier)" }
                """ as NSString
            
            let combinderString: NSString = "\(prefixString) \(jsonString) \(finalSuffixString)" as NSString
            return combinderString
        }
        
        return ""
    }

}


