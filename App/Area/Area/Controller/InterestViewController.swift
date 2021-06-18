//
//  Register_interest_check.swift
//  Area
//
//  Created by Apple on 2020/08/03.
//  Copyright © 2020 auaicn_organization. All rights reserved.
//

import UIKit
import Alamofire

class InterestViewController: UIViewController{
    
    @IBOutlet weak var interestEvent: InterestViewController!
    @IBOutlet weak var interestAudition: InterestViewController!
    @IBOutlet weak var interestFestival: InterestViewController!
    @IBOutlet weak var interestEducation: interestButton!
    @IBOutlet weak var interestClub: interestButton!
    @IBOutlet weak var interestCompetition: interestButton!
    @IBOutlet weak var interestNotice: interestButton!
    @IBOutlet weak var interestExhibition: interestButton!
    @IBOutlet weak var interestRecruitment: interestButton!
    @IBOutlet weak var interestSeminar: interestButton!
    @IBOutlet weak var interestVolunteer: interestButton!
    @IBOutlet weak var interestDemoday: interestButton!

    var visit = [Bool?](repeating: false, count: 100)
    var interests:String = "interests:"
    let array: [String] = ["event", "audition", "festival", "education", "club", "competition", "notice", "exhibition", "recruitment", "seminar", "volunteer", "demoday"]

    let url = "http://192.249.19.243:0380/users/register"
    
    let ad = UIApplication.shared.delegate as? AppDelegate
    
    var transfered_register_struct : AppDelegate.Register = AppDelegate.Register(profile: AppDelegate.Register_base(name: "", email: "", phone: "", password: ""), interests: [])
    
    override func viewWillAppear(_ animated: Bool) {
        // let ad = UIApplication.shared.delegate as? AppDelegate
        // register information 이 optional information 이기 때문에, ?? 나 ! 을 써줘야한다.
        // 여기서 실행이 막히면, 프로그램이 종료된다.
        transfered_register_struct = ad!.register_information
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0 ... 99{
            visit[i] = false
        }
    }
    
    // @IBOutlet weak var stackView1: UIStackView!
    // @IBOutlet var stackViews: [UIStackView]!
    @IBAction func buttonPressed(_ sender: UIButton) {
        visit[sender.tag] = !(visit[sender.tag] ?? false)
        
        if(visit[sender.tag] == true)
        {
            sender.backgroundColor = UIColor.black
        }
        else
        {
            sender.backgroundColor = UIColor.white
        }
        // interests += "Button \(sender.tag + 1) was pressed" + " and "
    }
    
    @IBAction func register_main_button(_ sender: Any) {
        //interests += "["
        for i in 0 ... 99{
            if(visit[i] == true)
            {
                interests += array[i] + " "
            }
        }
        //interests += "]"
        
        transfered_register_struct.interests = [self.interests]
        
        debugPrint(transfered_register_struct)
        
        AF.request(url,
                   method: .post,
                   parameters: transfered_register_struct,
                   encoder: JSONParameterEncoder.default).response { response in
                // response
                debugPrint(response)
                debugPrint(response.data)
        }
        
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Home")
        {
            self.present(controller,animated: true,completion: nil)
            debugPrint(interests)
            return
        }
    
        // error
        print("error")
    }
}

