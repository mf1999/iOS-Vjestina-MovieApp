import Foundation
import UIKit
import PureLayout

// https://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield
class PaddedTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

class LoginViewController: UIViewController{
    
    private let viewBackgroundColor = UIColor(red: 19/255, green: 59/255, blue: 99/255, alpha: 1)
    private let inputBackgroundColor = UIColor(red:21/255, green:77/255, blue:133/255, alpha:1)
    private let buttonBackgroundColor = UIColor(red:76/255, green: 178/255, blue:223/255, alpha:1)
    
    private var signInLabel: UILabel!
    
    private var emailForm: UIView!
    private var emailLabel: UILabel!
    private var emailInput: PaddedTextField!
    
    private var passwordForm: UIView!
    private var passwordLabel: UILabel!
    private var passwordInput: PaddedTextField!
    
    private var signInButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews(){
        
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){
        
        // https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // create the sign in label
        signInLabel = UILabel()
        signInLabel.text = "Sign in"
        view.addSubview(signInLabel)
        
        // Create the email form subview
        emailForm = UIView()
        
        emailLabel = UILabel()
        emailLabel.text = "Email address"
        
        emailInput = PaddedTextField()
        // https://stackoverflow.com/questions/26076054/changing-placeholder-text-color-with-swift
        emailInput.attributedPlaceholder = NSAttributedString(
            string: "example@email.com",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1)]
        )
        
        emailForm.addSubview(emailLabel)
        emailForm.addSubview(emailInput)
        view.addSubview(emailForm)
        
        // Create the password form subview
        passwordForm = UIView()
        
        passwordLabel = UILabel()
        passwordLabel.text = "Password"
        
        passwordInput = PaddedTextField()
        // https://stackoverflow.com/questions/26076054/changing-placeholder-text-color-with-swift
        passwordInput.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1)]
        )
        
        passwordForm.addSubview(passwordLabel)
        passwordForm.addSubview(passwordInput)
        view.addSubview(passwordForm)
        
        // Create the sign in button
        signInButton = UIButton()
        view.addSubview(signInButton)
    }
    
    private func styleViews(){
        view.backgroundColor = self.viewBackgroundColor
        
        // sign in label
        signInLabel.textColor = .white
        signInLabel.textAlignment = .center
        signInLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        //email form
        emailLabel.textColor = .white
        emailLabel.textAlignment = .left
        emailLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        emailInput.backgroundColor = self.inputBackgroundColor
        emailInput.layer.borderColor = self.buttonBackgroundColor.cgColor
        emailInput.textColor = UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1)
        emailInput.autocapitalizationType = .none
        emailInput.layer.cornerRadius = 10
        emailInput.layer.borderWidth =  1
        
        // password form
        passwordLabel.textColor = .white
        passwordLabel.textAlignment = .left
        passwordLabel.font = .systemFont(ofSize: 14, weight: .semibold)

        passwordInput.backgroundColor = self.inputBackgroundColor
        passwordInput.layer.borderColor = self.buttonBackgroundColor.cgColor
        passwordInput.textColor = UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1)
        passwordInput.isSecureTextEntry = true
        passwordInput.autocorrectionType = .no
        passwordInput.autocapitalizationType = .none
        passwordInput.layer.cornerRadius = 10
        passwordInput.layer.borderWidth =  1
        
        //sign in button
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.layer.cornerRadius = 10
        signInButton.backgroundColor = self.buttonBackgroundColor
        

    }
    
    private func defineLayoutForViews(){
        //sign in label
        signInLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 92 - view.safeAreaInsets.top)
        signInLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        signInLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        
        //email form
        emailLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        emailLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        
        emailInput.autoPinEdge(.top, to: .bottom, of: emailLabel, withOffset: 8)
        emailInput.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        emailInput.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        emailInput.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        emailInput.autoSetDimension(.height, toSize: 48)
        
        emailForm.autoPinEdge(.top, to: .bottom, of: signInLabel, withOffset: 48)
        emailForm.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        emailForm.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        
        //password form
        passwordLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        passwordLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        
        passwordInput.autoPinEdge(.top, to: .bottom, of: passwordLabel, withOffset: 8)
        passwordInput.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        passwordInput.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        passwordInput.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        passwordInput.autoSetDimension(.height, toSize: 48)
        
        passwordForm.autoPinEdge(.top, to: .bottom, of: emailForm, withOffset: 24)
        passwordForm.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        passwordForm.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        
        //sign in button
        signInButton.autoPinEdge(.top, to: .bottom, of: passwordForm, withOffset: 48)
        signInButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 32)
        signInButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 32)
        signInButton.autoSetDimension(.height, toSize: 40)

    }
    
    // Calls this function when the tap is recognized.
    // https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
