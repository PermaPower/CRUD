//
//  ImagePicker.swift
//  CRUD
//
//  Created by David on 19/6/21.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @State var images : [UIImage] = []
    @State var picker = false
    
    var body: some View {
        VStack{
            
            if !images.isEmpty {
                
                //ScrollView(.horizontal, showsIndicators: false, content: {
                VStack(spacing:0) {
                        ForEach(images, id: \.self) { img in
                                              
                        Image(uiImage: img)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Triangle())
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 200, height: 200)
                            
                        }
                    }
              //  })
                
                
                
            }
            else {
                Button(action: {
                    picker.toggle()
                }, label: {
                    Text("Pick Images")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 35)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
                
                
            }
        }.sheet(isPresented: $picker) {
        
            ImagePicker(images: $images, picker: $picker)
            
        }
    }
    
    


}

struct ImagePicker : UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent1: self)
    }
    
    @Binding var images : [UIImage]
    @Binding var picker : Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
               
        var parent: ImagePicker
        
        init (parent1: ImagePicker) {
            parent = parent1
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            // closing picker
            parent.picker.toggle()
            
            for img in results{
                
                if img.itemProvider.canLoadObject(ofClass: UIImage.self){
                    
                    // retreving the selected Image
                    
                    img.itemProvider.loadObject(ofClass: UIImage.self) {(image, err) in
                        
                        guard let image1 = image else {
                            print(err ?? "Error with image")
                            return
                        }
                        
                        // appending image...
                        
                        self.parent.images.append(image1 as! UIImage)
                        
                    }
                    
                }
                else {
                    // Cannot load image
                    
                    print("Cannot be loaded")
                }
                
            }
        }
    }
    
}


struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}


