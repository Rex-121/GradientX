//
//  ViewController.swift
//  Gradient
//
//  Created by Tyrant on 05/05/2019.
//  Copyright (c) 2019 Tyrant. All rights reserved.
//

import UIKit

import GradientX

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var firstLabel: GradientLabel!
    
    @IBAction func changeText(_ sender: UIButton) {
        firstLabel.text = Int.random(in: 100000...999999).description
    }
    
    @IBAction func changeFont(_ sender: UIButton) {
        firstLabel.font = UIFont.systemFont(ofSize: CGFloat.random(in: 10...30))
    }
    
    @IBAction func changeColors(_ sender: UIButton) {
        let colors = Bool.random() ? [UIColor.blue.cgColor, UIColor.gray.cgColor] : [UIColor.white.cgColor, UIColor.black.cgColor]
        firstLabel.new(colors: colors)
    }
    @IBAction func changeDirection(_ sender: UIButton) {
        firstLabel.new(direction: Bool.random() ? .vertical : .horizontal)
    }
    
    
    
    @IBOutlet weak var bgLabel: GradientLabel!
    
    @IBAction func changeText_1(_ sender: UIButton) {
        bgLabel.text = Int.random(in: 100000...999999).description
    }
    
    @IBAction func changeFont_1(_ sender: UIButton) {
        bgLabel.font = UIFont.systemFont(ofSize: CGFloat.random(in: 10...30))
    }
    
    @IBAction func changeColors_1(_ sender: UIButton) {
        let colors = Bool.random() ? [UIColor.blue.cgColor, UIColor.gray.cgColor] : [UIColor.white.cgColor, UIColor.black.cgColor]
        bgLabel.new(colors: colors)
    }
    @IBAction func changeDirection_1(_ sender: UIButton) {
        bgLabel.new(direction: Bool.random() ? .vertical : .horizontal)
    }

}

