//
//  Register.swift
//  Area
//
//  Created by Apple on 2020/08/03.
//  Copyright © 2020 auaicn_organization. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController{
    
    func isValidEmail(_ email: String) -> Bool {
        debugPrint("checking if valid email is given")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @IBOutlet weak var register_name: UITextField!
    @IBOutlet weak var register_email: UITextField!
    @IBOutlet weak var register_phone: UITextField!
    @IBOutlet weak var register_password: UITextField!
    
    override func viewDidLoad() {
        debugPrint("register basic information page loaded")
        super.viewDidLoad()
        
        let bottomLine2 = CALayer()
        let bottomLine3 = CALayer()
        let bottomLine4 = CALayer()
        let bottomLine5 = CALayer()
        
        let screenRect = UIScreen.main.bounds
        
        bottomLine2.frame = CGRect(x:0, y:register_name.frame.height - 3, width:screenRect.size.width-50, height:1)
        bottomLine3.frame = CGRect(x:0, y:register_email.frame.height - 3, width:screenRect.size.width-50, height:1)
        bottomLine4.frame = CGRect(x:0, y:register_phone.frame.height - 3, width:screenRect.size.width-50, height:1)
        bottomLine5.frame = CGRect(x:0, y:register_password.frame.height - 3, width:screenRect.size.width-50, height:1)
        
        bottomLine2.backgroundColor = UIColor.init(red:150/255, green:150/255, blue:150/255, alpha:1).cgColor
        bottomLine3.backgroundColor = UIColor.init(red:150/255, green:150/255, blue:150/255, alpha:1).cgColor
        bottomLine4.backgroundColor = UIColor.init(red:150/255, green:150/255, blue:150/255, alpha:1).cgColor
        bottomLine5.backgroundColor = UIColor.init(red:150/255, green:150/255, blue:150/255, alpha:1).cgColor
        
        //Remove border on text field
        register_name.borderStyle = .none
        register_email.borderStyle = .none
        register_phone.borderStyle = .none
        register_password.borderStyle = .none
        
        //Add the line to the text field
        register_name.layer.addSublayer(bottomLine2)
        register_email.layer.addSublayer(bottomLine3)
        register_phone.layer.addSublayer(bottomLine4)
        register_password.layer.addSublayer(bottomLine5)
    }
    

    
    @IBAction func base_to_interest(_ sender: Any) {
    
        debugPrint("register1 to register 2 button clicked")
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Interest")
        {

            /*
             let register = Register_base(
                 name: register_name.text ?? "default_name",
                 email: register_email.text ?? "default_email",
                 phone: register_phone.text ?? "default phone number",
                 password: register_password.text ?? "default_password")
            */
            
            if(register_name.text == "" || register_name.text == nil)
            {
                debugPrint("please enter name")
                return
            }
            if(register_email.text == "" || register_email.text == nil)
            {
                debugPrint("please enter email")
                return
            }
            if(isValidEmail(register_email.text ?? "") == false)
           {
                debugPrint("invalid email")
                // return;
           }
            if(register_phone.text == "" || register_phone.text == nil)
            {
                debugPrint("please enter phone number")
                return
            }
            if(register_password.text == "" || register_password.text == nil)
            {
                debugPrint("please enter password")
                return
            }
            
            // valid input
            let ad = UIApplication.shared.delegate as? AppDelegate

            ad?.register_information.profile.email = register_email.text ?? ""
            ad?.register_information.profile.password = register_password.text ?? ""
            ad?.register_information.profile.name = register_name.text ?? ""
            ad?.register_information.profile.phone = register_phone.text ?? ""

            /*
             AF.request(url,
                        method: .post,
                        parameters: register,
                        encoder: JSONParameterEncoder.default).response { response in
                     //response
                     debugPrint(response)
                         
             }
            */
            // not requested here
            
            self.present(controller,animated: true,completion: nil)
            return
        }
        // error
        print("error")
    }
}
