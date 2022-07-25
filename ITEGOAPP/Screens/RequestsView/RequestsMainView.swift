import SwiftUI

struct RequestsMainView: View {
    @State private var didLoad = false
    @ObservedObject var api = RequestsAPI()
    @State var selectedIndex = 2
    
    init(){
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor.rgb(red: 244, green: 247, blue: 254)
        UITableView.appearance().backgroundColor = UIColor.rgb(red: 244, green: 247, blue: 254)
    }
    var body: some View {
        
        NavigationView {
            
            VStack{
                HStack(alignment: .center,spacing: 0){
                    FilterButton(title: "New", tag: 2,selectedIndex: $selectedIndex)
                    FilterButton(title: "Pending", tag: 3,selectedIndex: $selectedIndex)
                    FilterButton(title: "Completed", tag: 4,selectedIndex: $selectedIndex)
                }
                .frame(height: 50)
                .background(.white)
                .cornerRadius(10)
                .padding(10)
                
                ScrollView(showsIndicators: false) {
                    if(api.isLoading == true){
                        ProgressView()
                            .scaleEffect(1.5)
                            .padding()
                        
                    }
                    
                    else{
                        ForEach(api.requests, id: \.id){ request in
                            RequestCard(request: request)
                        }
                    }
                    
                }
                .background(api.isLoading ? Color.clear : Color(uiColor: UIColor.rgb(red: 244, green: 247, blue: 254)))
                .navigationTitle("Requests")
                .onChange(of: selectedIndex) { filterType in
                    api.getRequests(type: filterType)
                }
                
                
            }
            
        }
        
        .navigationViewStyle(.stack)
        .onAppear {
            if didLoad == false {
                api.getRequests(type: 2)
                didLoad = true
            }
        }
        
    }
}

struct RequestsMainView_Previews: PreviewProvider {
    static var previews: some View {
        RequestsMainView()
            .background(.red)
    }
}
