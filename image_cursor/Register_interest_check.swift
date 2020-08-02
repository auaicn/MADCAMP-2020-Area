//
//  Register_interest_check.swift
//  image_cursor
//
//  Created by Apple on 2020/08/03.
//  Copyright © 2020 auaicn_organization. All rights reserved.
//

import UIKit

class Register_interest_check: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
    Jsonobject j
    ListView
    for (int i=0;i<len;i++)
    {
        // check if valid input
        text = get Text
        j+= text;
    }
    transferred json += "interest" + j // as nested
    
    get back to login screen // check 
    */
    @IBAction func register_main_button(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "main")
        {
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
}

