//
//  RNPixelColor.swift
//  RNPixelColor
//
//  Created by Chris LeBlanc on 1/23/17.
//  Copyright © 2017 Atticus White. All rights reserved.
//

import UIKit

extension UIImage {
    
    func pixelColor(atPoint point: CGPoint) -> UIColor? {
        guard let pixelData = self.cgImage?.dataProvider?.data else {
            return nil
        }
        
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(self.size.width) * Int(point.y)) + Int(point.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        debugPrint("Color - Red: \(r), Green: \(g), Blue: \(b), Alpha: \(a)")
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    @objc func getHex(name: )
}
