//
//  PaymentPresenter.swift


import UIKit

protocol IPaymentPresenter: class {
    // do someting...
    
    func apiResult(result: paymentResult, response: String  , error: Error? )
}

class PaymentPresenter: IPaymentPresenter {
    
    weak var view: IPaymentViewController?
    
    init(view: IPaymentViewController?) {
        self.view = view
    }
    
  
    
    func apiResult(result: paymentResult,response: String ,  error: Error?) {
        view?.apiResult(result: result, response: response ,  error: error)
    }
}
