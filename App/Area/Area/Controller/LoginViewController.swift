//
//  ViewController.swift
//  ImagePicker
//
//  Created by Zedd on 2017. 8. 19..
//  Copyright © 2017년 Zedd. All rights reserved.
//

import UIKit
import Alamofire
import UnderKeyboard

class LoginViewController: UIViewController{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    let underKeyboardLayoutConstraint = UnderKeyboardLayoutConstraint()

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        underKeyboardLayoutConstraint.setup(bottomLayoutConstraint, view: view)
        
        let bottomLine = CALayer()
        let bottomLine1 = CALayer()
        
        let screenRect = UIScreen.main.bounds
        
        bottomLine.frame = CGRect(x:0, y:email.frame.height - 3, width:screenRect.size.width-50, height:1)
        bottomLine1.frame = CGRect(x:0, y:password.frame.height - 3, width:screenRect.size.width-50, height:1)
        
        bottomLine.backgroundColor = UIColor.init(red:150/255, green:150/255, blue:150/255, alpha:1).cgColor
        bottomLine1.backgroundColor = UIColor.init(red:150/255, green:150/255, blue:150/255, alpha:1).cgColor
        
        //Remove border on text field
        email.borderStyle = .none
        password.borderStyle = .none
        
        //Add the line to the text field
        email.layer.addSublayer(bottomLine)
        password.layer.addSublayer(bottomLine1)
    }
    
    let url = "http://192.249.19.243:0380/users/login"
    
    @IBAction func loginAction(_ sender: Any) {
        // storyboard 에서 controller를 찾은후
        // controller 를 찾아야 한다.
        // storyboard 의 scene 마다, id를 부여할 수 있는데,
        // ViewController 의 id 로 "login"을 부여했다.
        debugPrint("login action")
        
        var valid_email = false;
        
        if(isValidEmail(email.text ?? ""))
        {
            valid_email = true;
        }
        if(valid_email == false)
        {
            debugPrint("invalid email")
            // return
        }
        if(password.text == "")
        {
            debugPrint("please enter password")
            return
        }
        
        struct Login: Encodable {
            let email: String
            let password: String
        }

        let login = Login(email: email.text ?? "default_id", password: password.text ?? "default_password")

        debugPrint(login)
        
        AF.request(url,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default)
            //.validate(statusCode: 200..<300)
            .response { response in
                // response
                debugPrint("response")
                debugPrint(response)
                debugPrint(response.data)
        }
        
        // response success 면,
        
        
        
        // 이게 있을 수도 없을 수도 있어서 예외처리를 해주어야 한다.
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Home")
        {
            self.present(controller,animated: true,completion: nil)
            return
        }
        // error
        print("error")
    }
    
    @IBAction func registerAction(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Register")
              {
                  self.present(controller,animated: true,completion: nil)
                  return
              }
              // error
              print("error")
    }
}

