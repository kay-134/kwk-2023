//
//  NewToDoView.swift
//  ToDoList
//
//  Created by Kayley Chery on 6/3/23.
//

import SwiftUI

struct NewToDoView: View {
    @Environment(\.managedObjectContext) var context
    @State var title: String
    @State var isImportant: Bool
    @Binding var showNewTask : Bool
    let peach = Color("Color")
    var body: some View {
       
            VStack {
              
                    
                Text("✨Add a new task✨")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.purple)
                
                
                TextField("Enter the task description", text: $title)
                    .padding()
                    .foregroundColor(Color.purple)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(15)
                    .padding()
                
                Toggle(isOn: $isImportant) {
                    Text("Is it important?")
                        .foregroundColor(Color.purple)
                }
                .tint(.purple)
                .padding()
                
                Button(action: {
                    self.addTask(title: self.title, isImportant: self.isImportant)
                    self.showNewTask = false
                }) {
                    Text("Add")
                        .foregroundColor(Color.purple)
                        .buttonStyle(.borderedProminent)
                }
            }
            
            
        }
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
    }





struct NewToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NewToDoView(title: "", isImportant: false, showNewTask: .constant(true))
    }
   
}
