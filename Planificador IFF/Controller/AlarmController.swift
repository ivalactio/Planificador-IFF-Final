//
//  AlarmController.swift
//  Planificador IFF
//
//  Created by ivan on 02/02/2021.
//


import UIKit
import UserNotifications
import AVFoundation
import BackgroundTasks



class AlarmController: UIViewController, AVAudioPlayerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Constantes().set7FollowingDays()
        print("following days: ", Constantes.constants.following7Days)
        alarm1.text = (Constantes.constants.following7Days[1] )
        alarm2.text = (Constantes.constants.following7Days[2] as! String)
        alarm3.text = (Constantes.constants.following7Days[3] as! String)
        alarm4.text = (Constantes.constants.following7Days[4] as! String)
        alarm5.text = (Constantes.constants.following7Days[5] as! String)
        alarm6.text = (Constantes.constants.following7Days[6] as! String)
        //alarm7.text = (Constantes.constants.following7Days[7] as! String)
        
        backButton.layer.cornerRadius = 10
        consultButton.layer.cornerRadius = 10
        sendButton.layer.cornerRadius = 10
        
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        transition.duration = 0.2
        
    }
    
    //MARK: - Variables
    
    var window: UIWindow?
    
    let transition = CATransition()
    
    
    //MARK: - Outlets
    
    @IBOutlet var proxAlarms: UILabel!
    
    @IBOutlet var alarm1: UILabel!
    
    @IBOutlet var alarm2: UILabel!
    
    @IBOutlet var alarm3: UILabel!
    
    @IBOutlet var alarm4: UILabel!
    
    @IBOutlet var alarm5: UILabel!
    
    @IBOutlet var alarm6: UILabel!
    
    //@IBOutlet var alarm7: UILabel!
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var consultButton: UIButton!
    
    @IBOutlet var Days7: UIStackView!
    
    @IBOutlet var consultDay: UIStackView!
    
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var text: UITextField!
    
    
    @IBOutlet var resultText: UILabel!
    
    

    
    //MARK: - Outlet Actions
    @IBAction func turnQueryText(_ sender: Any) {
        self.resignFirstResponder()
    }
    @IBAction func sendButtonAction(_ sender: Any) {
        var mesdia = text.text?.split(separator: "/")
        if mesdia!.count > 0 {
            var dia = Int(mesdia![0])
            switch mesdia![1] {
            case "1":
                resultText.text = "El dia \(Int(dia!)) de enero haces el turno  \(Constantes.constants.enero[dia!])"
            case "2":
                resultText.text = "El dia \(Int(dia!)) de febrero haces el turno  \(Constantes.constants.febrero[dia!])"
            case "3":
                resultText.text = "El dia \(Int(dia!)) de marzo haces el turno  \(Constantes.constants.marzo[dia!])"
            case "4":
                resultText.text = "El dia \(Int(dia!)) de abril haces el turno  \(Constantes.constants.abril[dia!])"
            case "5":
                resultText.text = "El dia \(Int(dia!)) de mayo haces el turno  \(Constantes.constants.mayo[dia!])"
            case "6":
                resultText.text = "El dia \(Int(dia!)) de junio haces el turno  \(Constantes.constants.junio[dia!])"
            case "7":
                resultText.text = "El dia \(Int(dia!)) de julio haces el turno  \(Constantes.constants.julio[dia!])"
            case "8":
                resultText.text = "El dia \(Int(dia!)) de agosto haces el turno  \(Constantes.constants.agosto[dia!])"
            case "9":
                resultText.text = "El dia \(Int(dia!)) de septiembre haces el turno  \(Constantes.constants.septiembre[dia!])"
            case "10":
                resultText.text = "El dia \(Int(dia!)) de octubre haces el turno  \(Constantes.constants.octubre[dia!])"
            case "11":
                resultText.text = "El dia \(Int(dia!)) de noviembre haces el turno  \(Constantes.constants.noviembre[dia!])"
            case "12":
                resultText.text = "El dia \(Int(dia!)) de diciembre haces el turno  \(Constantes.constants.diciembre[dia!])"
                
            default:
                print("")
            }
        }
        
    }
    @IBAction func consultAction(_ sender: Any) {
        
        if Days7.isHidden {
            consultButton.setTitle("Consultar dia", for: .normal)
            Days7.isHidden = false
            consultDay.isHidden = true
            proxAlarms.text = "Próximas alarmas"
        }
        else{
            consultButton.setTitle("7 próximos dias", for: .normal)
            
            Days7.isHidden = true
            consultDay.isHidden = false
            proxAlarms.text = "Consulta el turno que harás X dia"
            
        }
        
        
        
    }
    @IBAction func backButtonAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = MainInterface()

            self.window?.layer.add(self.transition, forKey: "transition")
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
    }
   
}


