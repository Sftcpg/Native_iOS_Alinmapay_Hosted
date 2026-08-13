
//
//  PaymentConfiguration.swift

 
import Foundation
import UIKit


public class PaymentConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> PaymentViewController {
        guard let controller = getController("Main", "PaymentViewController") as? PaymentViewController else {return PaymentViewController()}
        let router = PaymentRouter(view: controller)
        let presenter = PaymentPresenter(view: controller)
        let manager = PaymentManager()
        let interactor = PaymentInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
    
    static func buildlog()
    {
        #if DEBUG
        print("Debug log: Plugin Installed Sucessfully")
        #else
        NSLog("Release log: Plugin Installed Sucessfully")
        #endif
        
        
        let actionMessage = "Performing action in Payment Plugin"
          print(actionMessage)
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            print("Application Version: \(version)")
          }
       if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
           print("Build Version in application: \(build)")
       }
    }
}

