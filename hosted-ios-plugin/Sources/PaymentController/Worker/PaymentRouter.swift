//
//  PaymentRouter.swift

import UIKit

protocol IPaymentRouter: AnyObject {
	// do someting...
}

class PaymentRouter: IPaymentRouter {	
	weak var view: PaymentViewController?
	
	init(view: PaymentViewController?) {
		self.view = view
	}
}
