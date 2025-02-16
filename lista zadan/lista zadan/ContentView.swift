//
//  ContentView.swift
//  lista zadan
//
//  Created by user271067 on 1/14/25.
//

import SwiftUI

struct ContentView: View {
    struct Task: Identifiable, Hashable {
        let name: String
        let id = UUID()
    }


    private var tasks = [
        Task(name: "run"),
        Task(name: "Shop"),
        Task(name: "dinner"),
        Task(name: "meeting"),
        Task(name: "sleep")
    ]


    @State private var multiSelection = Set<UUID>()


    var body: some View {
        NavigationView {
            List(tasks, selection: $multiSelection) {
                Text($0.name)
            }
            .navigationTitle("Todo List")
        }
    }
}

#Preview {
    ContentView()
}
