//
//  ReusableView.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/4/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import UIKit

protocol ReusableView { }

extension ReusableView where Self: UIView {

	static var reuseIdentifier: String { return String(self) }
}