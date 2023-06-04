//
//  ContentView.swift
//  ToDoList
//
//  Created by Kayley Chery on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showNewTask = false
    @FetchRequest(
            entity: ToDo.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \ToDo.id, ascending: false) ])
        
    var toDoItems: FetchedResults<ToDo>
    
    var body: some View {
        VStack {
            HStack {
                Text("The \nUltimate \nTo Do List")
                .font(.system(size: 40))
                .fontWeight(.black)
                .foregroundColor(Color.purple)
                
            Spacer()
             
            Button(action: {
                self.showNewTask = true
            }) {
                Text("+")
                    .font(.system(size: 100))
                    .fontWeight(.black)
                    .foregroundColor(Color.purple)
                }
            
            }
            .padding()
            Spacer()
        }
        
        List {
            
            ForEach (toDoItems) { toDoItem in
                if toDoItem.isImportant == true {
                    Text("‼️" + (toDoItem.title ?? "No title"))
                } else {
                                    Text(toDoItem.title ?? "No title")
                }

                            
               
            }
        }
        .listStyle(.plain)
        
        if showNewTask {
            NewToDoView(title: "", isImportant: false, showNewTask: $showNewTask)
            }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
