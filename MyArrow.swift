//
//  MyArrow.swift
//  Gradients
//
//  Created by Лилия Левина on 22/05/2019.
//  Copyright © 2019 Лилия Левина. All rights reserved.
//

import UIKit

class MyArrow: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drawGradientArrow()
    }
    
    func drawGradientArrow(){
        // obtain the current graphics context
        let con = UIGraphicsGetCurrentContext()!
        //punch triangular hole in context clipping region
        con.move(to: CGPoint(x: 10, y: 100))
        con.addLine(to: CGPoint(x: 20, y: 90))
        con.addLine(to: CGPoint(x: 30, y: 100))
        con.closePath()
        con.addRect(con.boundingBoxOfClipPath)
        con.clip(using: .evenOdd)
        // draw the vertical line, add its shape to the clipping region
        con.move(to: CGPoint(x: 20, y: 100))
        con.addLine(to: CGPoint(x: 20, y: 19))
        con.setLineWidth(20)
        con.replacePathWithStrokedPath()
        con.clip()
        // draw the gradient
        let locs: [CGFloat] = [0.0, 0.5, 1.0]
        let colors: [CGFloat] = [
        0.8, 0.4,//starting color, transparent light gray
        0.1, 0.5,// intermediate color, darker less transparent gray
        0.8, 0.4,// ending color, transperent light gray
        ]
        let sp = CGColorSpaceCreateDeviceGray()
        let grad = CGGradient(colorSpace: sp, colorComponents: colors, locations: locs, count: 3)!
        con.drawLinearGradient(grad, start: CGPoint(x: 10, y: 0), end: CGPoint(x: 30, y: 0), options: [])
        con.resetClip()//done clipping
        con.setFillColor(UIColor.red.cgColor)
        con.move(to: CGPoint(x: 0, y: 25))
        con.addLine(to: CGPoint(x: 20, y: 0))
        con.addLine(to: CGPoint(x: 40, y: 25))
        con.fillPath()
    }
    
}
