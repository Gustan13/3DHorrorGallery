/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The main content view of the app.
*/

import SwiftUI
import PhotosUI

struct Profile: View {
    var body: some View {
        NavigationView {
            ProfileForm()
        }
    }
}

struct ProfileForm: View {
    @StateObject var viewModel = ProfileModel()
    
    var body: some View {
        Section {
            HStack {
                Spacer()
                EditableCircularProfileImage(viewModel: viewModel)
                Spacer()
            }
        }
        .listRowBackground(Color.clear)
    }
}
