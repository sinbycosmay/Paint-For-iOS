//
//  ViewController.swift
//  canvas
//
//  Created by Tanmay Arora on 16/01/19.
//  Copyright © 2019 Tanmay Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the xsview, typically from a nib.
    }

    @IBOutlet weak var Canvas: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    
    
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        swiped = false
        lastPoint = touch.location(in: view)
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        Canvas.image?.draw(in: view.bounds)
        
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        
        // path is created
        context.strokePath()
    
        
        Canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        Canvas.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        
        swiped = true
        let currentPoint = touch.location(in: view)
        drawLine(from: lastPoint, to: currentPoint)
        
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            
            drawLine(from: lastPoint, to: lastPoint)
        }
        
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        Canvas?.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        Canvas.image = nil
    }
    
    
    @IBAction func Reset() {
        mainImageView.image = nil
    }
    
    @IBAction func red(_ sender: UIButton) {
        color = UIColor.red
    }
    
    @IBAction func green(_ sender: UIButton) {
        color = UIColor.green
    }
    
    @IBAction func eraser(_ sender: UIButton) {
        color = UIColor.white
    }
    
    @IBAction func blue(_ sender: UIButton) {
        color = UIColor.blue
    }
    
    @IBAction func black() {
        color = UIColor.black
    }
    
}

