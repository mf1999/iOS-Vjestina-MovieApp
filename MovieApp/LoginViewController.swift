import UIKit
import PureLayout

class LogInViewController: UIViewController{
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
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
        //create scroll view
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        // create the sign in label
        signInLabel = UILabel()
        contentView.addSubview(signInLabel)
        
        // Create the email form subview
        emailForm = UIView()
        emailLabel = UILabel()
        emailInput = PaddedTextField()
        
        emailForm.addSubview(emailLabel)
        emailForm.addSubview(emailInput)
        contentView.addSubview(emailForm)
        
        // Create the password form subview
        passwordForm = UIView()
        passwordLabel = UILabel()
        passwordInput = PaddedTextField()
        
        passwordForm.addSubview(passwordLabel)
        passwordForm.addSubview(passwordInput)
        contentView.addSubview(passwordForm)
        
        // Create the sign in button
        signInButton = UIButton()
        contentView.addSubview(signInButton)
    }
    
    
    private func styleViews(){
        view.backgroundColor = UIColor.viewBackgroundColor
        scrollView.bounces = true

        // sign in label
        signInLabel.text = "Sign in"
        signInLabel.textColor = .white
        signInLabel.textAlignment = .center
        signInLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        //email form
        emailLabel.text = "Email address"
        emailLabel.textColor = .white
        emailLabel.textAlignment = .left
        emailLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        emailInput.attributedPlaceholder = NSAttributedString(
            string: "example@email.com",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1)]
        )
        emailInput.backgroundColor = UIColor.inputBackgroundColor
        emailInput.layer.borderColor = UIColor.buttonBackgroundColor.cgColor
        emailInput.textColor = UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1)
        emailInput.autocapitalizationType = .none
        emailInput.layer.cornerRadius = 10
        emailInput.layer.borderWidth =  1
        
        // password form
        passwordLabel.text = "Password"
        passwordLabel.textColor = .white
        passwordLabel.textAlignment = .left
        passwordLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        passwordInput.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1)]
        )
        passwordInput.backgroundColor = UIColor.inputBackgroundColor
        passwordInput.layer.borderColor = UIColor.buttonBackgroundColor.cgColor
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
        signInButton.backgroundColor = UIColor.buttonBackgroundColor
    }
    
    private func defineLayoutForViews(){
        //scroll view
        scrollView.autoPinEdgesToSuperviewSafeArea()
        contentView.autoPinEdgesToSuperviewEdges()
        contentView.autoMatch(.width, to: .width, of: view)
        contentView.autoSetDimension(.height, toSize: view.bounds.height)
        
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
}
