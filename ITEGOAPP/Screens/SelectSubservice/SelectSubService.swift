//
//  SelectService.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 29/05/2022.
//

import SwiftUI

struct SelectSubService: View {
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    let selectedService:ServiceModel!
    
    @State var services = [ServiceModel]()
    
    @State private var didLoad = false
    
    
    var body: some View {
        
        GeometryReader { geo in
//            NavigationView {
                //            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: items, spacing: 10) {
                        ForEach(selectedService.sub_services, id: \.id) { service in
                            NavigationLink {
                                RequestForm(serviceId: selectedService.id, subServiceId: service.id)
                            } label: {
                                VStack(alignment: .center, spacing: 5){
                                    Image.init(systemName: "house")
                                        .foregroundColor(.black)
                                        .font(.title)
                                    
                                    Text(service.name)
                                        .multilineTextAlignment(.center)
                                        .font(.body)
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                
                                .frame(width: geo.size.width / 2.7, height: geo.size.width / 2.7, alignment: .center)
                                .padding()
                                .background(.white)
                                .cornerRadius(20)
                                .shadow(color: .gray.opacity(0.2), radius: 2, x: 1, y: 3)
                            }
                            //navigation link
                            
                        }
                    }
                    .padding(.horizontal,1)//lazy grid
                    //                        }
                }//GeometryReader
                .background(Color(uiColor: UIColor.rgb(red: 244, green: 247, blue: 254)))
            .navigationViewStyle(.stack)
        }.onAppear { }
    }
}

struct SelectSubService_Previews: PreviewProvider {
    static var previews: some View {
        SelectSubService(selectedService: ServiceModel(id: 1, name: "test", description: "test", image: nil, sub_services: [SubServiceModel(id: 1, name: "test", description: "test", image: nil)]))
    }
}
