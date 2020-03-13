//
//  LoginVC.swift
//  Pet Stories
//
//  Created by milind shelat on 09/03/20.
//  Copyright © 2020 milind shelat. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    let lblContainerView : UIView =  {
        let view = UIView()
        
        let lbl = UILabel()
        
        //lbl.frame = CGRect(x: 0, y: 0, width: 250, height: 100)
        lbl.text = "Pet Stories"
        lbl.textColor = UIColor.white
        lbl.font = UIFont(name: "Marker Felt", size: 40)
        //lbl.backgroundColor = UIColor.lightGray
        //lbl.center = view.center
        lbl.textAlignment = .center
        view.addSubview(lbl)
        lbl.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        lbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lbl.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1)
        
        return view
    }()
    
    
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont(name: "Marker Felt", size: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont(name: "Marker Felt", size: 14)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?   ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        
        button.addTarget(self, action: #selector(handleShowsSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color
        view.backgroundColor = .white
        
        // hide nav bar
        navigationController?.navigationBar.isHidden = true
        
        // white status bar
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(lblContainerView)
        lblContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
        configureViewComponents()
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
    }
    
    // MARK: - Handlers
    
    @objc func handleShowsSignUp(){
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func formValidation(){
        guard
            emailTextField.hasText,
            passwordTextField.hasText else {
                
                // handle case for above conditions not met
                loginButton.isEnabled = false
                loginButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
                return
        }
        
        // handle case for conditions were met
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
    
    @objc func handleLogin(){
        print("Login Button Pressed")
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text else { return }

        // sign user in with email and password
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in

            // handle error
            if let error = error {
                print("Unable to sign user in with error", error.localizedDescription)
                return
            }

            guard let mainTabVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabVC else { return }

                mainTabVC.configureViewControllers()
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    func configureViewComponents() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: lblContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
    }
    
}
