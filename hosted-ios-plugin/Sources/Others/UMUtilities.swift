//
//  UMUtilities.swift
//  directpg
//



import Foundation
import UIKit
//import SwiftPublicIP


public struct ZDLUtility {
    public static func getBundle() -> Bundle? {
        var bundle: Bundle?
        if let urlString = Bundle.main.path(forResource:"Payments", ofType: "framework", inDirectory: "Frameworks")
        {
            bundle = (Bundle(url: URL(fileURLWithPath: urlString)))
        }
        return bundle
    }
}


func getController(
    _ storyBoardName: String,
    _ identifier: String
) -> UIViewController {

    #if SWIFT_PACKAGE
    let bundle = Bundle.module
    #else
    let bundle = Bundle(for: PaymentViewController.self)
    #endif

    print("Storyboard Name: \(storyBoardName)")
    print("Storyboard Bundle: \(bundle.bundlePath)")

    return UIStoryboard(
        name: storyBoardName,
        bundle: bundle
    ).instantiateViewController(
        withIdentifier: identifier
    )
}


internal class Common: NSObject {

    internal struct Globle
    {
            static var terminalId = "" // termilan provided by Client
            static var password = "" // password provided by Client
            static var merchantKey = ""
            static var url = ""
            static var merchantIdentifier=""
    }
}

internal struct Validator {
    func checkMandatoryFields(for model: UWInitializer) -> paymentResult {

        print("In Validation")

        let request = model.request

        let paymentType = request["paymentType"] as? String ?? ""
        let amount = request["amount"] as? String ?? ""
        let currency = request["currency"] as? String ?? ""

        let order = request["order"] as? [String: Any] ?? [:]
        let customer = request["customer"] as? [String: Any] ?? [:]
        let additional = request["additionalDetails"] as? [String: Any] ?? [:]
        let tokenization = request["tokenization"] as? [String: Any] ?? [:]

        let email = customer["customerEmail"] as? String ?? ""
        let country = customer["billingAddressCountry"] as? String ?? ""
        let trackId = order["orderId"] as? String ?? ""

        let transId = request["referenceId"] as? String ?? ""

        let cardOperation = tokenization["operation"] as? String ?? ""
        let cardToken = tokenization["cardToken"] as? String ?? ""

        let metadata = additional["userData"] as? String ?? ""

       // print(paymentType)
       // print(amount)
      //  print(email)
        if !isValidAmount(enteredAmount: amount) {
            return .mandatory(.amount)
        }

        if !isValidEmail(enteredEmail: email) {
            return .mandatory(.email)
        }

        if !isValidcountry(enteredcountry: country) {
            return .mandatory(.country)
        }

        if !isValidcurrency(enteredcurrency: currency) {
            return .mandatory(.currency)
        }

        if paymentType == "12" && cardOperation.isEmpty {
            return .mandatory(.cardOperation)
        }

        if transId.isEmpty &&
            ["2", "3", "6", "9", "10"].contains(paymentType) {
            return .mandatory(.transid)
        }

        if trackId.isEmpty {
            return .mandatory(.trackId)
        }

        if paymentType.isEmpty || paymentType == "0" {
            return .mandatory(.action_code)
        }
        
        if let _ = request["airline"] as? [String: Any] {

            if paymentType != "1" && paymentType != "4" {

                return .mandatory(.action_code)

            }

        }
        
        return .sucess
    }
    
    
    
    func checkActionCode(code: String , tokenEnabled: Bool) -> Bool{
        
       
        if (!tokenEnabled && code == "12" && (Int(code) ?? .zero) > 0 && (Int(code) ?? .zero) < 99){
            return false
        }
        return true
    }
    
    func isValidAmount(enteredAmount:String) -> Bool {
        let amountFormat = Float(enteredAmount)
        return amountFormat != nil
    }
    
    
    
    func isValidEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    
    
    func isValidcountry(enteredcountry:String) -> Bool {
        let countryFormat = "[A-Za-z]{2}"
        let countryPredicate = NSPredicate(format:"SELF MATCHES %@", countryFormat)
        return countryPredicate.evaluate(with: enteredcountry)
    }
    
    
    
    func isValidcurrency(enteredcurrency:String) -> Bool {
        let currencyFormat = "[A-Za-z]{3}"
        let currncyPredicate = NSPredicate(format:"SELF MATCHES %@", currencyFormat)
        return currncyPredicate.evaluate(with: enteredcurrency)
    }
    
    
    
    func isValidActioncode(enteredaction:String) -> Bool {
        let actionFormat = "[1-99]"
        let actionPredicate = NSPredicate(format:"SELF MATCHES %@", actionFormat)
        return actionPredicate.evaluate(with: enteredaction)
    }
    
    
    
    
    
    func isValidZipcode(enteredzipcode:String) -> Bool {
        let zipcodeFormat = "[0-9]{6}"
        let zipcodePredicate = NSPredicate(format:"SELF MATCHES %@", zipcodeFormat)
        return zipcodePredicate.evaluate(with: enteredzipcode)
    }

    func isValidtrack(enteredtrack:String) -> Bool {
        let trackFormat = "[A-Za-z0-9]"
        let trackPredicate = NSPredicate(format:"SELF MATCHES %@", trackFormat)
        return trackPredicate.evaluate(with: enteredtrack)
    }
    
    
  
//    func getWiFiAddress() -> String {
//        var address : String?
//
//        // Get list of all interfaces on the local machine:
//        var ifaddr : UnsafeMutablePointer<ifaddrs>?
//        guard getifaddrs(&ifaddr) == 0 else { return "" }
//        guard let firstAddr = ifaddr else { return "" }
//
//        // For each interface ...
//        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
//            let interface = ifptr.pointee
//
//            // Check for IPv4 or IPv6 interface:
//            let addrFamily = interface.ifa_addr.pointee.sa_family
//            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
//
//                // Check interface name:
//                let name = String(cString: interface.ifa_name)
//                print(name)
//                if  name == "en0" {
//
//                    // Convert interface address to a human readable string:
//                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
//                                &hostname, socklen_t(hostname.count),
//                                nil, socklen_t(0), NI_NUMERICHOST)
//                    address = String(cString: hostname)
//                } else if name == "en1" {
//                    // Convert interface address to a human readable string:
//                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
//                                &hostname, socklen_t(hostname.count),
//                                nil, socklen_t(1), NI_NUMERICHOST)
//                    address = String(cString: hostname)
//                }
//                else if  name == "en2" || name == "en3" || name == "en4"  {
//                                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//                                    getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(2), NI_NUMERICHOST)
//                                    address = String(cString: hostname)
//                                }
//            }
//        }
//        freeifaddrs(ifaddr)
//print("IP MEthod " ,address)
//        return address ?? ""
//    }
    func getWiFiAddress() -> String {
        var address : String?
//        SwiftPublicIP.getPublicIP(url: PublicIPAPIURLs.ipv4.icanhazip.rawValue) { (string, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let string = string {
//                print("PUBLIC IP ",string) // Your IP address
//                address = string
//            }
//}
//        5123451203580008
        address = try? String(contentsOf: URL(string: "https://api.ipify.org")!, encoding: .utf8)
        print(address as Any)
        return address ?? ""
    }
}

