//
//  GraphView.swift
//  iWallet
//
//  Created by Alessandro Bonardi on 26/10/2016.
//  Copyright © 2016 Alessandro Bonardi. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    @IBInspectable var expenseBudgetRatio: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let borderWidth: CGFloat = 10.0
        let startAngle: CGFloat = CGFloat(M_PI / 2)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2),
                                      radius: CGFloat((self.frame.size.width - borderWidth) / 2),
                                      startAngle: CGFloat(startAngle),
                                      endAngle: CGFloat(CGFloat(2 * M_PI) + startAngle),
                                      clockwise: true)
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.green.cgColor
        circleLayer.lineWidth = borderWidth

        let expensePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2),
                                      radius: CGFloat((self.frame.size.width - borderWidth) / 2),
                                      startAngle: CGFloat(startAngle),
                                      endAngle: CGFloat(startAngle + CGFloat(2 * M_PI * expenseBudgetRatio)),
                                      clockwise: true)
        let expenseCircleLayer = CAShapeLayer()
        expenseCircleLayer.path = expensePath.cgPath
        expenseCircleLayer.fillColor = UIColor.clear.cgColor
        expenseCircleLayer.strokeColor = UIColor.red.cgColor
        expenseCircleLayer.lineWidth = borderWidth
        
        self.layer.addSublayer(circleLayer)
        self.layer.addSublayer(expenseCircleLayer)
    }

}
