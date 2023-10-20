//
//  Constants.swift
//  Planificador IFF
//
//  Created by ivan on 02/02/2021.
//

import Foundation
import AVFoundation
import SwiftUI
import UserNotifications

class Constantes {
    
    //MARK: - Variables

    private var audioPlayer: AVAudioPlayer?
    
    
    //MARK: - Variables de fecha
    
    var timer: Timer?
    
    let date = Date()
    
    let hour = Calendar.current.component(.hour, from: Date())
    
    let minutes = Calendar.current.component(.minute, from: Date())
    
    
    //MARK: - CONSTANTS
    struct constants{
        static var minPrevios = 60
        
        static var nextAlarm = "Aquí aparecerá la próxima alarma"
        
        static var enero = ["DIA 0"]
        static var febrero = ["DIA 0"]
        static var marzo = ["DIA 0"]
        static var abril = ["DIA 0"]
        static var mayo = ["DIA 0"]
        static var junio = ["DIA 0"]
        static var julio = ["DIA 0"]
        static var agosto = ["DIA 0"]
        static var septiembre = ["DIA 0"]
        static var octubre = ["DIA 0"]
        static var noviembre = ["DIA 0"]
        static var diciembre = ["DIA 0"]

        static var M = 6 // MAÑANA
        static var T = 14 // TARDE
        static var N = 22 // NOCHE
        static var D = -1 // DESCANSO
        
        static var following7Days = ["NO_CONTAR"]
        
        static var viewAlarmList = false
        
        
        static var turnoC = "4"
        static var turnoB = "0"
        static var turnoA = "25"
        static var turnoE = "18"
        static var turnoD = "11"
        
    }
    //MARK: - GETTERS
    func getDay() -> (Int) {
        return date.get(.day)
    }
    
    func getDay(day: Int) -> (Int) {
        return date.get(.day)
    }
    
    func getMonth() -> (Int) {
        return date.get(.month)
    }
    
    func getHour() -> (Int) {
        return hour
    }
    
    func getMinutes() -> (Int) {
        return minutes
    }

    func getMonthDays() -> (Int){
        var mes = getMonth()
        var dias = 0
        switch mes {
        case 1:
            dias = 31
        case 2:
            dias = 28
        case 3:
            dias = 31
        case 4:
            dias = 30
        case 5:
            dias = 31
        case 6:
            dias = 30
        case 7:
            dias = 31
        case 8:
            dias = 31
        case 9:
            dias = 30
        case 10:
            dias = 31
        case 11:
            dias = 30
        case 12:
            dias = 31
        
        default:
            print("")
        }
        
        
        
        return dias
    }
    //MARK: - SETTERS
    
    func set7FollowingDays() {
        
        var diasRest = getMonthDays() - getDay()
        var i = 1
        var j = 1
        print("MES: ", getMonth())
        while i <= 7 && j < diasRest {
            
            switch getMonth() {
            case 1:
                
                if  diasRest > i {
                    constants.following7Days.append("El dia \(getDay() + i) de enero tienes el turno: \(constants.enero[getDay() + i])")
                    print("added: ",constants.enero[i])
                }else {
                    constants.following7Days.append("El dia \(j) de febrero tienes el turno: \(constants.febrero[j])")
                    print("added: ",constants.febrero[j])
                    j += 1
                }
                
            case 2:
                if  diasRest > i {
                    constants.following7Days.append("El dia \(getDay() + i) de febrero tienes el turno: \(constants.febrero[getDay() + i])")
                    print("added: ",constants.febrero[i])
                }else {
                    constants.following7Days.append("El dia \(j) de marzo tienes el turno: \(constants.marzo[j])")
                    print("added: ",constants.marzo[j])
                    j += 1
                }
            case 3:
                if  diasRest > i {
                    constants.following7Days.append("El dia \(getDay() + i) de marzo tienes el turno: \(constants.marzo[getDay() + i])")
                    print("added: ",constants.marzo[i])
                }else {
                    constants.following7Days.append("El dia \(j) de abril tienes el turno: \(constants.abril[j])")
                    print("added: ",constants.abril[j])
                    j += 1
                }
            case 4:
                if  diasRest > i {
                    constants.following7Days.append("El dia \(getDay() + i) de abril tienes el turno: \(constants.abril[getDay() + i])")
                }else {
                    constants.following7Days.append("El dia \(j) de mayo tienes el turno: \(constants.mayo[j]))")
                    j += 1
                }
            case 5:
                if  diasRest > i {
                    constants.following7Days.append("El dia \(getDay() + i) de mayo tienes el turno: \(constants.mayo[getDay() + i])")
                }else {
                    constants.following7Days.append("El dia \(j) de junio tienes el turno: \(constants.junio[j])")
                    j += 1
                   
                }
            case 6:
                if  diasRest > i {
                    constants.following7Days.append("El dia \(getDay() + i) de junio tienes el turno: \(constants.junio[getDay() + i])")
                }else {
                    constants.following7Days.append("El dia \(j) de julio tienes el turno: \(constants.julio[j])")
                    j += 1
                }
            case 7:
                if  diasRest > i {
                    constants.following7Days.append("El dia \(getDay() + i) de julio tienes el turno: \(constants.julio[getDay() + i])")
                }else {
                    constants.following7Days.append("El dia \(j) de agosto tienes el turno: \(constants.agosto[j])")
                    j += 1
                }
            case 8:
                if  diasRest < i {
                    constants.following7Days.append("El dia \(getDay() + i) de agosto tienes el turno: \(constants.agosto[getDay() + i])")
                }else {
                    constants.following7Days.append("El dia \(j) de septiembre tienes el turno: \(constants.septiembre[j])")
                    j += 1
                }
            case 9:
                if  diasRest > i {
                    constants.following7Days.append("El dia \(getDay() + i) de septiembre tienes el turno: \(constants.septiembre[getDay() + i])")
                }else {
                    constants.following7Days.append("El dia \(j) de octubre tienes el turno: \(constants.octubre[j])")
                    j += 1
                }
            case 10:
                if  diasRest > i {
                    constants.following7Days.append("El dia \(getDay() + i) de octubre tienes el turno: \(constants.octubre[getDay() + i])")
                }else {
                    constants.following7Days.append("El dia \(j) de noviembre tienes el turno: \(constants.noviembre[j])")
                    j += 1
                }
            case 11:
                if  diasRest > i {
                    constants.following7Days.append("El dia \(getDay() + i) de noviembre tienes el turno: \(constants.noviembre[getDay() + i])")
                }else {
                    constants.following7Days.append("El dia \(j) de diciembre tienes el turno: \(constants.diciembre[j])")
                    j += 1
                }
            case 12:
                if  diasRest > i {
                    constants.following7Days.append("El dia \(getDay() + i) de diciembre tienes el turno: \(constants.diciembre[getDay() + i])")
                }else {
                    constants.following7Days.append("El dia \(j) tienes el turno: \(constants.enero[j])")
                    j += 1
                }
            default:
                print("")
            }
            
            
            
            i += 1
        }
        
        
    }
    //MARK: - Functions
    
    
    func secondsToHoursMinutesSeconds (minutes : Int) -> (Int, Int, Int) {
      return (minutes / 3600, (minutes % 3600) / 60, (minutes % 3600) % 60)
    }
    
    
    
    func notification(day: Int, hour: Int, minutes: Int){
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge, ]) { granted, error in
            
            if let error = error {
                MainInterface().alarmText.text = "El envio de notificaciones no ha sido permitido"
            }
            
        }
        center.removeAllPendingNotificationRequests()
        //var day = self.getDay()
        
        
        let content = UNMutableNotificationContent()
        
        content.title = "Despierta"
        var minutos = 0
        if minutes <= 9 {
            content.body = "Alarma de las  \(hour):0\(minutes) "
        }
        else{
            content.body = "Alarma de las  \(hour):\(minutes) "
        }
        //content.body = "Alarma de las  \(hour):\(minutes) "
        content.categoryIdentifier = "alarma"
        content.userInfo = ["customData": "fizzbuzz"]
        //content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "banana.wav"))
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "banana.wav"))
        
        
        
        var dateComponents = DateComponents()
        
        dateComponents.day = getDay()
        dateComponents.hour = getHour()
        dateComponents.minute = getMinutes() + 1
/*      DESCOMENTAR ESTAS LINEAS Y COMENTAR LAS 3 ANTERIORES PARA QUE SUENE A LA HORA QUE TOCA Y NO EN EL PRÓXIMO MINUTO
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minutes
 */
        print("alarma de 1 minuto: ", Int(dateComponents.day!), ", ",Int(dateComponents.hour!), ":", Int(dateComponents.minute!) )
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: "Alarm", content: content, trigger: trigger)
        
        center.add(request)
        print("alarma puesta")
        
    }
    
}


