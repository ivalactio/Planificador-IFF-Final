//
//  ViewController.swift
//  Planificador IFF
//
//  Created by ivan on 02/02/2021.
//

import UIKit
import MLKit
import UserNotifications

import AVFoundation



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPhotoButton.layer.cornerRadius = 10
        //rebootButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        manualButton.layer.cornerRadius = 10
        recognizerButton.layer.cornerRadius = 10
        sendButton.layer.cornerRadius = 10
        scheduleButton.layer.cornerRadius = 10
        
        
        ciclos.append(ciclo1)
        ciclos.append(ciclo2)
        ciclos.append(ciclo3)
        ciclos.append(ciclo4)
        
        
        
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.duration = 0.2
        
        

    }


    // MARK: - Variables
    let transition = CATransition()
    struct viewGlobal {
        static var firstDay = ""
        
        static var currentMonth = [""]
        
        
    }
    @IBOutlet var stackManual: UIStackView!
    
    @IBOutlet var stackPhoto: UIStackView!
    
    var window: UIWindow?
    
    var resultsText = ""
    var imagePicked: UIImageView!
    
    var ciclos = [[String]]()
    
    var ciclo1 = ["M","M","T","T","N","N","N","D","D"]
    var ciclo2 = ["M","M","T","T","T","N","N","D","D"]
    var ciclo3 = ["M","M","M","T","T","N","N","D","D"]
    var ciclo4 = ["D","D","D","D","D","D","D","D","D"]
    
    var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre", ""]
    
    //var imagePicked: UIImage?
    private var lastFrame: CMSampleBuffer?
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    

    
    
    
    
    // MARK: - Oulets
    
    @IBOutlet var textDetected: UITextField!
    

    @IBOutlet var imageView: UIImageView!
    
    
    @IBOutlet var rebootButton: UIButton!
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var manualButton: UIButton!
    
    @IBOutlet var selectPhotoButton: UIButton!
    
    @IBOutlet var recognizerButton: UIButton!
    
    @IBOutlet weak var recognizeButton: UIBarButtonItem!
    
    @IBOutlet var manualTextButton: UITextField!
    
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var scheduleButton: UIButton!
    // MARK: - Outlet Button Methods
    
    @IBAction func scheduleAction(_ sender: Any) {

        
        if (Int(viewGlobal.firstDay)! >= 1 && Int(viewGlobal.firstDay)! <= 31) {

            var dia = Int(viewGlobal.firstDay)! - 1

            
            
            //for mes in meses {
            var i = 0
            var j = 0
            var first = true
            var mes1 = 0

            while i < ciclos.count  {

                j = 0
                while j < ciclos[i].count {

                    var mensual = (mes1+1)%2
                    switch mensual {
                    case  0:

                        if mes1 == 1{
                            if dia <= 28 {
                                var h = " \n A dia: " + String(dia) + " de " + meses[mes1] + " con horario: " + String(ciclos[i][j])
                                viewGlobal.currentMonth.append(h)
                                if dia == 28 {
                                    mes1 += 1
                                    dia = 0
                                }
                                dia += 1
                            }
                        }
                        else{
                            if dia <= 30 {
                                var h = " \n A dia: " + String(dia) + " de " + meses[mes1] + " con horario: " + String(ciclos[i][j])
                                viewGlobal.currentMonth.append(h)
                                if dia == 30 {
                                    mes1 += 1
                                    dia = 0
                                }
                                dia += 1
                            }
                        }
                    
                    default:
                        if dia <= 31 {
                            var h = " \n B dia: " + String(dia) + " de " + meses[mes1] + " con horario: " + String(ciclos[i][j])
                            viewGlobal.currentMonth.append(h)
                            if dia == 31{
                                mes1 += 1
                                dia = 0
                            }
                            dia += 1
                        }
                    }
                    if i == (ciclos.count - 1) && j == (ciclos[i].count - 1) && mes1 < 11{
                        i = 0
                        j = 0
                    }

                    
                    switch meses[mes1] {
                        case "Enero":
                            Constantes.constants.enero.append(String(ciclos[i][j]))
                        case "Febrero":
                            Constantes.constants.febrero.append(String(ciclos[i][j]))
                        case "Marzo":
                            Constantes.constants.marzo.append(String(ciclos[i][j]))
                        case "Abril":
                            Constantes.constants.abril.append(String(ciclos[i][j]))
                        case "Mayo":
                            Constantes.constants.mayo.append(String(ciclos[i][j]))
                        case "Junio":
                            Constantes.constants.junio.append(String(ciclos[i][j]))
                        case "Julio":
                            Constantes.constants.julio.append(String(ciclos[i][j]))
                        case "Agosto":
                            Constantes.constants.agosto.append(String(ciclos[i][j]))
                        case "Septiembre":
                            Constantes.constants.septiembre.append(String(ciclos[i][j]))
                        case "Octubre":
                            Constantes.constants.octubre.append(String(ciclos[i][j]))
                        case "Noviembre":
                            Constantes.constants.noviembre.append(String(ciclos[i][j]))
                        case "Diciembre":
                            Constantes.constants.diciembre.append(String(ciclos[i][j]))

                        default:
                            print("")
                    }
                    
                    j+=1
                }
                if i < ciclos.count{
                    i+=1
                }else if mes1 != 7{
                    i = 0
                }
                    
            }
   
            DispatchQueue.main.async {
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let vc = MainInterface()

                self.window?.layer.add(self.transition, forKey: "transition")
                self.window?.rootViewController = vc
                self.window?.makeKeyAndVisible()
            }
            
            setAlarm()
        }
        else{
            textDetected.text = manualTextButton.text! + "is a wrong value!"
        }
        
        
        
        
    }
    
    @IBAction func selectButtonAction(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = MainInterface()

            self.window?.layer.add(self.transition, forKey: "transition")
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func recognizeButtonAction(_ sender: Any) {
        clearResults()
        
        textRecognize(image: imageView.image)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        
        if manualTextButton.text! >= "1" && manualTextButton.text! <= "31" {
            viewGlobal.firstDay = manualTextButton.text!
            textDetected.text = manualTextButton.text
            
        }
        else{
            textDetected.text = manualTextButton.text! + "is a wrong value!"
        }
        
    }
    
    @IBAction func endEdit(_ sender: Any) {
        self.resignFirstResponder()
    }
    

    
    @IBAction func manualAction(_ sender: Any) {
        if stackPhoto.isHidden == true {
            manualButton.setTitle("Elegir fecha manualmente", for: .normal)
            stackPhoto.isHidden = false
            stackManual.isHidden = true
        }
        else{
            manualButton.setTitle("Escanear fecha", for: .normal)
            stackPhoto.isHidden = true
            stackManual.isHidden = false
        }
    }
    // MARK: - Functions
        
    
    
    func textRecognize(image: UIImage?){
        guard let image = image else { return }
    
        let onDeviceTextRecognizer = TextRecognizer.textRecognizer()
        
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        
        print("Running On-Device Text Recognition...\n")

        
        extractedFunc(visionImage, onDeviceTextRecognizer)
    }
    
    func scheduleFromPhoto(text: String) {
        let textSplit = text.split(separator: "\n")
        
        var text = "Empiezas el dia "
        var dias = ["0" ]
        var horario = ["" ]
        
        var dia: String
        var horario1: String
        

        for item in textSplit {
            switch item {
            case "A":
                viewGlobal.firstDay = Constantes.constants.turnoA
                text += viewGlobal.firstDay
                textDetected.text = text

                
            case "B":
                viewGlobal.firstDay = Constantes.constants.turnoB
                text += viewGlobal.firstDay
                textDetected.text = text

                
            case "C":
                viewGlobal.firstDay = Constantes.constants.turnoC
                text += viewGlobal.firstDay
                textDetected.text = text
   
                
            case "D":
                viewGlobal.firstDay = Constantes.constants.turnoD
                text += viewGlobal.firstDay
                textDetected.text = text
                
            case "E":
                viewGlobal.firstDay = Constantes.constants.turnoE
                text += viewGlobal.firstDay
                textDetected.text = text
                
            
            default:
                textDetected.text = "Por favor repita la foto"
            }
            
            
            break

        }

    }
    
    func notificationWakeUp(){
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Wake Up!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Rise and shine! It's morning time!", arguments: nil)
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .defaultCritical
        
        var dateInfo = DateComponents()
        dateInfo.hour = 7
        dateInfo.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
         
        // Create the request object.
        let request = UNNotificationRequest(identifier: "MorningAlarm", content: content, trigger: trigger)
        
        

        
        center.add(request)
    }
    
    
    func setAlarm() {
        var diaHoy = Constantes().getDay()
        var hora = getTurno(diaHoy: diaHoy)
        var min = Constantes.constants.minPrevios
        var timeCalculated = Constantes().secondsToHoursMinutesSeconds(minutes: min)
        
        
        if(hora < Constantes().getHour()){

            diaHoy += 1
            hora = getTurno(diaHoy: diaHoy)
        }
        
        var listaTurnos = diaHoy
        var listaMes = Constantes().getMonth()
        
        
        if hora != -1 {
            
            if timeCalculated.2 != 0 {
                
                //print("sonará a las", (hora-1) - timeCalculated.1, ":", 60-timeCalculated.2)
                Constantes.constants.nextAlarm = String("La próxima alarma sonará el dia \(diaHoy) a las  \((hora-1) - timeCalculated.1):\(60-timeCalculated.2)")
                Constantes().notification(day: diaHoy, hour: ((hora - 1) - timeCalculated.1), minutes: (60 - timeCalculated.2))
            }else{
                //print("sonará a las", hora - timeCalculated.1, ":00")
                Constantes().notification(day: diaHoy, hour: 16, minutes: timeCalculated.2 + 1)
                Constantes.constants.nextAlarm = String("La próxima alarma sonará el dia \(diaHoy) a las \(hora - timeCalculated.1):00")
                Constantes().notification(day: diaHoy, hour: (hora - timeCalculated.1), minutes: 00)
            }
            


        }
        else{
            if getTurno(diaHoy: diaHoy + 1) == 06 {
                diaHoy += 1
                hora = getTurno(diaHoy: diaHoy)
                if timeCalculated.2 != 0 {
                    
                    //print("sonará a las", (hora-1) - timeCalculated.1, ":", 60-timeCalculated.2)
                    Constantes.constants.nextAlarm = String("La próxima alarma sonará el dia \(diaHoy) a las  \((hora-1) - timeCalculated.1):\(60-timeCalculated.2)")
                    Constantes().notification(day: diaHoy, hour: ((hora - 1) - timeCalculated.1), minutes: (60 - timeCalculated.2))
                    
                }else{
                    
                    //print("sonará a las", hora - 1, ":00")
                    Constantes.constants.nextAlarm = String("La próxima alarma sonará el dia \(diaHoy) a las \(hora - timeCalculated.1):00")
                    Constantes().notification(day: diaHoy, hour: (hora - timeCalculated.1), minutes: 00)
                }
                listaTurnos += 1
            }
            else {
                Constantes.constants.nextAlarm = String("Mañana tienes libre")
            }
            
        }

        Constantes.constants.viewAlarmList = true
        

    }
    
    func getTurno(diaHoy: Int) -> Int {
        let mesHoy = meses[Constantes().getMonth()-1]

        var turnoHoy: String!

        switch mesHoy {
        
        case "Enero":
            if Constantes.constants.enero.count >= diaHoy {
                turnoHoy = Constantes.constants.enero[ diaHoy]
                
            }
            
        case "Febrero":
            if Constantes.constants.febrero.count >= diaHoy {
                turnoHoy = Constantes.constants.febrero[ diaHoy]
            }
            
        case "Marzo":
            if Constantes.constants.marzo.count >= diaHoy {
                turnoHoy = Constantes.constants.marzo[ diaHoy]
            }
        case "Abril":
            if Constantes.constants.abril.count >= diaHoy {
                turnoHoy = Constantes.constants.abril[ diaHoy]
            }
        case "Mayo":
            if Constantes.constants.mayo.count >= diaHoy {
                turnoHoy = Constantes.constants.mayo[ diaHoy]
            }
        case "Junio":
            if Constantes.constants.junio.count >= diaHoy {
                turnoHoy = Constantes.constants.junio[ diaHoy]
            }
        case "Julio":
            if Constantes.constants.julio.count >= diaHoy {
                turnoHoy = Constantes.constants.julio[ diaHoy]
            }
        case "Agosto":
            if Constantes.constants.agosto.count >= diaHoy {
                turnoHoy = Constantes.constants.agosto[ diaHoy]
            }
        case "Septiembre":
            if Constantes.constants.septiembre.count >= diaHoy {
                turnoHoy = Constantes.constants.septiembre[ diaHoy]
            }
        case "Octubre":
            if Constantes.constants.octubre.count >= diaHoy {
                turnoHoy = Constantes.constants.septiembre[ diaHoy]
            }
        case "Noviembre":
            if Constantes.constants.noviembre.count >= diaHoy {
                turnoHoy = Constantes.constants.noviembre[ diaHoy]
            }
        case "Diciembre":
            if Constantes.constants.diciembre.count >= diaHoy {
                turnoHoy = Constantes.constants.diciembre[ diaHoy]
            }

            
        default:
            print("")
        }
        var min = Constantes.constants.minPrevios

        
        var hora = -1
        
        if turnoHoy == "D"{
            hora = -1
        }else if turnoHoy == "M"{
            hora = 6
        }else if turnoHoy == "T"{
            hora = 14
        }else if turnoHoy == "N"{
            hora = 22
        }
        return hora
    }
    
    func get7Days(diaHoy: Int){
        var i = 1
        var j = 1
        switch Constantes().getMonth() {
        case 1:
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.enero[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.enero[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3)  tienes el turno: \(Constantes.constants.enero[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.enero[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.enero[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.enero[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.enero[diaHoy + 7])")

        case 2:
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.febrero[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.febrero[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3)  tienes el turno: \(Constantes.constants.febrero[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.febrero[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.febrero[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.febrero[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.febrero[diaHoy + 7])")

        case 3:
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.marzo[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.marzo[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3)  tienes el turno: \(Constantes.constants.marzo[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.marzo[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.marzo[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.marzo[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.marzo[diaHoy + 7])")

        case 4:
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.abril[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.abril[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3)  tienes el turno: \(Constantes.constants.abril[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.abril[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.abril[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.abril[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.abril[diaHoy + 7])")

        case 5:
            while i <= 7 {
                if (diaHoy + i) < Constantes.constants.mayo.count{
                    Constantes.constants.following7Days.append("El dia \(diaHoy + i) tienes el turno: \(Constantes.constants.mayo[diaHoy + i])")
                    
                }else if (diaHoy + i) > Constantes.constants.mayo.count{
                    j = 7 - i
                    
                    Constantes.constants.following7Days.append("El dia \(j) tienes el turno: \(Constantes.constants.junio[j])")
                    
                    j += 1
                }
                
                
                
                i += 1
                
                
            }
            /*
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.mayo[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.mayo[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3)  tienes el turno: \(Constantes.constants.mayo[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.mayo[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.mayo[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.mayo[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.mayo[diaHoy + 7])")*/
        case 6:
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.junio[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.junio[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3) tienes el turno: \(Constantes.constants.junio[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.junio[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.junio[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.junio[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.junio[diaHoy + 7])")
        case 7:
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.julio[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.julio[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3) tienes el turno: \(Constantes.constants.julio[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.julio[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.julio[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.julio[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.julio[diaHoy + 7])")
        case 8:
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.agosto[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.agosto[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3) tienes el turno: \(Constantes.constants.agosto[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.agosto[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.agosto[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.agosto[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.agosto[diaHoy + 7])")
        case 9:
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.septiembre[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.septiembre[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3) tienes el turno: \(Constantes.constants.septiembre[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.septiembre[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.septiembre[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.septiembre[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.septiembre[diaHoy + 7])")
        case 10:
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.octubre[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.octubre[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3) tienes el turno: \(Constantes.constants.octubre[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.octubre[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.octubre[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.octubre[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.octubre[diaHoy + 7])")
        case 11:
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.noviembre[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.noviembre[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3) tienes el turno: \(Constantes.constants.noviembre[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.noviembre[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.noviembre[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.noviembre[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.noviembre[diaHoy + 7])")
        case 12:
            Constantes.constants.following7Days.append("El dia \(diaHoy + 1) tienes el turno: \(Constantes.constants.diciembre[diaHoy + 1])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 2) tienes el turno: \(Constantes.constants.diciembre[diaHoy + 2])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 3) tienes el turno: \(Constantes.constants.diciembre[diaHoy + 3])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 4) tienes el turno: \(Constantes.constants.diciembre[diaHoy + 4])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 5) tienes el turno: \(Constantes.constants.diciembre[diaHoy + 5])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 6) tienes el turno: \(Constantes.constants.diciembre[diaHoy + 6])")
            Constantes.constants.following7Days.append("El dia \(diaHoy + 7) tienes el turno: \(Constantes.constants.diciembre[diaHoy + 7])")
        default:
            print("")
        }
        Constantes.constants.viewAlarmList = true
        
    }
    
    
    
    // MARK: - PROCESS METHOD
    
    private func process(_ visionImage: VisionImage, with textRecognizer: TextRecognizer?) {
      weak var weakSelf = self
      textRecognizer?.process(visionImage) { text, error in
        guard let strongSelf = weakSelf else {
          print("Self is nil!")
          return
        }
        guard error == nil, let text = text else {
          let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
          strongSelf.resultsText = "Text recognizer failed with error: \(errorString)"
          strongSelf.showResults()
          return
        }
        // Blocks.
        for block in text.blocks {
          let transformedRect = block.frame.applying(strongSelf.transformMatrix())
          UIUtilities.addRectangle(
            transformedRect,
            to: strongSelf.annotationOverlayView,
            color: UIColor.purple
          )

          // Lines.
          for line in block.lines {
            let transformedRect = line.frame.applying(strongSelf.transformMatrix())
            UIUtilities.addRectangle(
              transformedRect,
              to: strongSelf.annotationOverlayView,
              color: UIColor.orange
            )

            // Elements.
            for element in line.elements {
              let transformedRect = element.frame.applying(strongSelf.transformMatrix())
              UIUtilities.addRectangle(
                transformedRect,
                to: strongSelf.annotationOverlayView,
                color: UIColor.green
              )
              let label = UILabel(frame: transformedRect)
              label.text = element.text
              label.adjustsFontSizeToFitWidth = true
              strongSelf.annotationOverlayView.addSubview(label)
            }
          }
        }

        self.textDetected.text = text.text
        
        self.scheduleFromPhoto(text: text.text)
      }
    }
    
    
    
    private func transformMatrix() -> CGAffineTransform {
      guard let image = imageView.image else { return CGAffineTransform() }
      let imageViewWidth = imageView.frame.size.width
      let imageViewHeight = imageView.frame.size.height
      let imageWidth = image.size.width
      let imageHeight = image.size.height

      let imageViewAspectRatio = imageViewWidth / imageViewHeight
      let imageAspectRatio = imageWidth / imageHeight
      let scale =
        (imageViewAspectRatio > imageAspectRatio)
        ? imageViewHeight / imageHeight : imageViewWidth / imageWidth


      let scaledImageWidth = imageWidth * scale
      let scaledImageHeight = imageHeight * scale
      let xValue = (imageViewWidth - scaledImageWidth) / CGFloat(2.0)
      let yValue = (imageViewHeight - scaledImageHeight) / CGFloat(2.0)

      var transform = CGAffineTransform.identity.translatedBy(x: xValue, y: yValue)
      transform = transform.scaledBy(x: scale, y: scale)
      return transform
    }
    private lazy var annotationOverlayView: UIView = {
      precondition(isViewLoaded)
      let annotationOverlayView = UIView(frame: .zero)
      annotationOverlayView.translatesAutoresizingMaskIntoConstraints = false
      annotationOverlayView.clipsToBounds = true
      return annotationOverlayView
    }()
    
    // MARK: - Private Functions
    fileprivate func extractedFunc(_ visionImage: VisionImage, _ onDeviceTextRecognizer: TextRecognizer) {
        process(visionImage, with: onDeviceTextRecognizer)
    }
    
    private func recognizeTextOnDevice(in image: VisionImage, width: CGFloat, height: CGFloat) {

      var recognizedText: Text

      do {
        recognizedText = try TextRecognizer.textRecognizer().results(in: image)
      } catch let error {
        print("Failed to recognize text with error: \(error.localizedDescription).")
        return
      }
        
      DispatchQueue.main.sync {
        
        self.updatePreviewOverlayView()
        self.removeDetectionAnnotations()

        // Blocks.
        for block in recognizedText.blocks {
          let points = self.convertedPoints(from: block.cornerPoints, width: width, height: height)
          UIUtilities.addShape(
            withPoints: points,
            to: self.annotationOverlayView,
            color: UIColor.purple
          )

          // Lines.
          for line in block.lines {
            let points = self.convertedPoints(from: line.cornerPoints, width: width, height: height)
            UIUtilities.addShape(
              withPoints: points,
              to: self.annotationOverlayView,
              color: UIColor.orange
            )

            // Elements.
            for element in line.elements {
              let normalizedRect = CGRect(
                x: element.frame.origin.x / width,
                y: element.frame.origin.y / height,
                width: element.frame.size.width / width,
                height: element.frame.size.height / height
              )

              let convertedRect = self.previewLayer.layerRectConverted(
                fromMetadataOutputRect: normalizedRect
              )
              UIUtilities.addRectangle(
                convertedRect,
                to: self.annotationOverlayView,
                color: UIColor.green
              )
              let label = UILabel(frame: convertedRect)

              label.text = element.text
              label.adjustsFontSizeToFitWidth = true
              self.annotationOverlayView.addSubview(label)
            }
          }
        }
      }
    }

    
    private func convertedPoints(
      from points: [NSValue]?,
      width: CGFloat,
      height: CGFloat
    ) -> [NSValue]? {
      return points?.map {
        let cgPointValue = $0.cgPointValue
        let normalizedPoint = CGPoint(x: cgPointValue.x / width, y: cgPointValue.y / height)
        
        let cgPoint = previewLayer.layerPointConverted(fromCaptureDevicePoint: normalizedPoint)
        let value = NSValue(cgPoint: cgPoint)
        return value
      }
        
    }
    
    
    private func updatePreviewOverlayView() {
      guard let lastFrame = lastFrame,
        let imageBuffer = CMSampleBufferGetImageBuffer(lastFrame)
      else {
        return
      }
    }
    
    private func showResults() {
      let resultsAlertController = UIAlertController(
        title: "Detection Results",
        message: nil,
        preferredStyle: .actionSheet
      )
      resultsAlertController.addAction(
        UIAlertAction(title: "OK", style: .destructive) { _ in
          resultsAlertController.dismiss(animated: true, completion: nil)
        }
      )
      resultsAlertController.message = resultsText
      resultsAlertController.popoverPresentationController?.barButtonItem = recognizeButton
      resultsAlertController.popoverPresentationController?.sourceView = self.view
      present(resultsAlertController, animated: true, completion: nil)
 
    }
    private func removeDetectionAnnotations() {
      for annotationView in annotationOverlayView.subviews {
        annotationView.removeFromSuperview()
      }
    }
    private func clearResults() {
      removeDetectionAnnotations()
      self.resultsText = ""
    }

}

// MARK: - Extension


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage{
            imageView.image = image

        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

// MARK: - Constants
public enum Detector: String {
case onDeviceBarcode = "On-Device Barcode Scanner"
case onDeviceFace = "On-Device Face Detection"
case onDeviceText = "On-Device Text Recognition"
case onDeviceObjectProminentNoClassifier = "ODT, single, no labeling"
case onDeviceObjectProminentWithClassifier = "ODT, single, labeling"
case onDeviceObjectMultipleNoClassifier = "ODT, multiple, no labeling"
case onDeviceObjectMultipleWithClassifier = "ODT, multiple, labeling"
case onDeviceObjectCustomProminentNoClassifier = "ODT, custom, single, no labeling"
case onDeviceObjectCustomProminentWithClassifier = "ODT, custom, single, labeling"
case onDeviceObjectCustomMultipleNoClassifier = "ODT, custom, multiple, no labeling"
case onDeviceObjectCustomMultipleWithClassifier = "ODT, custom, multiple, labeling"
case poseAccurate = "Pose, accurate"
case poseFast = "Pose, fast"
}

private enum Constant {
static let alertControllerTitle = "Vision Detectors"
static let alertControllerMessage = "Select a detector"
static let cancelActionTitleText = "Cancel"
static let videoDataOutputQueueLabel = "com.google.mlkit.visiondetector.VideoDataOutputQueue"
static let sessionQueueLabel = "com.google.mlkit.visiondetector.SessionQueue"
static let noResultsMessage = "No Results"
static let localModelFile = (name: "bird", type: "tflite")
static let labelConfidenceThreshold: Float = 0.75
static let smallDotRadius: CGFloat = 4.0
static let lineWidth: CGFloat = 3.0
static let originalScale: CGFloat = 1.0
static let padding: CGFloat = 10.0
static let resultsLabelHeight: CGFloat = 200.0
static let resultsLabelLines = 5
}
private enum Constants {
static let images = [
"grace_hopper.jpg", "barcode_128.png", "qr_code.jpg", "beach.jpg",
"image_has_text.jpg", "liberty.jpg", "bird.jpg",
]

static let detectionNoResultsMessage = "No results returned."
static let failedToDetectObjectsMessage = "Failed to detect objects in image."
static let localModelFile = (name: "bird", type: "tflite")
static let labelConfidenceThreshold = 0.75
static let smallDotRadius: CGFloat = 5.0
static let largeDotRadius: CGFloat = 10.0
static let lineColor = UIColor.yellow.cgColor
static let lineWidth: CGFloat = 3.0
static let fillColor = UIColor.clear.cgColor
static let segmentationMaskAlpha: CGFloat = 0.5
}

