//
//  PieChartView.swift
//  Invoker
//
//  Created by Tommy on 2017/4/19.
//  Copyright © 2017年 Tommy. All rights reserved.
//

import UIKit

class PieChartView: UIView {
    // 半径
    let radius: CGFloat = 80.0
    let datas: [CGFloat] = [6100, 3400, 5000, 10000, 4000, 8000]
    let colors: [UIColor] = [.orange, .red, .blue, .purple, .gray, .brown]
    let textList: [NSString] = ["住房", "吃喝", "交通", "旅行", "医疗", "爱人"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: "#efefef")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawLine(_ context: CGContext, startAngle: CGFloat, endAngle: CGFloat, color: UIColor, index: Int) {
        // 每段弧度的中心弧度
        let centerAngle = (startAngle + endAngle) / 2.0
        // 对应小圆点的中心点
        let smallCircleCenterX = center.x + (radius + 10) * cos(centerAngle)
        let smallCircleCenterY = center.y + (radius + 10) * sin(centerAngle)
        // 线的折点+终点
        var lineLosePointX: CGFloat = 0.0, lineLosePointY: CGFloat = 0.0, lineEndPointX: CGFloat = 0.0, lineEndPointY: CGFloat = 0.0
        // 数字的起点
        var numberStartPointX: CGFloat = 0.0, numberStartPointY: CGFloat = 0.0
        // 文本的起点
        var textStartPointX: CGFloat = 0.0, textStartPointY: CGFloat = 0.0
        
        lineLosePointX = smallCircleCenterX + 10.0*cos(centerAngle)
        lineLosePointY = smallCircleCenterY + 10.0*sin(centerAngle)
        
        // 数字:数值+比例
        let sum = datas.reduce(0,{$0 + $1})
        let numberData = String.init(format: "%.1f(%.1f%%)",datas[index],CGFloat(datas[index])/sum*100) as NSString
        let numberSize = numberData.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 10.0)])
        let textSize = textList[index].size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12.0)])
        // 数字和文本的宽度+高度
        var width: CGFloat = 0.0, height: CGFloat = 40.0
        var maxWidth = numberSize.width > textSize.width ? numberSize.width : textSize.width
        if maxWidth < radius {
            maxWidth = radius
            width = radius
        } else {
            if (maxWidth + 10 > frame.size.width/2-5) {
                maxWidth = frame.size.width/2-5;
            }
            width = maxWidth + 10.0;
        }
        
        // 中心点的右边
        if smallCircleCenterX > frame.size.width / 2 {            //指引线的终点
            lineEndPointX = lineLosePointX + width; //
            lineEndPointY = lineLosePointY; //
            // 数字
            numberStartPointX = lineEndPointX - numberSize.width;
            numberStartPointY = lineEndPointY - numberSize.height;
            // 文本
            textStartPointX = lineEndPointX - width;
            textStartPointY = lineEndPointY;
        } else {
            // 中心点的右边
            // 指引线的终点
            lineEndPointX = lineLosePointX - width;
            if (lineEndPointX < 3) {
                lineEndPointX = 3;
            }
            lineEndPointY = lineLosePointY;
            // 数字
            numberStartPointX = lineEndPointX ;
            numberStartPointY = lineEndPointY - numberSize.height;
            // 文本
            textStartPointX = lineEndPointX;
            textStartPointY = lineEndPointY;
        }
        
        // 开始画小圆点
        let smallCirclePath = UIBezierPath(arcCenter: CGPoint(x: smallCircleCenterX, y: smallCircleCenterY), radius: 4, startAngle: 0.0, endAngle: CGFloat.degreesToRadians(360.0), clockwise: true)
        color.set()
        smallCirclePath.fill()
        smallCirclePath.stroke()
        
        // 画折线
        context.beginPath()
        context.move(to: CGPoint(x: smallCircleCenterX, y: smallCircleCenterY))
        context.addLine(to: CGPoint(x: lineLosePointX, y: lineLosePointY))
        context.addLine(to: CGPoint(x: lineEndPointX, y: lineEndPointY))
        context.setLineWidth(1.0)
        context.setFillColor(color.cgColor)
        context.strokePath()
        
        // 段落样式,中心点左边就段落样式就靠左边
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = lineEndPointX < frame.size.width / 2.0 ? .left : .right
        
        // 画折线上面的数字+比例
        let numberFinalX = (numberStartPointX >= frame.size.width / 2) ? numberStartPointX - 5 : numberStartPointX + 1
        numberData.draw(in: CGRect(origin: CGPoint(x: numberFinalX, y: numberStartPointY), size: CGSize(width: width, height: height)),
                        withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 10.0), NSForegroundColorAttributeName: color])
        
        // 画文本说明
        let textFinalX = (textStartPointX >= frame.size.width / 2) ? textStartPointX - 1 : textStartPointX + 1
        textList[index].draw(in: CGRect(origin: CGPoint(x: textFinalX, y: textStartPointY), size: CGSize(width: width, height: height)), withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12.0), NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: paragraphStyle])
    }
  
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // MARK: - 画饼图
        context.saveGState()
        // 偏转的弧度
        var offsetRadian: CGFloat = 0.0
        var startAngle: CGFloat = 0.0
        // 数值的总和
        let sum = datas.reduce(0,{$0 + $1})
        for (index,element) in datas.enumerated() {
            // 每个数据对应的角度
            let radian = (element / sum) * 360.0
            let endAngle = radian.degreesToRadians() + offsetRadian
            offsetRadian += radian.degreesToRadians()
            context.setFillColor(colors[index].cgColor)
            context.move(to: center)
            context.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            context.fillPath()
            
            // MARK: - 画比例线
            drawLine(context, startAngle: startAngle, endAngle: endAngle, color: colors[index],index: index)
            startAngle = endAngle
            
        }
        context.restoreGState()
        
        
        // MARK: - 画中心圆
        context.saveGState()
        context.move(to: center)
        context.setFillColor(UIColor.white.cgColor)
        context.addArc(center: center, radius: radius/2.0, startAngle: 0.0, endAngle: CGFloat.degreesToRadians(360.0), clockwise: false)
        context.fillPath()
        context.restoreGState()
        
        
        // MARK: - 画内圈数据
        context.saveGState()
        let text: NSString = String.init(format: "%.2f\n 总计消费", sum) as NSString
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        text.draw(in: CGRect(origin: CGPoint(x: center.x - (radius/2), y: center.y - (radius/4)), size: CGSize(width: radius, height: radius)), withAttributes: [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 17.0)!,
            NSForegroundColorAttributeName: UIColor.black,
            NSParagraphStyleAttributeName: style])
        context.restoreGState()
    }
}



















