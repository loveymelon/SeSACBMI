//
//  ViewController.swift
//  SeSACBMI
//
//  Created by 김진수 on 1/3/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var resultButton: UIButton!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settingTextField()
        designButton()
    }
    
    func settingTextField() {
        self.heightTextField.delegate = self
        self.weightTextField.delegate = self
    }
    
    func designAlert(title: String? = nil ,text: String) {
        let alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)

        let confirmButton = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(confirmButton)
        
        present(alert, animated: true)
    }
    
    func designButton() {
        resultButton.setTitleColor(.white, for: .normal)
        
        if self.heightTextField.text?.isEmpty == false && self.weightTextField.text?.isEmpty == false {
            self.resultButton.isEnabled = true
            self.resultButton.backgroundColor = .purple
        } else {
            self.resultButton.isEnabled = false
            self.resultButton.backgroundColor = .lightGray
        }
    }
    
    func calculater(weightValue: Double, heightValue: Double) -> String {
        print(weightValue, heightValue)
        
        let tempResult = weightValue / (heightValue * heightValue) * 10000
        
        let result =  round(tempResult * 10) / 10
        
        var resultStr = ""
        
        print(tempResult, result)
        
        switch result {
        case ..<18.5:
            resultStr = "저체중"
        case 18.5...22.9:
            resultStr = "정상"
        case 23...24.9:
            resultStr = "비만전단계"
        case 25...29.9:
            resultStr = "1단계비만"
        case 30...34.9:
            resultStr = "2단계비만"
        case 35...:
            resultStr = "비만"
        default:
            print("error")
        }
        
        return resultStr
    }
    
    @IBAction func tappedDownKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func endEditTextField(_ sender: UITextField) {
    
        guard let text = sender.text else {
            return
        }
        
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            designAlert(text: "정확한 측정을 위해서 값을 입력해주세요.")
            return
        }
        
        var temp = text
        
        if temp == "." {
            temp = String(1.00)
            sender.text = "1.00"
        }
        
        guard let value = Double(temp) else {
            designAlert(text: "정확한 측정을 위해서 숫자를 입력하세요.")
            sender.text = ""
            return
        }
        
        guard value < 1.00 || value <= 250.00 else {
            designAlert(text: "정확한 측정을 위해서 1 ~ 250으로 넣어야합니다.")
            if value < 1 {
                sender.text = "1.00"
                return
            } else {
                sender.text = "250.00"
                return
            }
        }
        
        if sender == weightTextField {
            designButton()
        }
        
    }
    
    
    @IBAction func tappedResultButton(_ sender: UIButton) {
        
        designAlert(title: "BMI 결과", text: calculater(weightValue: Double(self.weightTextField.text!)!, heightValue: Double(self.heightTextField.text!)!))
        
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        let weight = Double.random(in: 1...250)
        let height = Double.random(in: 1...250)
        designAlert(title: "BMI 결과", text: calculater(weightValue: weight, heightValue: height))
        
    }
    
    @IBAction func returnkeyTextField(_ sender: UITextField) {
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.text!.count < 6 else { return false }
        return true
    }
}
