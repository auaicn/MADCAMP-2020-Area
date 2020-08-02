//
//  ViewController.swift
//  ImagePicker
//
//  Created by Zedd on 2017. 8. 19..
//  Copyright © 2017년 Zedd. All rights reserved.
//

import UIKit

class LoginController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginAction(_ sender: Any) {
        // storyboard 에서 controller를 찾은후
        // controller 를 찾아야 한다.
        // storyboard 의 scene 마다, id를 부여할 수 있는데,
        // ViewController 의 id 로 "login"을 부여했다.
        
        
        
        
        
        // 이게 있을 수도 없을 수도 있어서 예외처리를 해주어야 한다.
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
    
    @IBAction func registerAction(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "base")
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

