//
//  ContentView.swift
//  ToDoList
//
//  Created by Kayley Chery on 6/3/23.
//

import SwiftUI
import UserNotifications
struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @State private var showNewTask = false
    //An empty array that contains the names of people to encourage
    //@State var names: [String] = []
    @State var namesToEncourage = ["Anna", "Bob", "Chrissy"]
   //@State var names = functionality.namesToEncourage
    @State var name = ""
    @FetchRequest(
            entity: ToDo.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \ToDo.id, ascending: false) ])
    
    var toDoItems: FetchedResults<ToDo>
    
    var body: some View {
        VStack {
            HStack {
                Text("One \nAnother \n")
                .font(Font.custom("Baskerville-Bold", size: 40))
                .fontWeight(.black)
                .foregroundColor(Color.black)
                
            Spacer()
             
            Button(action: {
                self.showNewTask = true
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge , .sound]){ success, error in
                    if success{
                        print("All set")
                    }
                    else if let error = error {
                        print(error.localizedDescription)
                    }
                }
               
            }) {
                Text("+")
                    .font(Font.custom("Baskerville-Bold", size: 100))
                    .fontWeight(.black)
                    .foregroundColor(Color.black)
                
                
                
                }
            
            }
            .padding()
            Spacer()
        }
        
        /*Button("Request Permission"){
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge , .sound]){ success, error in
                if success{
                    print("All set")
                }
                else if let error = error {
                    print(error.localizedDescription)
                }
            }
       } */
        
        //moved 
       /* Button("Schedule Notification"){
          
            name = namesToEncourage.randomElement()!
            let content = UNMutableNotificationContent()
            content.title = "One Another"
            content.subtitle = name
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }
        */
        List {
            ForEach (toDoItems) { toDoItem in
                if toDoItem.isImportant == true {
                    Text("‼️" + (toDoItem.title ?? "No title"))
                    
                } else {
                    Text(toDoItem.title ?? "No title")
                }
               
            }
            .onDelete(perform: deleteTask)
            .foregroundColor(Color.black)
            .font(Font.custom("Baskerville-Bold", size: 20))
            .cornerRadius(15)
        
        }
        .listStyle(.plain)
        
        if showNewTask {
            NewToDoView(title: "", isImportant: false, showNewTask: $showNewTask)
            }

    }
    private func deleteTask(offsets: IndexSet) {
            withAnimation {
                offsets.map { toDoItems[$0] }.forEach(context.delete)

                do {
                    try context.save()
                }
                
                catch {
                    print(error)
                }
            }
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
   
}


