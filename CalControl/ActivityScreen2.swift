import SwiftUI

struct ActivityScreen2: View {
    @ObservedObject var appState: AppState
    @State var activityTime: Date = Calendar.current.startOfDay(for: Date())
    @State private var selected_intensivity: String = ""
    @State private var selected_activity: String = ""
    @State private var calculated_kcal: Int = 0
    
    var intensivity: [String] {
        appState.intensivity.map { $0.0 }
    }
    
    var activities: [String] {
        appState.activity.map { $0.0 }
    }
    
    func calculate_kcal(kcal_per_hour: Int, interval: Date, intense: Float) -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: interval)
        let minute = calendar.component(.minute, from: interval)
        
        let totalTimeInHours = Float(hour) + (Float(minute) / 60.0)
        let kcalBurned = Int(Float(kcal_per_hour) * intense * totalTimeInHours)
        
        return kcalBurned
    }

    func updateCalories() {
        guard let activityIndex = (appState.activity.map { $0.0 }).firstIndex(of: selected_activity),
              let intensityIndex = (appState.intensivity.map { $0.0 }).firstIndex(of: selected_intensivity) else {
            return
        }
        
        let kcal_per_hour = appState.activity[activityIndex].kcal_per_hour
        let intensityMultiplier: Float = Float(appState.intensivity[intensityIndex].1)
        calculated_kcal = calculate_kcal(kcal_per_hour: kcal_per_hour, interval: activityTime, intense: intensityMultiplier)
    }
    
    func updateAppState(){
        appState.today_activity.append((activity: selected_activity, interval: activityTime, kcal: calculated_kcal))
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    NavigationLink(destination: MainMenuView(appState: appState)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)) {
                        ChevronLeftView().padding(.top)
                    }
                    
                    Text("Add new activity")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                }
                
                HStack {
                    Text("Activity")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    VStack {
                        Picker("activity", selection: $selected_activity) {
                            ForEach(activities, id: \.self) { intens in
                                Text(intens)
                                    .foregroundColor(.white)
                            }
                        }
                        .onChange(of: selected_activity) { _ in
                            updateCalories()
                        }
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(15)
                    }
                }
                
                HStack {
                    Text("Time")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    DatePicker("", selection: $activityTime, displayedComponents: .hourAndMinute)
                        .onChange(of: activityTime) { _ in
                            updateCalories()
                        }
                        .colorInvert()
                        .padding(.trailing, 20)
                        .font(.system(size: 24, weight: .bold))
                        .cornerRadius(15)
                }
                
                HStack {
                    Text("Intensivity")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    VStack {
                        Picker("intensivity", selection: $selected_intensivity) {
                            ForEach(intensivity, id: \.self) { activ in
                                Text(activ)
                                    .foregroundColor(.white)
                            }
                        }
                        .onChange(of: selected_intensivity) { _ in
                            updateCalories()
                        }
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(15)
                    }
                }
                
                HStack {
                    VStack {
                        Text("Burned calories:")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                        HStack {
                            Text("🔥")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                            Text("\(calculated_kcal) kcal")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }

                NavigationLink(
                    destination: MainMenuView(appState: appState).navigationBarHidden(true).navigationBarBackButtonHidden(true),
                    label: {
                        Text("Add")
                            .padding()
                            .background(.white)
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .font(.system(size: 20, weight: .semibold))
                    }
                    
                ).simultaneousGesture(TapGesture().onEnded {
                    updateAppState()
                })
                
                Spacer()
                Divider()
                    Text("Activity missing ?")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                Spacer()
                
                NavigationLink(
                    destination: AddActivity(appState: appState).navigationBarHidden(true).navigationBarBackButtonHidden(true),
                    label: {
                        Text("Add custom activity ")
                            .padding()
                            .background(.white)
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .font(.system(size: 20, weight: .semibold))
                    }
                )
            }
            .background(Color.black)
        }
        .navigationBarHidden(true)
    }
}

struct ActivityScreen2_Preview: PreviewProvider {
    static var previews: some View {
        ActivityScreen2(appState: AppState())
    }
}
