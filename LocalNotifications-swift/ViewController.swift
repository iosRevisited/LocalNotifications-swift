//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Sai Sandeep on 29/08/17.
//  Copyright © 2017 iosRevisited. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingButton()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if (granted) {
                print("granted swift")
            }else {
                print(error?.localizedDescription as Any)
            }
        }
        
    }
    
    func addingButton() {
        let sendButton = UIButton()
        view.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sendButton.setTitle("Send Notification", for: .normal)
        sendButton.setTitleColor(UIColor.white, for: .normal)
        sendButton.backgroundColor = UIColor.blue
        
        sendButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        print("button tapped")
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Good morning!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Wake up! It's morning time!",
                                                                arguments: nil)
        
        content.sound = UNNotificationSound.default()
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:TimeInterval(10)  , repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "MorningAlarm", content: content, trigger: trigger)
        
        // Schedule the request.
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
    
    
    // UNUserNotificationCenterDelegates
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification.request.content.title)
        
        // Play a sound.
        completionHandler(UNNotificationPresentationOptions.sound)
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.title)
        
    }
    
    
}







