import Foundation
import UIKit
import Charts

//MARK: - Redius & Border & Shadow
extension UIView {
    
    func Border_Radius(border_height: CGFloat, isborder: Bool, radius: CGFloat) {
        
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        
        if isborder {
            
            self.clipsToBounds = true
            self.layer.borderColor = UIColor(rgb: 2632252).cgColor
            self.layer.borderWidth = border_height
        }
    }
    
    func shadow(radius: Double) {
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = radius
    }
}


//MARK: - RGB Converter
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


//MARK: - RANDOM COLOR
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 0.80
        )
    }
}



//MARK: - Custome Segment Controller
@available(iOS 12.0, *)
extension UISegmentedControl{
    
    func removeBorder(){
        var bgcolor: CGColor
        var textColorNormal: UIColor
        var textColorSelected: UIColor
        
        if self.traitCollection.userInterfaceStyle == .dark {
            
            bgcolor = UIColor(rgb: 2632252).cgColor
            textColorNormal = UIColor.gray
            textColorSelected = UIColor.white
            
        } else {
            
            bgcolor = UIColor.clear.cgColor
            textColorNormal = UIColor.gray
            textColorSelected = UIColor.black
        }
        
        let backgroundImage = UIImage.getColoredRectImageWith(color: bgcolor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        
        let deviderImage = UIImage.getColoredRectImageWith(color: bgcolor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([.foregroundColor: textColorNormal, .font: UIFont(name: "Satoshi-Bold", size: 20) as Any], for: .normal)
        self.setTitleTextAttributes([.foregroundColor: textColorSelected], for: .selected)
    }
    
    func highlightSelectedSegment(){
        removeBorder()
        let lineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let lineHeight: CGFloat = 1.6
        let lineXPosition = CGFloat(selectedSegmentIndex * Int(lineWidth))
        let lineYPosition = self.bounds.size.height  - 2.0
        let underlineFrame = CGRect(x: lineXPosition, y: lineYPosition, width: lineWidth, height: lineHeight)
        let underLine = UIView(frame: underlineFrame)
        underLine.backgroundColor = AppColors.primaryColor // UIColor(rgb: 2632252) // bottom line color
        underLine.tag = 1
        self.addSubview(underLine)
    }
    
    func highlightSelectedSegment1(){
        removeBorder()
        let lineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let lineHeight: CGFloat = 1.6
        let lineXPosition = CGFloat(selectedSegmentIndex * Int(lineWidth))
        let lineYPosition = self.bounds.size.height + 20
        let underlineFrame = CGRect(x: lineXPosition, y: lineYPosition, width: lineWidth, height: lineHeight)
        let underLine = UIView(frame: underlineFrame)
        underLine.backgroundColor = UIColor(rgb: 2632252) // bottom line color
        underLine.tag = 1
        self.addSubview(underLine)
    }
    
    func shadeColorForSelectedSegment1() {
        var bgcolor: CGColor
        var textColorNormal: UIColor
        var textColorSelected: UIColor
        
        if self.traitCollection.userInterfaceStyle == .dark {
            
            bgcolor = UIColor(rgb: 2632252).cgColor
            textColorNormal = UIColor.gray
            textColorSelected = UIColor.white
            
        } else {
            
            bgcolor = UIColor.clear.cgColor
            textColorNormal = UIColor.gray
            textColorSelected = UIColor.black
        }
        
        let backgroundImage = UIImage.getColoredRectImageWith(color: bgcolor, andSize: self.bounds.size)
        
        let backgroundSelectedImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundSelectedImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        
        let deviderImage = UIImage.getColoredRectImageWith(color: bgcolor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        
        self.setTitleTextAttributes([.foregroundColor: textColorNormal, .font: UIFont(name: "Satoshi-Bold", size: 20) as Any], for: .normal)
        self.setTitleTextAttributes([.foregroundColor: textColorSelected], for: .selected)
        
        
        self.layer.cornerRadius = 0
        self.layer.masksToBounds = true
    }
    
    func fillSelectedSegment() {
        
        let backgroundImage = UIImage.getColoredRectImageWith(color: AppColors.primaryColorWith_25per_alpha.cgColor, andSize: self.bounds.size)
        let backgroundImageSelect = UIImage.getColoredRectImageWith(color: AppColors.primaryColor.cgColor, andSize: self.bounds.size)
        
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImageSelect, for: .selected, barMetrics: .default)
        
        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.clear.cgColor, andSize: CGSize(width: 5.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    func underlinePosition(){
        guard let underLine = self.viewWithTag(1) else {return}
        let xPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            underLine.frame.origin.x = xPosition
        })
    }
    
}

extension UIImage{
    
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}


//MARK: - Dismiss keybord
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UITextField {
    func setIcon(_ image: UIImage) {
       let iconView = UIImageView(frame:
                      CGRect(x: 10, y: 5, width: 20, height: 20))
       iconView.image = image
       let iconContainerView: UIView = UIView(frame:
                      CGRect(x: 20, y: 0, width: 30, height: 30))
       iconContainerView.addSubview(iconView)
       leftView = iconContainerView
       leftViewMode = .always
    }
}
