//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Kayley Chery on 6/3/23.
//

import Foundation
import UserNotifications

class ToDoItem: Identifiable {
    var id = UUID()
    
    var title = ""
    var isImportant = false
    
    init(title: String, isImportant: Bool = false) {
            self.title = title
            self.isImportant = isImportant
        }
    
    
    func checkForPermission(){
        let notificationCenter = UNUserNotificationCenter.current();
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus{
                
            //if the user has allowed notications, notifications will pop up
            case .authorized:
                self.dispatchNotification()
                
            //if the user has not allowed notifications, notifications won't pop up
            case .denied:
                return
            
                
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]){ didAllow, error in
                    if didAllow{
                        self.dispatchNotification()
                    }
                }
                
            default:
                return
            }
        }
    }

    func dispatchNotification(){
        
    }
}


