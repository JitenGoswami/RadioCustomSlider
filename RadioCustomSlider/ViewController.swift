//
//  ViewController.swift
//  RadioCustomSlider
//
//  Created by Jitengiri Goswami on 15/08/20.
//  Copyright © 2020 Jitengiri Goswami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var AMCustomSliderView: UIView!
    @IBOutlet weak var txtAMValue: UITextField!
    
    @IBOutlet weak var FMCustomSliderView: UIView!
    @IBOutlet weak var txtFMValue: UITextField!
    
    //MARK:- Local variable
    private var AMSlider = CustomSliderAM()
    private var minSliderAMValue = Double()
    private var lastAMValue = Int()
    
    private var FMSlider = CustomSliderFM()
    private var minSliderFMValue = Double()
    private var lastFMValue = Int()
    
    //MARK:- VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addAMSlider()
        addFMSlider()
    }
    
    //MARK:- Logical Methods
    private func addAMSlider(){
        AMSlider.frame = AMCustomSliderView.frame
        AMSlider.delegate = self
        
        AMSlider.minScrollValue = 430.0
        AMSlider.maxScrollValue = 1800.0
        AMSlider.defaultValue = 530.0
        
        minSliderAMValue = AMSlider.minScrollValue
        lastAMValue = Int(AMSlider.defaultValue)
        
        txtAMValue.text = String(Int(minSliderAMValue))
        AMSlider.scrollView.backgroundColor = UIColor.init(red: 46.0/255.0, green: 53.0/255.0, blue: 67.0/255.0, alpha: 1.0)
        AMSlider.indicatorView.backgroundColor = .clear
        AMSlider.rulerLine.strokeColor = UIColor.init(red: 57.0/255.0, green: 84.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        view.addSubview(AMSlider)
    }
    
    private func addFMSlider(){
        FMSlider.frame = FMCustomSliderView.frame
        FMSlider.delegate = self
        
        FMSlider.minScrollValue = 77.2
        FMSlider.maxScrollValue = 120.4
        FMSlider.defaultValue = 99.6
        
        minSliderFMValue = FMSlider.minScrollValue
        lastFMValue = Int(FMSlider.defaultValue)
        
        txtFMValue.text = String(Int(minSliderFMValue))
        FMSlider.scrollView.backgroundColor = UIColor.init(red: 46.0/255.0, green: 53.0/255.0, blue: 67.0/255.0, alpha: 1.0)
        FMSlider.indicatorView.backgroundColor = .clear
        FMSlider.rulerLine.strokeColor = UIColor.init(red: 57.0/255.0, green: 84.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        view.addSubview(FMSlider)
    }
    
    //MARK:- Button Actions
    @IBAction func btnAMSubmitClicked(sender: UIButton){
        if let inputValue:Double = Double(txtAMValue.text!){
            guard inputValue >= AMSlider.minScrollValue && inputValue <= AMSlider.maxScrollValue else {
                print("AM value is not in the range")
                return
            }
            AMSlider.scrollView.setContentOffset(CGPoint(x: (inputValue - minSliderAMValue), y: 0.0), animated: false)
        }
    }
    
    @IBAction func btnFMSubmitClicked(sender: UIButton){
        if let inputValue:Double = Double(txtFMValue.text!){
            guard inputValue >= FMSlider.minScrollValue && inputValue <= FMSlider.maxScrollValue else {
                print("FM value is not in the range")
                return
            }
            FMSlider.scrollView.setContentOffset(CGPoint(x: (inputValue - minSliderFMValue) * 100, y: 0.0), animated: false)
        }
    }
}

extension ViewController: CustomSliderAMDelegate{
    func setupAMRuler(slider: CustomSliderAM, value: Double) {
        txtAMValue.text = String(Int(value + minSliderAMValue))
    }
}

extension ViewController: CustomSliderFMDelegate{
    func setupFMRuler(slider: CustomSliderFM, value: Double) {
        txtFMValue.text = String(format: "%.1f", (value + minSliderFMValue))
    }
}



