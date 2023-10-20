//
//  MainInterface.swift
//  Planificador IFF
//
//  Created by ivan on 02/02/2021.
//

import UIKit

class MainInterface: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        newScheduleOutlet.layer.cornerRadius = 10
        config.layer.cornerRadius = 10
        alarmButton.layer.cornerRadius = 10
        
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        transition.duration = 0.2
        
        alarmText.text = Constantes.constants.nextAlarm
        
        
        if Constantes.constants.viewAlarmList {
            alarmButton.isHidden = false
        }
        else{
            alarmButton.isHidden = true
        }
        
    }
    
    // MARK: - Variables
    
    let transition = CATransition()
    
    var window: UIWindow?
    
    // MARK: - Oulets
    
    @IBOutlet var newScheduleOutlet: UIButton!
    
    @IBOutlet var config: UIButton!
    
    @IBOutlet var alarmButton: UIButton!

    @IBOutlet var alarmText: UILabel!
    // MARK: - Outlet Button Methods

    @IBAction func newScheduleAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = ViewController()
            self.window?.layer.add(self.transition, forKey: "transition")
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
    }
    
    @IBAction func configAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = ConfigScreen()
            
            
            
            self.window?.layer.add(self.transition, forKey: "transition")
            
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
    }
    
    @IBAction func alarmAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = AlarmController()
            self.window?.layer.add(self.transition, forKey: "transition")
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
    }

}
