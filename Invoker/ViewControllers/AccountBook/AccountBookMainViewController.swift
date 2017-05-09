//
//  AccountBookMainViewController.swift
//  Invoker
//
//  Created by Tommy on 2017/4/18.
//  Copyright © 2017年 Tommy. All rights reserved.
//

import UIKit

class AccountBookMainViewController: BaseViewController {
    
    var earnLayer:CountLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let pie = PieChartView(frame: view.bounds)
//        view.addSubview(pie)
//        earnLayer = CountLayer()
//        earnLayer.frame = CGRect(x: 85, y: 37, width: 151, height: 80)
//        earnLayer.string = "asdf"3
//        earnLayer.backgroundColor = UIColor.black.cgColor
//        earnLayer.alignmentMode = "center"
//        view.layer.addSublayer(earnLayer)
    
    }

    @IBAction func click(_ sender: UIButton) {
//        self.earnLayer.showNumberWithAnimation(duration: 2.0, startNumber: 0.0, endNumber: 1000)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
}
