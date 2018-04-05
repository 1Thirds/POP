//
//  Utils.swift
//  TVCCYA
//
//  Created by James Frys on 3/18/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let mainDarkGray = UIColor.rgb(red: 125, green: 125, blue: 125)
    
    static let sliderDarkGray = UIColor.rgb(red: 175, green: 180, blue: 190)
    
    static let mainLightGray = UIColor.rgb(red: 184, green: 189, blue: 198)

    static let mainBlue = UIColor.rgb(red: 11, green: 90, blue: 138)
    
    static let mainLightBlue = UIColor.rgb(red: 59, green: 122, blue: 161)
    
    static let cellBlue = UIColor.rgb(red: 108, green: 156, blue: 184)
    
    static let extraLightBlue = UIColor.rgb(red: 230, green: 238, blue: 243)

    static let mainDarkGreen = UIColor.rgb(red: 32, green: 81, blue: 83)
    
    static let sliderDarkGreen = UIColor.rgb(red: 117, green: 181, blue: 143)
    
    static let sliderGreen = UIColor.rgb(red: 121, green: 187, blue: 146)
    
    static let mainLightGreen = UIColor.rgb(red: 138, green: 196, blue: 163)
    
    static let doneGreen = UIColor.rgb(red: 80, green: 154, blue: 111)
    
    static let mainDarkRed = UIColor.rgb(red: 134, green: 86, blue: 86)
    
    static let mainRed = UIColor.rgb(red: 153, green: 98, blue: 98)
    
    static let sliderLightRed = UIColor.rgb(red: 168, green: 107, blue: 107)
    
    static let sliderDarkOrange = UIColor.rgb(red: 188, green: 106, blue: 76)
    
    static let mainOrange = UIColor.rgb(red: 198, green: 113, blue: 81)
    
    static let mainLightOrange = UIColor.rgb(red: 215, green: 155, blue: 133)
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        } else {
            quotient = secondsAgo / month
            unit = "month"
        }
        
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
    }
}

extension UIImage {
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UISlider {
    public func setSliderValue(value: Float, duration: Double) {
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.setValue(self.value, animated: true)
            
        }) { (bol) -> Void in
            UIView.animate(withDuration: duration, animations: { () -> Void in
                self.setValue(value, animated: true)
            }, completion: nil)
        }
        
    }
}

