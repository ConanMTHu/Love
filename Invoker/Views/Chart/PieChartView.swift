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
    let datas: [CGFloat] = [0.4,0.3,0.2,0.1]
    let colors: [UIColor] = [.orange,.red,.blue,.green]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
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
        
        // 折线的折点
        let brokenLineX =
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
        for (index,element) in datas.enumerated() {
            // 每个数据对应的角度
            let radian = element * 360.0
            let endAngle = radian.degreesToRadians() + offsetRadian
            offsetRadian += radian.degreesToRadians()
            //let startAngle = 0 + currentRadian
            //let endAngle = startAngle + radian
            context.setFillColor(colors[index].cgColor)
            
            context.move(to: center)
            // -90弧度的意思是从12点钟的方位开始画
            context.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            context.fillPath()
            
            // MARK: - 画比例直线
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
        //context.setFillColor(UIColor.yellow.cgColor)
        let text: NSString = "10092.23\n 总计消费"
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        text.draw(in: CGRect(origin: CGPoint(x:center.x-40,y:center.y-20), size: CGSize(width: 80, height: 80)), withAttributes: [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!,
            NSForegroundColorAttributeName: UIColor.red,
            NSParagraphStyleAttributeName: style])
        context.restoreGState()
    }
 

}



















