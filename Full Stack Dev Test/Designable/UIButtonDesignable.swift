//
//  UIButtonDesignable.swift
//
//  Created by Joseph on 12/1/20.
//

import UIKit

@IBDesignable
class UIButtonDesignable: UIButton{
/// VERSION 1.0
//MARK: - Corner Radius Attributes
    @IBInspectable var topLeftCorners: Bool = false
    @IBInspectable var topRightCorners: Bool = false
    @IBInspectable var bottomLeftCorners: Bool = false
    @IBInspectable var bottomRightCorners: Bool = false
    @IBInspectable var radius: CGFloat = .zero
    @IBInspectable var isRounded: Bool = false

//MARK: - Shadow Attributes

    @IBInspectable var shadowAlpha:Float = 0
    @IBInspectable var shadowOffset:CGSize = CGSize(width: 0, height: 0)
    @IBInspectable var shadowBlur:CGFloat = 0
    @IBInspectable var shadowSpread:CGFloat = 0
    @IBInspectable var shadowColor:UIColor = UIColor.black{
        didSet{
            layer.shadowColor = shadowColor.cgColor
        }
    }
//MARK: - Button Attributes

/// 0 => .ScaleToFill
/// 1 => .ScaleAspectFit
/// 2 => .ScaleAspectFill
    
    @IBInspectable var imageContentMode: UIView.ContentMode = .scaleAspectFill {
        didSet {
            self.subviews.first?.contentMode = imageContentMode
        }
    }

    @IBInspectable var adjustsTitleFontSizeToFitWidth: Bool = false {
        didSet {
            self.titleLabel?.adjustsFontSizeToFitWidth = adjustsTitleFontSizeToFitWidth
        }
    }
    
    //MARK: - Border Attributes
    
    @IBInspectable var borderWidth:CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor:UIColor = UIColor.black{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    //MARK: - Animation Attributes

    @IBInspectable var isAnimatedWhenTouched: Bool = false
    
    //MARK: - Gradient Attributes

    @IBInspectable var isGradientEnabled: Bool = false

    @IBInspectable var startColor: UIColor? {
        didSet {
            updateGradient()
        }
    }

    @IBInspectable var endColor: UIColor? {
        didSet {
            updateGradient()
        }
    }
/// 270 & 90  - VERTICAL
/// 0 & 180    - HORIZONTAL
    @IBInspectable var angle: CGFloat = 0 {
        didSet {
            updateGradient()
        }
    }

//MARK: - Main Function
    var brazierPath: UIBezierPath?


    override func layoutSubviews() {
        super.layoutSubviews()

        brazierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: getRoundingCorners(), cornerRadii: CGSize(width: isRounded ? (self.bounds.height * 0.5) : radius, height: isRounded ? (self.bounds.height * 0.5) : radius))
        self.layer.cornerRadius = isRounded ? (self.bounds.height * 0.5) : radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = getRoundingCorners()
        }
        setupShadows(bezierPath: brazierPath!)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        if isGradientEnabled {
            installGradient()
            updateGradient()
        }
    }

//MARK: - Shadow Implementation

    private func setupShadows(bezierPath: UIBezierPath){
        layer.shadowOpacity = shadowAlpha
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowBlur / 2.0
        if shadowSpread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -shadowSpread
            _ = bezierPath.bounds.insetBy(dx: dx, dy: dx)
//            layer.shadowPath = UIBezierPath(rect: rect).cgPath
            layer.shadowPath = bezierPath.cgPath
        }
    }

//MARK: - Corner Radius Implementation (iOS 12 below)
    private func getRoundingCorners() -> UIRectCorner{
        var rectCorners: UIRectCorner = []
        if topLeftCorners == true {
            rectCorners.insert(.topLeft)
        }
        if topRightCorners == true {
            rectCorners.insert(.topRight)
        }
        if bottomLeftCorners == true {
            rectCorners.insert(.bottomLeft)
        }
        if bottomRightCorners == true {
            rectCorners.insert(.bottomRight)
        }
        return rectCorners
    }
//MARK: - Corner Radius Implementation (iOS 13 above)

    private func getRoundingCorners() -> CACornerMask{
        var rectCorners: CACornerMask = []
        if topLeftCorners == true {
            rectCorners.insert(.layerMinXMinYCorner)
        }
        if topRightCorners == true {
            rectCorners.insert(.layerMaxXMinYCorner)
        }
        if bottomLeftCorners == true {
            rectCorners.insert(.layerMinXMaxYCorner)
        }
        if bottomRightCorners == true {
            rectCorners.insert(.layerMaxXMaxYCorner)
        }

        return rectCorners
    }
    
//MARK: - Button Animation Implementation

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isAnimatedWhenTouched {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                super.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }, completion: nil)
        }
    }


    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isAnimatedWhenTouched {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                super.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isAnimatedWhenTouched {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                super.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }

//MARK: - Gradient Implementation
     
// the gradient layer
    private var gradient: CAGradientLayer?
// initializers
    
// Create a gradient and install it on the layer
    private func installGradient() {
        // if there's already a gradient installed on the layer, remove it
        if let gradient = self.gradient {
            gradient.removeFromSuperlayer()
        }
        let gradientMask = CAShapeLayer()
        gradientMask.frame = self.bounds
        gradientMask.path = brazierPath?.cgPath
        let gradient = createGradient()
        gradient.mask = gradientMask
        self.layer.insertSublayer(gradient, at: 0)
        self.gradient = gradient
    }

// Update an existing gradient
    private func updateGradient() {
        if let gradient = self.gradient {
            let startColor = self.startColor ?? UIColor.clear
            let endColor = self.endColor ?? UIColor.clear
            gradient.colors = [startColor.cgColor, endColor.cgColor]
            let (start, end) = gradientPointsForAngle(self.angle)
            gradient.startPoint = start
            gradient.endPoint = end
        }
    }

// create gradient layer
    private func createGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        return gradient
    }
    
    // create vector pointing in direction of angle
    private func gradientPointsForAngle(_ angle: CGFloat) -> (CGPoint, CGPoint) {
        // get vector start and end points
        let end = pointForAngle(angle)
        //let start = pointForAngle(angle+180.0)
        let start = oppositePoint(end)
        // convert to gradient space
        let p0 = transformToGradientSpace(start)
        let p1 = transformToGradientSpace(end)
        return (p0, p1)
    }

    // get a point corresponding to the angle
    private func pointForAngle(_ angle: CGFloat) -> CGPoint {
        // convert degrees to radians
        let radians = angle * .pi / 180.0
        var x = cos(radians)
        var y = sin(radians)
        // (x,y) is in terms unit circle. Extrapolate to unit square to get full vector length
        if (abs(x) > abs(y)) {
            // extrapolate x to unit length
            x = x > 0 ? 1 : -1
            y = x * tan(radians)
        } else {
            // extrapolate y to unit length
            y = y > 0 ? 1 : -1
            x = y / tan(radians)
        }
        return CGPoint(x: x, y: y)
    }
    
    // transform point in unit space to gradient space
    private func transformToGradientSpace(_ point: CGPoint) -> CGPoint {
        // input point is in signed unit space: (-1,-1) to (1,1)
        // convert to gradient space: (0,0) to (1,1), with flipped Y axis
        return CGPoint(x: (point.x + 1) * 0.5, y: 1.0 - (point.y + 1) * 0.5)
    }
    
    // return the opposite point in the signed unit square
    private func oppositePoint(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: -point.x, y: -point.y)
    }
    
    // ensure the gradient gets initialized when the view is created in IB

}
