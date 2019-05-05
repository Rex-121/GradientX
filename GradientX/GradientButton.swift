//
//  GradientButton.swift
//  GradientLabel
//
//  Created by Tyrant on 2019/4/29.
//  Copyright © 2019 Tyrant. All rights reserved.
//

import UIKit

@IBDesignable open class GradientButton: UIButton {

    
    @IBInspectable open var direction: Int {
        set {
            new(direction: GradientX.Direction(rawValue: newValue) ?? .vertical)
        }
        get {
            return _dir.rawValue
        }
    }
    
    
    
    private lazy var _dir: GradientX.Direction = .vertical
    
    
    
    /// 左侧颜色
    @IBInspectable open var fromColor: UIColor {
        set { _fromC = newValue }
        get { return _fromC }
    }
    
    /// 右侧颜色
    @IBInspectable open var toColor: UIColor {
        set { _toC = newValue }
        get { return _toC }
    }
    
    private var _fromC: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    private var _toC: UIColor = UIColor.red  {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private (set) lazy var colors: [CGColor] = {
        [_fromC.cgColor, _toC.cgColor]
    }()
    
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override open func draw(_ rect: CGRect) {

        drawBg(colors, rect)
        
    }
    
}

extension GradientButton: Drawing {
            
    func wayDirection(by rect: CGRect) -> (start: CGPoint, end: CGPoint) {
        switch _dir {
        case .horizontal:
            return (start: CGPoint(x: rect.minX, y: rect.maxY),
                    end: CGPoint(x: rect.maxX, y: rect.maxY))
        case .vertical:
            return (start: CGPoint(x: rect.midX, y: rect.maxY),
                    end: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

extension GradientButton: Changing {
    
    
    /// 重设渐变颜色
    ///
    /// - Parameter colors: 颜色
    public func new(colors: [CGColor]) {
        if colors == self.colors { return }
        self.colors = colors
        setNeedsDisplay()
    }
    
    
    /// 重置渐变方向
    ///
    /// - Parameter direction: 渐变方向
    public func new(direction: GradientX.Direction) {
        if _dir == direction { return }
        _dir = direction
        setNeedsDisplay()
    }

}
