//
//  DataView.swift
//  Exam
//
//  Created by Waseem on 12/08/20.
//  Copyright © 2020 Waseem. All rights reserved.
//

import SwiftUI
import FirebaseStorage

struct DataView: View {
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var image: UIImage?
    @State private var username: String = ""
    @State private var screenMode: ScreenMode = .imagePicker

    func saveToFirebase() {
        if self.activateSaveButton() {
            let randomID = self.username
            let uploadRef = Storage.storage().reference(withPath: "Exam/\(randomID).jpg")
            guard let imageData = self.image?.jpegData(compressionQuality: 0.75)else { return }
            let uploadMetaData = StorageMetadata.init()
            uploadMetaData.contentType = "image/jpeg"
            
            uploadRef.putData(imageData, metadata: uploadMetaData) { (response, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                print("Image saved sucessfully!")
                print(String(describing: response))
            }
        }
    }
    
    func activateSaveButton() -> Bool {
        if self.username != "" && self.image != nil {
            return true
        } else {
            return false
        }
    }
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    //Textfield: username
                    Section(header: Text("Username").font(.headline)) {
                        TextField("Enter your name", text: $username).keyboardType(.alphabet).padding(.horizontal)
                    }
                    
                    //ImagePicker
                    Section(header: Text("Profile Picture").font(.headline)) {
                            HStack {
                                
                                if image != nil {
                                    Image(uiImage: image ?? UIImage(named: "placeholder")!)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Spacer()
                                }
                                Button("Choose Picture") {
                                    self.showSheet = true
                                }.padding()
                                    .actionSheet(isPresented: $showSheet) {
                                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                                            .default(Text("Photo Library")) {
                                                self.screenMode = .imagePicker
                                                self.sourceType = .photoLibrary
                                                self.showImagePicker = true
                                            },
                                            .default(Text("Camera")) {
                                                self.screenMode = .imagePicker
                                                self.sourceType = .camera
                                                self.showImagePicker = true
                                            },
                                            .cancel()
                                        ])
                                }
                                Spacer()
                            }
                    }
                    
                    //Graphics
                    Section(header: Text("Graphics")) {
                        Button(action: {
                            self.screenMode = .graphics
                            self.showImagePicker = true
                        }) {
                            Text("Show Graphics").padding()
                        }
                    }
                }
                Button(action: {
                    self.saveToFirebase()
                }, label: {
                    Text("Save")
                })//.disabled(self.activateSaveButton())

            }
            .navigationBarTitle("Exam")
            
        }.sheet(isPresented: $showImagePicker) {
            if self.screenMode == .imagePicker {
                ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
            } else {
                ServiceDetailsView(data: ServiceVM())
            }
        }
    }
}

enum ScreenMode {
    case imagePicker
    case graphics
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
