//
//  NewToDoView.swift
//  ToDoList
//
//  Created by Kayley Chery on 6/3/23.
//

import SwiftUI
import UserNotifications
struct NewToDoView: View {
    @Environment(\.managedObjectContext) var  context
    @State var title: String
    @State var isImportant: Bool
   @State private var presentAlert = false
    @Binding var showNewTask : Bool
        @State public var namesToEncourage = [String]()
        @State var nameToAddToList = ""

    let peach = Color("Color")
    var body: some View {
        
        VStack {
            
            Text("✨Add a new task✨")
                .font(Font.custom("Baskerville-Bold", size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
               
                
            
            
            TextField("Enter the task description", text: $title)
                .padding()
                .foregroundColor(Color.black)
                .font(Font.custom("Baskerville-Bold", size: 20))
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)
                .padding()
            
        
            
            Toggle(isOn: $isImportant) {
                Text("Is it important?")
                    .foregroundColor(Color.black)
                    .font(Font.custom("Baskerville-Bold", size: 20))
            }
            .tint(.purple)
            .padding()
            
            Button("Schedule Notification"){
                //to add the name to the list
                self.addTask(title: self.title, isImportant: self.isImportant)
                self.showNewTask = false
                nameToAddToList = title
                namesToEncourage.append(title)
                
                //to add the name to the notification
                namesToEncourage.append(title)
                nameToAddToList = namesToEncourage.randomElement()!
                let content = UNMutableNotificationContent()
                content.title = "One Another"
                content.subtitle = "Try to encourage \(nameToAddToList) today"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
                
            }.alert("\(title) ", isPresented: $presentAlert, actions: {})
            
            /*Button(action: {
                self.addTask(title: self.title, isImportant: self.isImportant)
                self.showNewTask = false
                nameToAddToList = title
                namesToEncourage.append(title)
                
                
            }) {
                Text("Add")
                    .foregroundColor(Color.black)
                    .buttonStyle(.borderedProminent)
                    .font(Font.custom("Baskerville-Bold", size: 20))
            }
            
                */
            
        }
               // .alert("\(title) ", isPresented: $presentAlert, actions: {})
        
        
        
        
    }
    
    //function for enabling notification
   private func addTask(title: String, isImportant: Bool = false) {
        
        let task = ToDo(context: context)
        task.id = UUID()
        task.title = title
        task.isImportant = isImportant
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    
    
    
    
    
    
    struct NewToDoView_Previews: PreviewProvider {
        static var previews: some View {
            NewToDoView(title: "", isImportant: false, showNewTask: .constant(true))
        }
        
    }
    
    
    
}
