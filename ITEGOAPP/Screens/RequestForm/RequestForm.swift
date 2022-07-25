//
//  RequestForm.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 30/05/2022.
//

import SwiftUI

struct RequestForm: View {
    @State var title = ""
    @State var mobile = ""
    @State var description = ""
    @State var canSubmit = false
    @State private var fileImporterVisible = false
    @State private var urls:[String] = []
    @State private var fileNames:[String] = []
    
    var serviceId:Int64
    var subServiceId:Int64
    
    var requesFormService = RequestFormService()
    
    init(serviceId:Int64, subServiceId:Int64){
        UITableView.appearance().backgroundColor =  UIColor.rgb(red: 244, green: 247, blue: 254)
        
        self.serviceId = serviceId
        self.subServiceId = subServiceId
    }
    
    var body: some View {
        
        
        Form{
            Section {
                VStack{
                    TextField("Title", text: $title)
                        .padding(.horizontal,5)
                        .padding(.vertical,5)
                    Divider()
                    TextField("Mobile Number", text: $mobile)
                        .keyboardType(.numberPad)
                        .padding(.horizontal,5)
                        .padding(.vertical,5)
                    Divider()
                    ZStack(alignment: .topLeading) {
                        if description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Text("Description").foregroundColor(Color(UIColor.placeholderText)).padding(.top, 8)
                        }
                        VStack{
                            TextEditor(text: $description).padding(.leading, -3)
                                .frame(height:120)
                            
                        }
                        
                        
                    }
                    
                }
                
                Button{
                    fileImporterVisible.toggle()
                } label: {
                    
                    HStack(alignment:.center) {
                        Image(systemName: "paperclip")
                            .font(Font.system(size: 15, weight: .bold))
                            .foregroundColor(.black.opacity(0.7))
                        Text("Upload")
                            .font(Font.system(size: 15, weight: .bold))
                            .foregroundColor(.black.opacity(0.7))
                        
                    }
                    .frame(maxWidth:.infinity)
                    .padding()
                    
                }
                //                }
                .listRowInsets(EdgeInsets())
                .background(.gray.opacity(0.4))
                
                
                HStack {
                    Button{
                        requesFormService.createRequest(requestData: [
                            "service_id":serviceId,
                            "sub_service_id":subServiceId,
                            "subject":title,
                            "description":description,
                            "mobile":mobile
                        ])
                    }label: {
                        
                        HStack {
                            Text("Submit")
                                .foregroundColor(.white)
                            
                                .font(Font.system(size: 15, weight: .bold))
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity,maxHeight: .infinity)
                    .padding(10)
                    .background(.green.opacity(0.7))
                }    .listRowInsets(EdgeInsets())
                
            }
            
            if !self.urls.isEmpty {
                Section{
                        ForEach(0..<self.urls.count,id: \.self){ i in
                            HStack{
                                Text(self.fileNames[i])
                                Spacer()
                                Button{
                                    withAnimation(Animation.easeInOut(duration: 3)) {
                                        self.fileNames.remove(at: i)
                                        self.urls.remove(at: i)
                                    }
                                    
                                    
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                
                            }
                        }.transition(.slide)
                    
                }
            }
            
        }.fileImporter(isPresented: $fileImporterVisible, allowedContentTypes: [.image,.pdf,.fileURL], onCompletion: { result in
            do{
                let fileUrl = try result.get()
                
                if !self.fileNames.contains(where: {$0 == fileUrl.lastPathComponent.lowercased()}){
                    
                    withAnimation {
                        self.fileNames.append(fileUrl.lastPathComponent.lowercased())
                        self.urls.append(fileUrl.absoluteString)
                    }
                    
                }
                
            }catch{
                print(error.localizedDescription)
            }
            
        })
       
        
        
        
    }
}

struct RequestForm_Previews: PreviewProvider {
    static var previews: some View {
        RequestForm(serviceId: 0, subServiceId: 0)
    }
}
