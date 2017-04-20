//
//  CountJumpView.swift
//  Invoker
//
//  Created by Tommy on 2017/4/20.
//  Copyright © 2017年 Tommy. All rights reserved.
//

// https://github.com/PigRiver/NumberJumpDemo

import UIKit

private struct BezierPoint {
    let x: Float
    let y: Float
}

private class BezierCurve {
    //根据t(位置，0-1)取点
    static func PointOnCubicBezier(cp:[BezierPoint], t:Float) -> BezierPoint {
        var ax,bx,cx:Float
        var ay,by,cy:Float
        var tSquared,tCubed:Float
        
        /*計算多項式係數*/
        
        cx = 3.0 * (cp[1].x - cp[0].x);
        bx = 3.0 * (cp[2].x - cp[1].x) - cx;
        ax = cp[3].x - cp[0].x - cx - bx;
        
        cy = 3.0 * (cp[1].y - cp[0].y);
        by = 3.0 * (cp[2].y - cp[1].y) - cy;
        ay = cp[3].y - cp[0].y - cy - by;
        /*計算位於參數值t的曲線點*/
        tSquared = t * t;
        tCubed = tSquared * t;
        let x = (ax * tCubed) + (bx * tSquared) + (cx * t) + cp[0].x;
        let y = (ay * tCubed) + (by * tSquared) + (cy * t) + cp[0].y;
        return BezierPoint(x: x, y: y)
    }
}


class CountLayer: CATextLayer {
    //总时间
    private var durationTotal:TimeInterval = 5.0
    //开始值
    private var startNumber:Float!
    //结束值
    private var endNumber:Float!
    //总点数,即数字跳100次
    private var pointNumber:Int!
    //当前画的点
    private var indexCurrent:Int = 0
    private var lastTime:Float!
    //开始点
    private let startPoint: BezierPoint = BezierPoint(x: 0, y: 0)
    //两个bezier点,http://cubic-bezier.com/ 可以生成
    private let controlPoint1: BezierPoint = BezierPoint(x: 0.25, y: 0.1)
    private var controlPoint2: BezierPoint = BezierPoint(x: 0.25, y: 0.1)
    //结束点，固定1，1
    private var endPoint: BezierPoint = BezierPoint(x: 1, y: 1)
    //计算得到的所有点
    private var allPoints:NSMutableArray!
    
    override init() {
        super.init()
        initDate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initDate()
    }
    
    private func initDate() {
        allPoints = NSMutableArray()
        indexCurrent = 0
        lastTime = 0
    }
    
    //动画跳动展示
    func showNumberWithAnimation(duration:TimeInterval, startNumber:Float, endNumber:Float) {
        indexCurrent = 0
        lastTime = 0
        self.durationTotal = duration
        self.startNumber = startNumber
        self.endNumber = endNumber
        initBezierPoint()
        changeNumberBySelector()
    }
    
    //初始化
    private func initBezierPoint() {
        //总共多少点
        pointNumber = 100
        let bezierPoints:[BezierPoint] = [startPoint, controlPoint1, controlPoint2, endPoint]
        allPoints.removeAllObjects()
        //读出每点的时间和值
        for index in 0 ..< pointNumber {
            let t = Float(index)/Float(pointNumber - 1)
            let point:BezierPoint = BezierCurve.PointOnCubicBezier(cp: bezierPoints, t: t)
            let durationTime = point.x * Float(durationTotal)
            let value:Float = point.y * (endNumber - startNumber) + startNumber;
            allPoints.add(NSArray(array: [durationTime,value]))
        }
    }
    
    func changeNumberBySelector() {
        if(indexCurrent >= pointNumber) {
            self.string = NSString(format: "%.2f", endNumber)
            return
        }else{
            let currentPoint: NSArray = allPoints.object(at: indexCurrent) as! NSArray
            let value = currentPoint.object(at: 1) as! Float
            let currentTime = currentPoint.object(at: 0) as! Float
            
            indexCurrent += 1
            let timeDuration = currentTime - lastTime
            lastTime = currentTime;
            self.string = NSString(format: "%.2f", value)
            self.perform(#selector(changeNumberBySelector), with: nil, afterDelay: TimeInterval(timeDuration))
        }
    }
}
