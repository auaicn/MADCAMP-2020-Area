//
//  Register.swift
//  image_cursor
//
//  Created by Apple on 2020/08/03.
//  Copyright © 2020 auaicn_organization. All rights reserved.
//

import UIKit

class Register_base_field: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func base_to_interest(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "interest")
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
    /*
    get name
    get
     */
}
