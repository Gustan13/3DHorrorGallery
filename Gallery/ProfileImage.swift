import SwiftUI
import PhotosUI

struct ProfileImage: View {
    let imageState: ProfileModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            Image(uiImage: image)
                .resizable()
                .clipShape(Circle())
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "camera.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
        }
    }
}

struct CircularProfileImage: View {
    let imageState: ProfileModel.ImageState
    
    var body: some View {
        ProfileImage(imageState: imageState)
            .scaledToFill()
            .frame(width: 50, height: 50)
            .background {
                Circle().fill(
                    Color.black
                )
            }
    }
}

struct EditableCircularProfileImage: View {
    @ObservedObject var viewModel: ProfileModel
    
    var body: some View {
//        CircularProfileImage(imageState: viewModel.imageState)
//            .overlay(alignment: .bottomTrailing) {
//                PhotosPicker(selection: $viewModel.imageSelection,
//                             matching: .images,
//                             photoLibrary: .shared()) {
//                    Image(systemName: "pencil.circle.fill")
//                        .symbolRenderingMode(.multicolor)
//                        .font(.system(size: 30))
//                        .foregroundColor(.accentColor)
//                }
//                .buttonStyle(.borderless)
//            }
        
        PhotosPicker(selection: $viewModel.imageSelection,
                     matching: .images,
                     photoLibrary: .shared()) {
            CircularProfileImage(imageState: viewModel.imageState)
        }
    }
}
