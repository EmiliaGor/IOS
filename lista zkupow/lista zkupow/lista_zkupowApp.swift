//
//  lista_zkupowApp.swift
//  lista zkupow
//
//  Created by user271067 on 2/18/25.
//

import SwiftUI

@main
struct lista_zkupowApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
