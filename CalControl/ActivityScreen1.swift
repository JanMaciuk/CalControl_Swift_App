//
//  ActivityScreen1.swift
//  CalControl
//
//  Created by stud on 28/11/2024.
//

import SwiftUI

struct ActicityScreen1:View{
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "chevron.left")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Manage Activity")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
            HStack{
                
                ScrollViewReader { proxy in
                    VStack {
                        List(0..<100, id: \.self) { i in
                            Text("Example \(i)")
                                .id(i) // Assign unique IDs to each item for scrolling
                        }
                    }
                }
            }


            
            NavigationLink(
                destination: MainMenuView(),
                label: {
                    Text("Add new activity")
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .frame(width: UIScreen.main.bounds.width * 0.8) // does not work correctly
                        .font(.system(size: 20, weight: .semibold))
                }
            )
            
            //TODO Cos tam z aktywnosccia
            
            Divider()
            Text("Username:")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
            
          
            
            }
            .background(Color.black)
        }
    
}

struct ActicityScreen1_Preview: PreviewProvider{
    static var previews: some View {
        ActicityScreen1()
    }
    
}





