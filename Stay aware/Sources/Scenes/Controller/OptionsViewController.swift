//
//  OptionsViewController.swift
//  Stay aware
//
//  Created by Олег Стригунов on 28.05.2023.
//

import UIKit
import UserNotifications

class OptionsViewController: UIViewController {
    
    var enabledNotification = UserDefaults.standard.bool(forKey: "enabledNotification") {
        didSet {
            UserDefaults.standard.set(enabledNotification, forKey: "enabledNotification")
            
            guard let optionsView = optionsView else { return }

            if (enabledNotification) {
               
                    optionsView.enableNotificationButton.isHidden = true
                    optionsView.stackEnabledNotification.isHidden = false
    
                
            } else {
                optionsView.enableNotificationButton.isHidden = false
                optionsView.stackEnabledNotification.isHidden = true
            }
        }
    }
    
    let notificationCenter = UNUserNotificationCenter.current()

    var notificationTimes: [Int] = [] {
        didSet {
            cleanNotification()
            sendNotofications()
        }
    }
    
    let calendar = Calendar.current
    
    var selectedNotification = UserDefaults.standard.string(forKey: "selectedNotification") ?? K.OptionsView.offNotif {
        didSet {
            UserDefaults.standard.set(selectedNotification, forKey: "selectedNotification")
        }
    }
    
    
    private var optionsView: OptionsView? {
        guard isViewLoaded else { return nil }
        return view as? OptionsView
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = OptionsView()
        
        if (enabledNotification) {
            self.optionsView?.enableNotificationButton.isHidden = true
            self.optionsView?.stackEnabledNotification.isHidden = false
        } else {
            self.optionsView?.enableNotificationButton.isHidden = false
            self.optionsView?.stackEnabledNotification.isHidden = true
        }
        
        setupActions()
        switchButton()
    }
    
    
    
    //MARK: - Actions
    private func setupActions() {
        guard let optionsView = optionsView else { return }
        
        optionsView.enableNotificationButton.addTarget(self, action: #selector(enableNotif), for: .touchUpInside)
        
        optionsView.setNotificationPauseButton.addTarget(self, action: #selector(switchButtons), for: .touchUpInside)
        optionsView.setNotificationOneHourButton.addTarget(self, action: #selector(switchButtons), for: .touchUpInside)
        optionsView.setNotificationTwoHourButton.addTarget(self, action: #selector(switchButtons), for: .touchUpInside)
        optionsView.setNotificationTimePhaseButton.addTarget(self, action: #selector(switchButtons), for: .touchUpInside)
    }
    
    private func cleanNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        UIApplication.shared.unregisterForRemoteNotifications()
    }
    
    
    private func switchButton() {
        guard let optionsView = optionsView else { return }
        
        let buttons: [UIButton] = [optionsView.setNotificationPauseButton,
                                         optionsView.setNotificationOneHourButton,
                                         optionsView.setNotificationTwoHourButton,
                                         optionsView.setNotificationTimePhaseButton
        ]
        
        
        for btn in buttons {
            btn.setTitleColor(.white, for: .normal)
            btn.tintColor = .white
            btn.backgroundColor = .none
            
            if btn.accessibilityIdentifier == selectedNotification {
                btn.setTitleColor(.black, for: .normal)
                btn.tintColor = .black
                btn.backgroundColor = .white
            }
        }
        
    }
    
    
    @objc func switchButtons(sender: UIButton) {
        if let button = sender.accessibilityIdentifier {
            selectedNotification = button
            
            switch button {
                case K.OptionsView.offNotif:
                    cleanNotification()
                case K.OptionsView.oneHour:
                    notificationTimes = [09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22]
                case K.OptionsView.twoHour:
                    notificationTimes = [09, 11, 13, 15, 17, 19, 21]
                case K.OptionsView.threePhase:
                    notificationTimes = [47, 49, 51]
                default:
                    cleanNotification()
            }
            
            switchButton()
        }
        
    }
    

    @objc func enableNotif() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                print(settings)
                guard settings.authorizationStatus == .authorized else { return }
                
                DispatchQueue.main.async {
                    self.enabledNotification = true
                }
            }
        }
       
    }

    
    private func sendNotofications() {
        
        let content = UNMutableNotificationContent()
        content.title = "Добавить истории.."
        content.body = "Не забывай, что все крупные достижения состоят из маленьких ежедневных шагов"
        content.sound = .defaultRingtone
        
        for hour in notificationTimes {
            var dateComponents = DateComponents()
            dateComponents.hour = hour
            dateComponents.minute = 0

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "\(hour)HourNotification", content: content, trigger: trigger)

            // Добавление уведомления в центр уведомлений
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
                } else {
                    print("Уведомление добавлено успешно")
                }
            }
        }
        
    }
}
