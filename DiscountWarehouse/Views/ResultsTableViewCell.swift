//
//  ResultsTableViewCell.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/4/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewPlaceholder: UIView! {
        didSet { viewPlaceholder.graySquareBorder() }
    }
    
    @IBOutlet weak var laPlaceHolder: UILabel!
    @IBOutlet weak var laPrice: UILabel!
    
    @IBOutlet weak var laTags: UILabel!
    @IBOutlet weak var bBuy: UIButton! {
        didSet { bBuy.redSquareStyle() }
    }
    
    @IBAction func buyPressed(sender: UIButton) {
        
    }
    
}
