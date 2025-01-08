import SwiftUI

struct MainMenuView: View {
    @ObservedObject var appState: AppState
    @State private var showProfile = false
    @State private var showSettings = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Button(action: {
                            showProfile.toggle()
                        }) {
                            Image(systemName: "person.circle")
                                .font(.system(size: 46, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                        }
                        .sheet(isPresented: $showProfile) {
                            UserProfileView(appState: appState)
                        }

                        Spacer()

                        Button(action: {
                            showSettings.toggle()
                        }) {
                            Image(systemName: "gearshape")
                                .font(.system(size: 46, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                        }
                        .sheet(isPresented: $showSettings) {
                            UserSettingsView(appState: appState)
                        }
                    }

                    Spacer()

                    VStack(alignment: .leading, spacing: 35) {
                        Text("Hello " + appState.username).foregroundColor(.white)
                        NavigationLink(destination: DreamsView(appState: appState).navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                            MenuOptionView(title: "Manage dreams")
                        }
                        
                        NavigationLink(destination: ActicityScreen1(appState: appState).navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                            MenuOptionView(title: "Manage activity")
                        }
           
                        
                        NavigationLink(destination: TodayEatenMealsView(appState: appState).navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                            MenuOptionView(title: "Today meals")
                        }

                        NavigationLink(destination: ManageMealsView(appState: appState).navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                            MenuOptionView(title: "Manage meals")
                        }
                        Button(action: {
                            appState.saveToUserDefaults()
                            exit(0)
                        }) {
                            Text("Quit the app")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(30)
                                .padding(.top, 30)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    .font(.system(size: 30, weight: .bold))

                    Spacer()
                    Spacer()

                    Divider()
                        .background(Color.white)
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Kcal consumed:       \(appState.kcal_consumed)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        HStack {
                            Text("Kcal burned:             \(appState.kcal_burned)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        HStack {
                            Text("Total balance:            \(appState.kcal_consumed-appState.kcal_burned)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.leading, 20)
                    .padding(.trailing, 20)

                    Spacer()

                    Text(appState.dailyGoalStatus())
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            appState.dailyResetIfNeeded()
        }
    }
}

struct MenuOptionView: View {
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 30))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
        }
        .padding(.horizontal)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(appState: AppState())
    }
}
