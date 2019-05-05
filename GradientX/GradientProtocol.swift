//
//  GradientProtocol.swift
//  Gradient
//
//  Created by Tyrant on 2019/5/5.
//

import UIKit


/// 渐变方向
///
/// - horizontal: 自左到右
/// - vertical: 自上而下
public enum Direction: Int {
    case horizontal = 1, vertical = 0
}



internal protocol Drawing {
    
    /// 绘制渐变背景
    ///
    /// - Parameters:
    ///   - colors: 渐变色
    ///   - rect: 大小
    func drawBg(_ colors: [CGColor], _ rect: CGRect)
    
    func wayDirection(by rect: CGRect) -> (start: CGPoint, end: CGPoint)
}


extension Drawing {
    
    /// 绘制渐变背景
    ///
    /// - Parameters:
    ///   - colors: 渐变色
    ///   - rect: 大小
    internal func drawBg(_ colors: [CGColor], _ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.saveGState()
        
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -rect.height)
        
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: nil)
        
        let dir = wayDirection(by: rect)
        
        context.drawLinearGradient(gradient!, start: dir.start, end: dir.end, options: [CGGradientDrawingOptions.drawsAfterEndLocation, .drawsBeforeStartLocation])
        
        context.restoreGState()
    }
    
}


public protocol Changing {
    
    
    /// 重构渐变颜色
    ///
    /// - Parameter colors: 渐变颜色
    func new(colors: [CGColor])
    
    
    /// 重构渐变方向
    ///
    /// - Parameter direction: 渐变方向
    func new(direction: GradientX.Direction)
    
}
