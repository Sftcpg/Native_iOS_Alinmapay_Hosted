
//
//  PaymentInteractor.swift


import UIKit
import CommonCrypto


protocol IPaymentInteractor: class {
    var parameters: [String: Any]? { get set }
    func postAPI(for model: UWInitializer)
}

var fullURL: String = ""

struct Item {
    let id: Int
    let name: String
    let description: String
}

class PaymentInteractor: IPaymentInteractor {
    func postAPI(for model: UWInitializer) {
        
 var requestHash:String = ""
        var data: String = ""
        
        let terminalId : String = Common.Globle.terminalId
        let password : String = Common.Globle.password
        let merchantKey : String = Common.Globle.merchantKey
       // let urrlData : String = Common.Globle.
        let trackid :String = model.trackIdCode
        //let merchantidentifier : String = model.merchantidentifier ?? ""
        let amount: String = model.amount
        let customerEmail: String = model.email
        let address: String = model.address ?? ""
        let city: String = model.city ?? ""
        let trackID: String = model.trackIdCode
        let transid: String = model.transid ?? ""
        let state: String = model.state ?? ""
        let action = model.actionCode
        let country: String = model.country
        let currency: String = model.currency
        let zipCode: String = model.zipCode ?? ""
        var tokenOperation: String = model.cardOperation ?? ""
        let cardTocken: String = model.cardToken ?? ""
      //  let tokenizationType: String = model.tokenizationType ?? "0"
        let holderName: String = model.holderName ?? ""
      //  let cardNumber: String = model.cardNumber ?? ""
      //  let cvv: String = model.cvv ?? ""
      //  let expMonth: String = model.expMonth ?? ""
      //  let expYear: String = model.expYear ?? ""
        
        let metaData: String = model.metaData ?? ""
        
        
        data = "\(trackid)|\(terminalId)|\(password)|\(merchantKey)|\(amount)|\(currency)"
        print("data : \(data)")
        
        requestHash = sha256(str: data)
        
        //z
        var deviceInfo:[String: Any] = [:]
        var deviceInfoJsonString:String = ""
        
        //
        var paymentInstrument :[String: Any] = [:]
        var paymentJsonString:String = ""
        
        
        var order :[String: Any] = [:]
        var orderJsonString:String = ""
        //
        var customer:[String: Any] = [:]
        var customerJsonString:String = ""
        
        
        //
        var tokenization :[String: Any] = [:]
        var  tokenizationJsonString :String = ""
        
        var carddetails :[String: Any] = [:]
        var cardJsonString:String = ""
        
        var additionaldetails :[String: Any] = [:]
        var additionalString:String = ""
//        "additionalDetails": {
//                "userData": "{\"entryone\":\"abc\",\"entrytwo\":\"def\",\"entrythree\":\"xyz\",\"receiptUrl\":\"http://10.10.8.90:8080/CORE_2.2.2/resultV2Page.jsp\"}"
//           }
//        }
        
        let ModelName = UIDevice.current.name
        let version = UIDevice.current.systemVersion
        let platfrom = UIDevice.current.model
        
        
        let myPodVersion = MyPodVersion.version
        print("My Pod Version: \(myPodVersion)")
        
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
        ]
        
        deviceInfo = [
            "pluginName": "Native iOS",
            "pluginVersion": myPodVersion,
            "clientPlatform": platfrom,
            "deviceModel": ModelName,
            "devicePlatform": platfrom,
            "deviceOSVersion": version
        ]
        
        customer = [
            
            "cardHolderName": holderName,
            "customerEmail":customerEmail,
            "billingAddressStreet": address,
            "billingAddressCity": city,
            "billingAddressState": state,
            "billingAddressPostalCode": zipCode,
            "billingAddressCountry": country
        ]
        
        
        tokenization = [
            "operation": tokenOperation,
            "cardToken": cardTocken
        ]
      //  print(deviceInfo)
        
        order = [
            "orderId": trackID
            
            
        ]
        
        paymentInstrument = [
            "paymentMethod": "DCI"
        ]
        
//        carddetails = [
//            "number": cardNumber,
//            "expiryMonth": expMonth,
//            "expiryYear": expYear,
//            "cvv": cvv
//        ]
        
        additionaldetails = [
            "userData": metaData
           
        ]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: deviceInfo, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)!
           // print("Device INFO JSON ", jsonString )
            deviceInfoJsonString = jsonString
            
            
            
            let orderjsonData = try JSONSerialization.data(withJSONObject: order, options: [])
            let orderjsonString = String(data: orderjsonData, encoding: .utf8)!
           // print("Order JSON ", orderjsonString )
            orderJsonString = orderjsonString
            
            
            
            let customerjsonData = try JSONSerialization.data(withJSONObject: customer, options: [])
            let custjsonString = String(data: customerjsonData, encoding: .utf8)!
           // print(" Customer JSON ", custjsonString )
            customerJsonString = custjsonString
            
            
            let instumentjsonData = try JSONSerialization.data(withJSONObject: paymentInstrument, options: [])
            let instrumentjsonString = String(data: instumentjsonData, encoding: .utf8)!
            //print("Instrument JSON ", instrumentjsonString )
            paymentJsonString = instrumentjsonString
            
            let cardjsonData = try JSONSerialization.data(withJSONObject: carddetails, options: [])
            let cardjsonString = String(data: cardjsonData, encoding: .utf8)!
          //  print("Card JSON ", cardjsonString )
            cardJsonString = cardjsonString
            
            
            let tokenizationjsonData = try JSONSerialization.data(withJSONObject: tokenization, options: [])
            let tokenjsonString = String(data: tokenizationjsonData, encoding: .utf8)!
            //print("tokenizationjsonData JSON ", tokenjsonString )
            tokenizationJsonString = tokenjsonString
            
        } catch  {
            print("error")
        }
        let strIPAddress = Validator().getWiFiAddress()
        print("iOS Hosted Framework initiated Successfully with version \(myPodVersion)")
        if let minimumOSVersion = Bundle.main.infoDictionary?["MinimumOSVersion"] as? String {
           // print("Minimum iOS Deployment Target*****: \(minimumOSVersion)")
            print("Expected Minimum iOS Deployment Target : 13.0 | Fount Minimum iOS Deployment Target : \(minimumOSVersion) ")
        }
        
        let osVersion = ProcessInfo.processInfo.operatingSystemVersion
        print("iOS version App installed : \(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)")
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        print("iOS Application Name : \(appName) ")
        
        let parameters = [
            
            "amount": amount,
           // "address": address,
            "customerIp": strIPAddress,
            // "city": city,
            "order": order,
            "terminalId": "\(terminalId)",
            "referenceId": transid,
            // "customer":customerJsonString,
          //  "applePayId": "applepay",
            "paymentType": action,
            "password": "\(password)",
            "merchantIp": strIPAddress,
            "signature": "\(requestHash)",
            "country": country,
            "currency": currency,
            "customer": customer,

            
            "tokenization": tokenization,
           // "paymentInstrument" : paymentInstrument,
            //"card":carddetails,
            "additionalDetails": additionaldetails,
            
         "deviceInfo": deviceInfoJsonString
            
            
        ] as [String : Any]
        
        var requestparam : String = ""
        
      
        //print("REQUEST: \(parameters)")
//        let jsonData = try JSONSerialization.data(withJSONObject: deviceInfo, options: [])
//        let jsonString = String(data: jsonData, encoding: .utf8)!
//        print("Device INFO JSON ", jsonString )
////        deviceInfoJsonString = jsonString
        do {
            let respjsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
               let respjsonString = String(data: respjsonData, encoding: .utf8)!
                 print("Request Body :  ", respjsonString )
            requestparam = respjsonString
        }
        catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
       // print("REQUEST2 : \( requestparam )")
        var urrl = Common.Globle.url
        print("Request URL : \( urrl )")
        
        guard let url = URL(string: urrl) else { return }
        
        let request = NSMutableURLRequest(url: url)
        do {
            let postData =  try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = postData
            //print("REQUEST: \(postData)")
        }
        catch {
            print("Error: cannot create JSON from todo")
            return
        }
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data else {
                print("Error fetching data: \(String(describing: error))")
                return
            }
           // print("Data \(data)")
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Api Response Body: \(rawResponse)")
               
            }
            do{
                let rawResponse = String(data: data, encoding: .utf8)
                

                
                if let json = self.parseRawResponse(data: data) {
                    if let code = json["responseCode"] as? String, code == "001" {
                        //print("Success of payment interactor")
                        if let paymentLinkDict = json["paymentLink"] as?  [String: Any] {
                            let linkurl =  paymentLinkDict["linkUrl"] as? String
                            let transid = json["transactionId"] as? String
                            let baseURL: String? = linkurl
                            let paymentId: String? = transid
                            let fulllink = (linkurl ?? "") + (transid ?? "")
                          //  print("Success of payment link 1")
                            print("Payment Link: \(fulllink)")
                            self.newURL = ""+fulllink
                            //open browswer with this url
                            
                            self.presenter?.apiResult(result: .sucess, response: self.newURL , error: error);
                        }
                    }
                    else
                    {
                        let rawResponse = String(data: data, encoding: .utf8)
                        self.presenter?.apiResult(result: .sucess, response: rawResponse ?? "" , error: error);
                    }
                }            } catch {
                print("Error decoding JSON: \(error)")
            }
//            -----------
            //self.presenter?.apiResult(result: .sucess, response: rawResponse, error: error)
//            do {
//                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
//                    print("Error: Could not parse JSON")
//                    return
//                }
//                // Print raw response data as a string
//                         if let rawResponse = String(data: data, encoding: .utf8) {
//                             print("Raw Response: \(rawResponse)")
//                         }
//                var items: [Item] = []
//                for dict in jsonArray {
//                    if let id = dict["id"] as? Int,
//                       let name = dict["name"] as? String,
//                       let description = dict["description"] as? String {
//                        let item = Item(id: id, name: name, description: description)
//                        items.append(item)
//                    }
//                }
//               // completion(items)
//            } catch {
//                print("Error decoding JSON: \(error)")
//            }
        }.resume()
        
    }
    
    var presenter: IPaymentPresenter?
    var manager: IPaymentManager?
    var parameters: [String: Any]?
    
    var newURL: String = ""
    var transID: String = ""
    var paymentID: String = ""
    init(presenter: IPaymentPresenter, manager: IPaymentManager)
    {
        self.presenter = presenter
        self.manager = manager
    }
    
    func parseRawResponse(data: Data) -> [String: Any]? {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return json
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
        return nil
    }
    
}


extension PaymentInteractor {
    
    func sha256(str: String) -> String {
        
        if let strData = str.data(using: String.Encoding.utf8) {
            var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
           _ = strData.withUnsafeBytes {
                CC_SHA256($0.baseAddress, UInt32(strData.count), &digest)
            }
            
            var sha256String = ""
            for byte in digest {
                sha256String += String(format:"%02x", UInt8(byte))
            }
            
            return sha256String
        }
        return ""
    }
    
  
    
}


