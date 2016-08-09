//
//  UITableView.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/9/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import UIKit

extension UITableView {

	func register<T: UITableViewCell where T: ReusableView>(_: T.Type) {
		registerNib(UINib(nibName: T.reuseIdentifier, bundle: nil),
			forCellReuseIdentifier: T.reuseIdentifier)
	}

	func dequeueReusableCell<T: UITableViewCell where T: ReusableView>(forIndexPath indexPath: NSIndexPath) -> T {
		guard let cell = dequeueReusableCellWithIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as? T else {
			fatalError("Could not dequeue reusable cell with identifier: \(T.reuseIdentifier)")
		}

		return cell
	}
}
