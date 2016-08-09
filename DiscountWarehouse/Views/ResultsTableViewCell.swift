//
//  ResultsTableViewCell.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/4/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import UIKit

protocol ResultsTableViewCellDelegate {
	func didPressBuy()
}

class ResultsTableViewCell: UITableViewCell {

	var delegate: ResultsTableViewCellDelegate?

	@IBOutlet weak var viewPlaceholder: UIView! {
		didSet { viewPlaceholder.graySquareBorder() }
	}

	@IBOutlet weak var laPlaceHolder: UILabel!
	@IBOutlet weak var laPrice: UILabel!
    @IBOutlet weak var laStock: UILabel!
    @IBOutlet weak var laStockPlaceholder: UILabel!

    
	@IBOutlet weak var laTags: UILabel!
	@IBOutlet weak var bBuy: UIButton! {
		didSet { bBuy.redSquareStyle() }
	}

	@IBAction func buyPressed(sender: UIButton) {
		UIView.transitionWithView(bBuy, duration: 0.7, options: [.TransitionFlipFromRight, .ShowHideTransitionViews], animations: {
			}, completion: { _ in
			self.delegate?.didPressBuy()
		})
	}
    
    func noStockMode() {
        laStock.text = String(0)
        bBuy.enabled = false
        bBuy.hidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bBuy.enabled = true
        bBuy.hidden = false
    }

}
