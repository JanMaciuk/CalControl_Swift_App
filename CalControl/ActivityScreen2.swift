///
//  ActivityScreen1.swift
//  CalControl
//
//  Created by stud on 28/11/2024.
//
import SwiftUI

struct ChevronLeftView:View{
    @ObservedObject var appState: AppState
    var body: some View{
        Image(systemName: "chevron.left")
            .font(.system(size: 32, weight: .bold))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ActivityScreen2:View{
    @State var activityTime = Date.now
    
    @State private var selection: String?
    let names = ["John", "Jane", "Tom", "Lucy", "Anna"]
    
    
    var friuts = ["apple", "banana", "orange", "kiwi"]
       @State private var selectedFruit: String = "banana"
    
    var body: some View {
        
        NavigationView{
                VStack {
                        ZStack {
                            NavigationLink(destination: MainMenuView()
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)){
                                ChevonLeftView().padding(.top)
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
                                Picker("fruits", selection: $selectedFruit) {
                                    ForEach(friuts, id: \.self) { fruit in
                                        Text(fruit)
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
                            Picker("fruits", selection: $selectedFruit) {
                                ForEach(friuts, id: \.self) { fruit in
                                    Text(fruit)
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
                        destination: MainMenuView(),
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
                        destination: MainMenuView(),
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






