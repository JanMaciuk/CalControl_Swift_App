import SwiftUI

struct AddActivity: View {
    @ObservedObject var appState: AppState
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
                
                Text("Burned kcal: \(appState.kcal_burned)")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .semibold))
                    .padding(.top)
                

                
                Spacer()
                Text("My activity today:")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .semibold))
                    .padding(.top)
                
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(0..<100, id: \.self) { i in
                                Text("Example \(i)")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(i % 2 == 0 ? Color.white.opacity(0.9) : Color.clear)
                                    .cornerRadius(8)
                                    .id(i)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.5)
                }
                

                NavigationLink(
                    destination: ActivityScreen2(appState: appState),
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
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

struct AddActivity_Preview: PreviewProvider {
    static var previews: some View {
        AddActivity(appState: AppState())
    }
}
