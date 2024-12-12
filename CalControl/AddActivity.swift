import SwiftUI

struct AddActivity: View {
    @ObservedObject var appState: AppState
    @State private var activity_name = ""
    @State private var kcal_per_hour = ""

    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    NavigationLink(destination: MainMenuView(appState: appState).navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                        ChevronLeft()
                    }
                    Spacer()
                    Text("Add custom activity")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
                .padding(.horizontal)
                
                
                
                Divider()
                
                VStack() {
                    Text("Activity name")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack {
                        TextField("Activity name", text: $activity_name)
                            .padding(.leading, 10)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
                
                VStack() {
                    Text("Kcal per hour")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack {
                        TextField("Kcal per hour", text: $kcal_per_hour)
                            .keyboardType(.decimalPad)
                            .padding(.leading, 10)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
                
                

                
                Spacer()

                NavigationLink(
                    destination: ActicityScreen1(appState: appState).navigationBarHidden(true).navigationBarBackButtonHidden(true),
                    label: {
                        Text("Add new activity")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .font(.system(size: 20, weight: .semibold))
                    }
                )
                
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
    }
}

struct AddActivity_Preview: PreviewProvider {
    static var previews: some View {
        AddActivity(appState: AppState())
    }
}
