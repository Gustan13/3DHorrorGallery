//
//  Main.swift
//  Gallery
//
//  Created by Gustavo Binder on 29/09/23.
//

import SwiftUI

struct Main: View {
    
    @State var tab : Int = 0
    
    var body: some View {
        if tab == 0 {
            Button {
                withAnimation {
                    tab = 1
                }
            } label: {
                Text("Go to Game")
            }
            Button {
                withAnimation {
                    tab = 2
                }
            } label: {
                Text("Edit Map")
            }

        } else if tab == 1 {
            ContentView(tab: $tab)
                .transition(.move(edge: .top))
        } else if tab == 2 {
            Button {
                withAnimation {
                    tab = 0
                }
            } label: {
                Text("Go Back")
            }
            .transition(.scale)
        }
    }
}
