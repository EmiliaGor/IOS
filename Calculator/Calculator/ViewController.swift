//
//  ViewController.swift
//  Calculator
//
//  Created by user253436 on 11/20/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var output: UILabel!
    
    var equ:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clear_all()
        // Do any additional setup after loading the view.
    }

    func clear_all(){
        output.text = " "
        equ = " "
    }
    
    func add_eq(value: String){
        equ = equ+value
        output.text=equ
    }
    
    @IBAction func Add(_ sender: Any) {
        add_eq(value: "+")
    }
    
    @IBAction func subtract(_ sender: Any) {
        add_eq(value: "-")
    }
    
    @IBAction func multiply(_ sender: Any) {
        add_eq(value: "x")

    }
    
    @IBAction func div(_ sender: Any) {
        add_eq(value: "/")

    }
    
    @IBAction func equal(_ sender: Any) {
        let expression = NSExpression(format: equ)
        let result = expression.expressionValue(with: nil, context: nil) as! Double
        output.text = format_result(result: result)
        
    }
    func format_result(result: Double) -> String{
        if result.truncatingRemainder(dividingBy: 1)==0{
            return String(format: "%.0f", result)
        }else{
            return String(format: "%.4f", result)
        }
    }
    
    @IBAction func allclear(_ sender: Any) {
        clear_all()
    }
    
    @IBAction func zero(_ sender: Any) {
        add_eq(value: "0")
    }
    
    @IBAction func one(_ sender: Any) {
        add_eq(value: "1")
    }
    
    @IBAction func two(_ sender: Any) {
        add_eq(value: "2")
    }
    
    @IBAction func three(_ sender: Any) {
        add_eq(value: "3")
    }
    
    @IBAction func four(_ sender: Any) {
        add_eq(value: "4")
    }
    
    
    @IBAction func five(_ sender: Any) {
        add_eq(value: "5")
}
    
    @IBAction func six(_ sender: Any) {
        add_eq(value: "6")
}
    
    @IBAction func seven(_ sender: Any) {
        add_eq(value: "7")
}
    
    @IBAction func eight(_ sender: Any) {
        add_eq(value: "8")
}
    
    @IBAction func nine(_ sender: Any) {
        add_eq(value: "9")
}
}

