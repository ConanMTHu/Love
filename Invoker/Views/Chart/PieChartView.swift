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
    let radius: CGFloat = 120.0
    let datas: [CGFloat] = [0.4,0.3,0.2,0.1]
    let colors: [UIColor] = [.orange,.red,.blue,.green]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        //context.setShadow(offset: CGSize(width: 0, height: 10), blur: 10)
        var currentRadian:CGFloat = 0.0
        for (index,element) in datas.enumerated() {
            // 每个数据对应的弧度
            let radian = element * 360.0
            let startAngle = 0 + currentRadian
            let endAngle = startAngle + radian
            context.setFillColor(colors[index].cgColor)
            
            context.move(to: center)
            // -90弧度的意思是从12点钟的方位开始画
            context.addArc(center: center, radius: radius, startAngle: startAngle.degreesToRadians() - CGFloat.degreesToRadians(90.0), endAngle: endAngle.degreesToRadians() - CGFloat.degreesToRadians(90.0), clockwise: false)
            context.fillPath()
            
            currentRadian += radian
        }
        context.restoreGState()
        
        // MARK: - 画比例直线
        
        
        // MARK: - 画内圈
        context.saveGState()
        context.move(to: center)
        context.setFillColor(UIColor.white.cgColor)
        context.addArc(center: center, radius: radius/2.0, startAngle: 0.0, endAngle: 360, clockwise: false)
        context.fillPath()
        context.restoreGState()
        
        // MARK: - 画内圈数据
        context.saveGState()
        //context.setFillColor(UIColor.yellow.cgColor)
        let text: NSString = "10092.23\n 总计消费"
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        text.draw(in: CGRect(origin: CGPoint(x:center.x-60,y:center.y-30), size: CGSize(width: 120, height: 120)), withAttributes: [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 25.0)!,
            NSForegroundColorAttributeName: UIColor.red,
            NSParagraphStyleAttributeName: style])
        context.restoreGState()
    }
 

}



















