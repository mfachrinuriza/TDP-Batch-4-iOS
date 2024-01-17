//
//  LoginViewController.swift
//  MyFirstApp
//
//  Created by Muhammad Fachri Nuriza on 22/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var containerEmail: UIView!
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtPasswrod: UITextField!
    @IBOutlet weak var containerPassword: UIView!
    
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var formBottomAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let colorPurple = UIColor(red: 209, green: 62, blue: 229, alpha: 1.0)
        let colorGreen = UIColor(red: 1, green: 217, blue: 210, alpha: 1.0)
        
        txtEmail.keyboardType = .asciiCapable
        txtEmail.delegate = self
        txtEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        txtPasswrod.keyboardType = .asciiCapable
        txtPasswrod.delegate = self
        txtPasswrod.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func isValidForm() -> Bool {
        if (txtEmail.text != nil && txtEmail.text != "") && (txtPasswrod.text != nil && txtPasswrod.text != "") {
            if !isValidEmail(txtEmail.text ?? "") {
                showError(message: "Email tidak sesuai format")
                return false
            } else if txtPasswrod.text?.count ?? 6 < 6 {
                showError(message: "Password minimal 6 karakter.")
                return false
            } else {
                return true
            }
        } else {
            showError(message: "Username dan Password wajib diisi!")
            return false
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showError(message: String) {
        UIView.animate(withDuration: 0.5) {
            self.lblError.isHidden = false
            self.lblError.text = message
        }
    }
    
    func presentHome() {
        let vc = HomeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnShowPasswordTapped(_ sender: Any) {
        if txtPasswrod.isSecureTextEntry {
            txtPasswrod.isSecureTextEntry = false
        } else {
            txtPasswrod.isSecureTextEntry = true
        }
    }
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        if isValidForm() {
            presentHome()
        }
    }
    
    func setTextFieldActive(view: UIView) {
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 189.0, green: 226.0, blue: 136.0, alpha: 1.0).cgColor
    }
    
    func setTextFieldDefault(view: UIView) {
        view.layer.borderWidth = 0
    }
}

extension LoginViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtEmail {
            setTextFieldActive(view: containerEmail)
        } else {
            setTextFieldActive(view: containerPassword)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtEmail {
            setTextFieldDefault(view: containerEmail)
        } else {
            setTextFieldDefault(view: containerPassword)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtEmail.resignFirstResponder()
        } else {
            txtPasswrod.resignFirstResponder()
        }
        
        return true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            formBottomAnchor.constant = keyboardHeight + 50
        }
    }
    
    @objc func keyboardWillHide() {
        formBottomAnchor.constant = 50
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
