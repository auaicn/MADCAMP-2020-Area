//
//  Register.swift
//  image_cursor
//
//  Created by Apple on 2020/08/03.
//  Copyright © 2020 auaicn_organization. All rights reserved.
//

import UIKit
import Alamofire

class Register_base_field: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var register_name: UITextField!
    @IBOutlet weak var register_id: UITextField!
    @IBOutlet weak var register_phone: UITextField!
    @IBOutlet weak var register_password: UITextField!

    let url = "http://192.249.19.243:0380/user/register"
    
    
    @IBAction func base_to_interest(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "main")
        {
            
            struct Register_base: Encodable {
                 let name: String
                 let id: String
                 let phone: String
                 let password: String
             }

             let register = Register_base(
                 name: register_name.text ?? "default_name",
                 id: register_id.text ?? "default_id",
                 phone: register_phone.text ?? "default phone number",
                 password: register_password.text ?? "default_password")

             AF.request(url,
                        method: .post,
                        parameters: register,
                        encoder: JSONParameterEncoder.default).response { response in
                     //response
                     debugPrint(response)
                         
             }
            
            // null 값이 아니라면, 실행되는 부분
            /*
            navigation view 라는걸 사용한다면 이렇게 구현하면 된다.
            self.navigationController?.pushViewController(controller, animated: true    )
            */
            self.present(controller,animated: true,completion: nil)
            return
        }
        // error
        print("error")
    }
    /*
    get name
    get
     */
}
