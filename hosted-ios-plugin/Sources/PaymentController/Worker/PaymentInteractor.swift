
//
//  PaymentInteractor.swift


import UIKit
import CommonCrypto


protocol IPaymentInteractor: AnyObject {
   
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
        let request = model.request
        let terminalId : String = Common.Globle.terminalId
        let password : String = Common.Globle.password
        let merchantKey : String = Common.Globle.merchantKey
       // let urrlData : String = Common.Globle.
        let order = request["order"] as? [String: Any] ?? [:]
        let customer = request["customer"] as? [String: Any] ?? [:]
        let additional = request["additionalDetails"] as? [String: Any] ?? [:]
        let tokenization = request["tokenization"] as? [String: Any] ?? [:]
        let trackID :String = order["orderId"] as? String ?? ""
       
        let amount = request["amount"] as? String ?? ""
        let customerEmail = customer["customerEmail"] as? String ?? ""
        let address = customer["billingAddressStreet"] as? String ?? ""
        let city: String = customer["billingAddressCity"] as? String ?? ""
        let transId = request["referenceId"] as? String ?? ""
        let state = customer["billingAddressState"] as? String ?? ""
        let action = request["paymentType"] as? String ?? ""
        let country = customer["billingAddressCountry"] as? String ?? ""
        let currency = request["currency"] as? String ?? ""
        let zipCode = customer["billingAddressPostalCode"] as? String ?? ""
        let tokenOperation = tokenization["operation"] as? String ?? ""
        let cardToken = tokenization["cardToken"] as? String ?? ""
        //let isApplePay: String = model.isApplePay ?? "0"
        //let holderName: String = model.holderName ?? ""
//        let paymentTokenString: String = request[paymentTokenString] as? String ?? ""
   
       // print("isApplePay : \(isApplePay)")
        let metaData = additional["userData"] as? String ?? ""
        
        
        data = "\(trackID)|\(terminalId)|\(password)|\(merchantKey)|\(amount)|\(currency)"
        print("data : \(data)")
        
        requestHash = sha256(str: data)
        
        //z
        var deviceInfo:[String: Any] = [:]
        var deviceInfoJsonString:String = ""
        
        //
        var paymentInstrument :[String: Any] = [:]
        var paymentJsonString:String = ""
        
        

        
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

        let strIPAddress = Validator().getWiFiAddress()
        

        var parameters = request

        parameters["terminalId"] = terminalId
        parameters["password"] = password
        parameters["signature"] = requestHash

        parameters["deviceInfo"] = deviceInfo

        parameters["customerIp"] = strIPAddress
        parameters["merchantIp"] = strIPAddress
//        parameters["paymentTokenString"] = paymentTokenString
        var requestparam : String = ""
        do {
            let respjsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
               let respjsonString = String(data: respjsonData, encoding: .utf8)!
                 print("Request Body", respjsonString )
            requestparam = respjsonString
        }
        catch {
            print("Error: cannot create JSON from todo")
            return
        }
    
        var urrl = Common.Globle.url
        print("Request URL : \( urrl )")
        
        guard let url = URL(string: urrl) else {
            return
        }

        var urlRequest = URLRequest(url: url)
        
       
        do {

            let postData = try JSONSerialization.data(
                withJSONObject: parameters,
                options: [.prettyPrinted]
            )
            if let req = String(data: postData, encoding: .utf8) {
         
                //print("Api REQ Body: \(req)")
               
            }
            urlRequest.httpBody = postData

            if let json = String(data: postData, encoding: .utf8) {
//                print("Request Body:\(json)")
//                print(json)
            }

        } catch {
            print(error.localizedDescription)
            return
        }
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                print("Error fetching data: \(String(describing: error))")
                return
            }
       
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


