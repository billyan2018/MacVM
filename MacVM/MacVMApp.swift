//
//  MacVMApp.swift
//  MacVM
//
//  Created by Khaos Tian on 6/28/21.
//

import SwiftUI
import Combine


@main
struct MacVMApp: App {
    
    private let exportCommand = PassthroughSubject<Void, Never>()
    
    var body: some Scene {
        DocumentGroup {
            VMDocument()
        } editor: { configuration in
            VMView(
                document: configuration.document,
                fileURL: configuration.fileURL
            ).onReceive(exportCommand) { _ in
                configuration.document.toggelStartStop(configuration.fileURL!)
            }
        }.commands {
            CommandMenu("VM") {
                Button("Start/stop") {
                    exportCommand.send()
                }
                .keyboardShortcut("S", modifiers: .command)
            }
        }
    }
}
