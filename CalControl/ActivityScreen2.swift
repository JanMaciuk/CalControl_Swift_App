///
//  ActivityScreen1.swift
//  CalControl
//
//  Created by stud on 28/11/2024.
//
import SwiftUI


struct ActivityScreen2:View{
    @ObservedObject var appState: AppState
    @State var activityTime = Date.now
    
    @State private var selected_intensivity: String = ""

    var intensivity: [String] {
        appState.intensivity.map { $0.0 }
        }
    
    @State private var selected_activity: String = ""
    
    var activities: [String] {
        appState.intensivity.map { $0.0 }
        }
    
    var calculated_kcal: Int = 0
    
    func calculate_kcal(kcal_per_hour: Int, interval: Date, intense: Float) -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: interval)
        let minute = calendar.component(.minute, from: interval)
        
        let totalTimeInHours = Float(hour) + (Float(minute) / 60.0)
        
        let kcalBurned = Int(Float(kcal_per_hour) * intense * totalTimeInHours)
        
        return kcalBurned
    }
    
    var current_activity = 0;
    
    var body: some View {
        
        NavigationView{
                VStack {
                        ZStack {
                            NavigationLink(destination: MainMenuView(appState: appState)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)){
                                ChevronLeftView().padding(.top)
                            }

                            
                            Text("Add new activity")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                        }

                        
                        HStack{
                            Text("Activity")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                            VStack {
                                Picker("intensivity", selection: $selected_intensivity) {
                                    ForEach(intensivity, id: \.self) { intens in
                                        Text(intens)
                                            .foregroundColor(.white)
                                    }
                                }.background(Color.white.opacity(0.2))
                                    .cornerRadius(15)
                            }
                        }
                        
                        HStack{
                            Text("Time")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                            DatePicker("",selection: $activityTime, displayedComponents: .hourAndMinute).colorInvert()
                                .padding(.trailing, 20)
                                .font(.system(size: 24, weight: .bold))
                                .cornerRadius(15)
                                
                        }

                

                    HStack{
                        Text("Intensivity")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                        VStack {
                            Picker("fruits", selection: $selected_activity) {
                                ForEach(activities, id: \.self) { activ in
                                    Text(activ)
                                }
                            }.background(Color.white.opacity(0.2))
                                .cornerRadius(15)
                        }
                    }
                    
                    HStack{
                        VStack{
                            Text("Burned calories:")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                            HStack{
                                Text("🔥")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                                Text("312 kcal")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }

                        }
                        //TODO photo here
                    }
                    NavigationLink(
                        destination: MainMenuView(appState: appState).navigationBarHidden(true).navigationBarBackButtonHidden(true),
                        label: {
                            Text("Add")
                                .padding()
                                .background(.white)
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                                .frame(width: UIScreen.main.bounds.width * 0.8) // does not work correctly
                                .font(.system(size: 20, weight: .semibold))
                        }
                    )
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
                                .frame(width: UIScreen.main.bounds.width * 0.8) // does not work correctly
                                .font(.system(size: 20, weight: .semibold))
                        }
                    )
                    
                        
                }.background(Color.black)
        }.navigationBarHidden(true)
        }
    
}

struct ActivityScreen2_Preview: PreviewProvider{
    static var previews: some View {
        ActivityScreen2(appState: AppState())
    }
    
}






