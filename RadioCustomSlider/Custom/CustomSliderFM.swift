//
//  CustomSliderFM.swift
//  RadioCustomSlider
//
//  Created by Jitengiri Goswami on 15/08/20.
//  Copyright © 2020 Jitengiri Goswami. All rights reserved.
//

import UIKit

protocol CustomSliderFMDelegate: NSObjectProtocol {
    func setupFMRuler(slider: CustomSliderFM, value:Double)
}

class CustomSliderFM: UIView, UIScrollViewDelegate {
    
    //MARK:- Global variable
    weak var delegate: CustomSliderFMDelegate?
    
    //MARK:- Local variable
    var scrollView = UIScrollView()
    var indicatorView = UIView()
    private let layerView = UIView()
    
    var rulerLine = CAShapeLayer()
    private let lines = UIBezierPath()
    
    private var addLine = 100.0
    private var intervalBetweenLines = 0.2
    private var value = 0.0
    
    private var maxValue = Double()
    private var maxValue2 = Double()
    
    var minScrollValue = Double()
    var defaultValue = Double()
    var maxScrollValue = Double()
    
    //MARK:- Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLayer(){
        let interval = 0.2
        
        for v in stride(from: 0.0, to: maxValue2, by: interval) {
            let isVIntegar = floor(v) == v
            
            let height = (isVIntegar) ? 90.0 : 70.0
            
            let oneLine = UIBezierPath()
            
            oneLine.move(to: CGPoint(x: v * addLine, y: 30))
            oneLine.addLine(to: CGPoint(x: v * addLine, y: height))
            lines.append(oneLine)
            
            if (isVIntegar) {
                let label = UILabel(frame: CGRect(x: v * addLine, y: 0, width: 40, height: 21))
                label.center = CGPoint(x: v * addLine, y: 15)
                label.font = UIFont(name: "HelveticaNeue",size: 10.0)
                label.textAlignment = .center
                label.textColor = UIColor.init(red: 122.0/255.0, green: 193.0/255.0, blue: 154.0/255.0, alpha: 1.0)
                label.text = "\(v + minScrollValue)"
                layerView.addSubview(label)
            }
        }
        rulerLine.path = lines.cgPath
        rulerLine.lineWidth = 2.0
    }
    
    private func configureUI(){
        scrollView.addSubview(layerView)
        layerView.layer.addSublayer(rulerLine)
        
        addSubview(scrollView)
        addSubview(indicatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        maxValue = maxScrollValue - minScrollValue
        maxValue2 = maxScrollValue - minScrollValue
        
        addLayer()
        configureUI()
        
        scrollView.contentSize = CGSize(width: maxValue * 1000, height: 100)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = bounds
        scrollView.bounces = false
        scrollView.contentSize.height = 1.0 // disable vertical scroll
        
        indicatorView.frame = CGRect(x: scrollView.frame.width / 2, y: 0, width: 1, height: 20)
        let imageName = "line.png"
        let imageView = UIImageView(image: UIImage(named: imageName)!)
        imageView.frame = CGRect(x: -30, y: -20, width: 70, height: 150)
        indicatorView.addSubview(imageView)
        
        layerView.frame = CGRect(x: (scrollView.frame.width / 2), y: 0, width: scrollView.frame.width, height: 100)
        scrollView.setContentOffset(CGPoint(x: CGFloat((defaultValue - minScrollValue) * 100), y: 0.0), animated: false)
    }
    
    //MARK:- ScrollView Delegate Methods
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if value > maxValue2{
            scrollView.setContentOffset(CGPoint(x: maxValue2 * 100, y: 0.0), animated: false)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if value > maxValue2{
            scrollView.setContentOffset(CGPoint(x: maxValue2 * 100, y: 0.0), animated: false)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x:Double = Double(Double(scrollView.contentOffset.x) / addLine + intervalBetweenLines/addLine)
        value = x.getFloorValue(nearestValue: intervalBetweenLines)
        
        var newValue:Double = x.getFloorValue(nearestValue: intervalBetweenLines)
        
        if value < 0 {
            newValue = 0.0
        }else if value > maxValue2 {
            newValue = maxValue2
            scrollView.setContentOffset(CGPoint(x: (maxValue * 100) - 10, y: 0.0), animated: false)
        }
        guard value <= maxValue2, value >= 0 else { return }
        delegate?.setupFMRuler(slider: self, value: newValue)
    }
}
