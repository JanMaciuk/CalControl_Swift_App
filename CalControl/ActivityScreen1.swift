//
import SwiftUI

struct ActicityScreen1: View {
    @ObservedObject var appState: AppState
    
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                ZStack {
                    NavigationLink(
                        destination: MainMenuView(appState: appState).navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true),
                        label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        })
                    
                    Text("Manage Activity")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                }
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
                            ForEach(0..<appState.today_activity.count, id: \.self) { i in
                                HStack {
                                    Text(appState.today_activity[i].activity)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    Text("\(appState.today_activity[i].kcal) kcal")
                                        .frame(maxWidth: .infinity, alignment: .center)

                                    Text(formattedTime(appState.today_activity[i].interval))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(8)
                                .id(i)
                            }

                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.5)
                }
                

                NavigationLink(
                    destination: ActivityScreen2(appState: appState).navigationBarHidden(true).navigationBarBackButtonHidden(true),
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
            .navigationBarHidden(true)
        }
    }
}

struct ActicityScreen1_Preview: PreviewProvider {
    static var previews: some View {
        ActicityScreen1(appState: AppState())
    }
}
