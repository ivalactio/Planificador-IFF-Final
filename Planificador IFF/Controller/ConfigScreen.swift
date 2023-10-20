//
//  ConfigScreen.swift
//  Planificador IFF
//
//  Created by ivan on 02/02/2021.
//

import UIKit

class ConfigScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.layer.cornerRadius = 10
        sendButton.layer.cornerRadius = 10
        modifyButton.layer.cornerRadius = 10
        minutesButton.layer.cornerRadius = 10
        sendMinutesButton.layer.cornerRadius = 10
        
        text.text = ViewController.viewGlobal.firstDay
        
        
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.duration = 0.2

    }
    
    struct configGlobal {
        static var previewMinutes = "minutos Previos"
    }
    
    //MARK: - Variables
    let transition = CATransition()
    var window: UIWindow?
    
    var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    
    
    
    
    //MARK: - Oulets
    @IBOutlet var backButton: UIButton!
    
   
   @IBOutlet var minutesText: UITextField!
   
   @IBOutlet var sendButton: UIButton!
   @IBOutlet var modifyButton: UIButton!
   
   @IBOutlet var text: UITextField!
   @IBOutlet var sendMinutesButton: UIButton!
   
   @IBOutlet var minutesButton: UIButton!

    
    
    
    
    //MARK: - Outlet Actions

    @IBAction func backAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = MainInterface()

            self.window?.layer.add(self.transition, forKey: "transition")
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
        
    }
    @IBAction func sendAction(_ sender: Any) {
        var new = text.text?.split(separator: "/")
        //print("split: ", text.text?.split(separator: ","))
        print(new?.count)
        if (new?.count == 3) {
            //var new = text.text?.split(separator: "/")
            
            var dia = Int(new![0])
            var mesNum = Int(new![1])! - 1
            //var mes = meses[mesNum]
            var horario = new![2]
            
            switch mesNum {
            case 1:
                Constantes.constants.enero[dia!]   = String(horario)
            case 2:
                Constantes.constants.febrero[dia!]   = String(horario)
            case 3:
                Constantes.constants.marzo[dia!]   = String(horario)
            case 4:
                Constantes.constants.abril[dia!]   = String(horario)
            case 5:
                Constantes.constants.mayo[dia!]   = String(horario)
            case 6:
                Constantes.constants.junio[dia!]   = String(horario)
            case 7:
                Constantes.constants.julio[dia!]   = String(horario)
            case 8:
                Constantes.constants.agosto[dia!]   = String(horario)
            case 9:
                Constantes.constants.septiembre[dia!]   = String(horario)
            case 10:
                Constantes.constants.octubre[dia!]   = String(horario)
            case 11:
                Constantes.constants.noviembre[dia!]   = String(horario)
            case 12:
                Constantes.constants.diciembre[dia!]   = String(horario)

            default:
                print("")
            }
            sendButton.isHidden = true
            text.isHidden = true
            modifyButton.isHidden = false
            
            var hora = 0
            switch new![2] {
            case "M":
                hora = 06
            case "T":
                hora = 14
            case "N":
                hora = 22
            case "D":
                hora = -1
            default:
                print("")
            }
            
            var min = Constantes.constants.minPrevios
            var timeCalculated = Constantes().secondsToHoursMinutesSeconds(minutes: min)
            
            
            
            if (Constantes().getDay() + 1) == dia {
                Constantes.constants.nextAlarm = String("La próxima alarma sonará el dia \(dia) a las  \(hora - timeCalculated.1):\(60 - timeCalculated.2)")

            }
            
            
        }else{
            text.text = "¡Valores incorrectos!"
        }

    }
    @IBAction func endEdit(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    @IBAction func modifyAction(_ sender: Any) {
        sendButton.isHidden = false
        modifyButton.isHidden = true
        text.isHidden = false
    }
    
    @IBAction func sendMinutesAction(_ sender: Any) {
        var minutes = Int(minutesText.text!)
        
        if minutes! >= 1 && minutes! <= 180 {
            ViewController.viewGlobal.firstDay = text.text!
            sendMinutesButton.isHidden = true
            minutesText.isHidden = true
            minutesButton.isHidden = false
            configGlobal.previewMinutes = minutesText.text!
            
            Constantes.constants.minPrevios = minutes ?? 60
        }
        else{
            minutesText.text = "¡Máximo 3H!"
        }
    }
    
    @IBAction func minutesAction(_ sender: Any) {
        sendMinutesButton.isHidden = false
        minutesText.isHidden = false
        minutesButton.isHidden = true
    }
    @IBAction func endEdit2(_ sender: Any) {
        self.resignFirstResponder()
    }
    //MARK: - Functions
    
    
    
    


}
