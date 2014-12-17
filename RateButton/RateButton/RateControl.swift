//
//  RateControl.swift
//  Eventor
//
//  Created by Rostyslav Kobizsky on 12/17/14.
//  Copyright (c) 2014 Rozdoum. All rights reserved.
//

import UIKit

class RateControl: UIControl {
    
    private let emptyStartSymbol = "☆"
    private let fillStartSymbol  = "★"

    private var label = UILabel()
    var rateMax: Int = 5
    var rate: Int? {
        didSet {
            var resultString = ""
            
            for index in 0..<rateMax {
                resultString += index >= rate ? emptyStartSymbol : fillStartSymbol
            }
        
            label.text = resultString
                
        }
    }

    override func awakeFromNib() {
        label.frame = self.bounds
        
        label.textColor = self.tintColor
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 8
        label.userInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: "pan:")
        panGesture.minimumNumberOfTouches = 1
        label.addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: "pan:")

        label.addGestureRecognizer(panGesture)
        label.addGestureRecognizer(tapGesture)
        self.addSubview(label)
        rate = 0
    }
    
    func pan(sender: UIGestureRecognizer) {
        switch sender.state {
        case .Changed, .Began, .Ended:
            let translate = sender.locationInView(sender.view!)
            rate = Int((translate.x / label.bounds.size.width) * CGFloat(rateMax + 1))
        default:
            return
        }
    }
    
    override func layoutSubviews() {
        label.font = UIFont.systemFontOfSize(bounds.size.height * 0.6)
        label.sizeToFit()
        label.center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    }
}
