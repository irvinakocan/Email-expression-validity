//
//  ViewController.swift
//  Email expression validity
//
//  Created by Macbook Air 2017 on 5. 7. 2023..
//

import UIKit

class ViewController: UIViewController {
    
    let emailField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter your email adress here:", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 0.1, alpha: 0.3)])
        textField.textColor = .black
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        textField.layer.cornerRadius = 4
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
        textField.leftViewMode = .always
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Check email", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    func isEmailAdressValid(email: String) -> Bool {
        let emailRegex = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9._%+-]+\\.[a-zA-Z]{2,32}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: email)
    }
    
    func setupUI() {
        view.addSubview(emailField)
        emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        emailField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        emailField.addTarget(self, action: #selector(textFieldChanged), for: .allEditingEvents)
        
        view.addSubview(checkButton)
        checkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        checkButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20).isActive = true
        checkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    func setEmailBorderRed() {
        emailField.layer.borderColor = UIColor.red.cgColor
    }
    
    func setEmailBorderGray() {
        emailField.layer.borderColor = UIColor.gray.cgColor
    }
    
    @objc func checkButtonTapped() {
        guard let email = emailField.text else {
            setEmailBorderRed()
            return
        }
        
        if(isEmailAdressValid(email: email)) {
            let vc = UIViewController()
            vc.view.backgroundColor = .green
            present(vc, animated: true)
        }
        else {
            setEmailBorderRed()
        }
    }
    
    @objc func textFieldChanged() {
        setEmailBorderGray()
    }
}

