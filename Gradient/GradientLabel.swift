//
//  GradientLabel.swift
//  GradientLabel
//
//  Created by Tyrant on 2019/4/29.
//  Copyright © 2019 Tyrant. All rights reserved.
//

import UIKit



/// 渐变Lable
@IBDesignable open class GradientLabel: UILabel {
    
    
    /// 渐变方向
    @IBInspectable public var direction: Int {
        set {
            new(direction: Gradient.Direction(rawValue: newValue) ?? .vertical)
        }
        get {
            return _dir.rawValue
        }
    }
    
    
    
    private lazy var _dir: Gradient.Direction = .vertical
    
    
    /// 左侧颜色 不建议通过此代码更改背景色 使用 `new(colors:)`
    @IBInspectable public var fromColor: UIColor {
        set { _fromC = newValue }
        get { return _fromC }
    }
    
    /// 右侧颜色 不建议通过此代码更改背景色 使用 `new(colors:)`
    @IBInspectable public var toColor: UIColor {
        set { _toC = newValue }
        get { return _toC }
    }
    
    private lazy var colors: [CGColor] = {
        [_fromC.cgColor, _toC.cgColor]
    }()
    
    
    private var _fromC: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    private var _toC: UIColor = UIColor.white {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    
    /// 渐变
    ///
    /// - text: 渐变文字
    /// - background: 渐变背景
    enum GradientType: Int {
        case text = 0, background = 1
    }
    
    private lazy var _type: GradientType = .text
    
    @IBInspectable public var gradientType: Int {
        set { _type = GradientType(rawValue: newValue) ?? .text }
        get { return _type.rawValue }
    }
    
    
    override open func draw(_ rect: CGRect) {
        
        defer {
            super.draw(rect)
        }
        
        switch _type {
        case .background:
            /// 重构背景
            drawBg(colors, rect)
        case .text:
            /// 重构渐变层的大小和位置，渐变方向
            remake(gradientLayer, by: rect).mask = self.layer
        }
        
    }
    
    
    /// 重构渐变层的大小和位置，渐变方向
    ///
    /// - Parameters:
    ///   - layer: 渐变层
    ///   - rect: 大小
    /// - Returns: 渐变层
    private func remake(_ layer: CAGradientLayer, by rect: CGRect) -> CAGradientLayer {
        layer.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width, height: frame.height))
        layer.position = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        (layer.startPoint, layer.endPoint) = wayDirection(by: rect)
        return layer
    }
    
    private lazy var gradientLayer: CAGradientLayer = { [unowned self] in
        let l = gradient(self.colors)
        self.layer.addSublayer(l)
        textColor = backgroundColor ?? .clear
        return l
    }()
    
    
    
    /// 复制自身属性
    ///
    /// - Returns: label
    private func copyLabel() -> UILabel {
        let label = UILabel(frame: bounds)
        label.font = font
        label.text = text
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
        addSubview(label)
        return label
    }
    
    
    /// 初始化渐变层
    ///
    /// - Parameter colors: 初始颜色
    /// - Returns: 渐变层
    private func gradient(_ colors: [CGColor]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        return gradientLayer
    }
    
}

extension GradientLabel: Drawing {
    
    /// 渐变方向
    ///
    /// - Parameter rect: 大小
    /// - Returns: 渐变方向
    func wayDirection(by rect: CGRect) -> (start: CGPoint, end: CGPoint) {
        
        switch _type {
        case .text:
            switch _dir {
            case .horizontal:
                return (start: CGPoint.zero,
                        end: CGPoint(x: 1, y: 0))
            case .vertical:
                return (start: CGPoint.zero,
                        end: CGPoint(x: 0, y: 1))
            }
        case .background:
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
    
}


// MARK: - 重构渐变颜色/方向
extension GradientLabel: Changing {
    
    
    /// 重构渐变颜色
    ///
    /// - Parameter colors: 渐变颜色
    public func new(colors: [CGColor]) {
        if colors == self.colors { return }
        self.colors = colors
        
        switch _type {
        case .text: gradientLayer.colors = self.colors
        case .background: setNeedsDisplay()
        }
        
    }
    
    
    /// 重构渐变方向
    ///
    /// - Parameter direction: 渐变方向
    public func new(direction: Gradient.Direction) {
        if _dir == direction { return }
        _dir = direction
        setNeedsDisplay()
    }
    
}
