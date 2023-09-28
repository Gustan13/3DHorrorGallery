//
//  InGameButton.swift
//  Gallery
//
//  Created by Gustavo Binder on 28/09/23.
//

import SwiftUI

struct InGameButton: View {
    
    var funcToExec : () -> Void
    var image: String
    
    init(funcToExec: @escaping () -> Void, image: String) {
        self.funcToExec = funcToExec
        self.image = image
    }
    
    var body: some View {
        Button {
            funcToExec()
        } label: {
            Image(systemName: image)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background {
                    Color.black
                }
                .cornerRadius(8)
        }
    }
}

//struct InGameButton_Previews: PreviewProvider {
//    static var previews: some View {
//        InGameButton()
//    }
//}
