//
//  ContentView.swift
//  TaskList
//
//  Created by Jack Wong on 4/26/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var taskStore: TaskStore
    
    @State var modalIsPresented = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(taskStore.prioritizedTasks) { index in
                    SectionView(prioritizedTasks: self.$taskStore.prioritizedTasks[index])
                }
            }
            .listStyle(GroupedListStyle() )
            .navigationBarTitle("Title")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                Button(action: {
                    self.modalIsPresented = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $modalIsPresented) {
            NewTaskView(taskStore: self.taskStore)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(taskStore: TaskStore() )
    }
}

//Method 1
//        List(taskStore.tasks.indices) { index in
//            Text(self.taskStore.tasks[index].name)
//        }

//Method 2, use keypath
//        List(taskStore.tasks, id: \.id) { task in
//            Text(task.name)
//        }

//Method 3: Use Identifiable protocol on task


//option+cmd+ [ or ]
//cmd + direction
//option + direction

// Indent:   cmd + [ or ]

