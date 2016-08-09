//
//  ShowAlert.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/9/16.
//  Copyright © 2016 Diogo. All rights reserved.
//
import UIKit

protocol ShowAlert { }

extension ShowAlert where Self: UIViewController {

	func showAlertWithTitle(title: String, message: String) {
		let alertController = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .Alert)

		let OKAction = UIAlertAction(title: "Ok", style: .Default) { _ in }

		alertController.addAction(OKAction)
		presentViewController(alertController, animated: true) { }
	}

}
