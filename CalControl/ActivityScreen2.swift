///
//  ActivityScreen1.swift
//  CalControl
//
//  Created by stud on 28/11/2024.
//
import SwiftUI

struct ActivityScreen2:View{
    @State var activityTime = Date.now
    
    @State private var selection: String?
    let names = ["John", "Jane", "Tom", "Lucy", "Anna"]
    
    
    var friuts = ["apple", "banana", "orange", "kiwi"]
       @State private var selectedFruit: String = "banana"
    
    var body: some View {

        ZStack
        {
            Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    
                    
                        ZStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
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
                                }
                            }
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
                            }
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
                    
                        
                }
            }
        }
    
}

struct ActivityScreen2_Preview: PreviewProvider{
    static var previews: some View {
        ActivityScreen2()
    }
    
}






