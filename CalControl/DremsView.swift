//
//  DremsView.swift
//  CalControl
//
//  Created by stud on 14/11/2024.
//
import SwiftUI

struct DreamsView:View{
    @State var wakeUp = Date.now
    @State var wentSleep = Date.now
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "chevron.left")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Manage dream")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
            
            // TODO bed logo/ icon
            Image(systemName:"star")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
                .padding()
            
            Divider()
                .background(Color.white)
                .padding(.horizontal)
            
            Spacer()
            HStack{
                Text("Add dream today")
                    .frame(maxWidth: .infinity, alignment: .top)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
            }
            
            // TODO pop-up when wokeu
            // TODO alignmnet !!1
            
            HStack{
                Image(systemName:"clock")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                DatePicker("I went to sleep:",selection: $wentSleep, displayedComponents: .hourAndMinute).colorInvert()
                    .padding(.top, 20)
                    .font(.system(size: 24, weight: .bold))
            }
                
            
            HStack{
                Image(systemName:"clock")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                
                DatePicker("I woke up at:",selection: $wakeUp, displayedComponents: .hourAndMinute).colorInvert()
            }
                .padding(.top, 20)
                .font(.system(size: 24, weight: .bold))
            Spacer()
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
            
            Divider()
            
            Text("Dreams hisotry:")
                .foregroundColor(.white)
                .font(.system(size: 40, weight: .semibold))
                .padding(.bottom, 20)
            
            Spacer()
            
            //TODO dreams history
            
            }
            .background(Color.black)
        }
    
}

struct DremsView_Preview: PreviewProvider{
    static var previews: some View {
        DreamsView()
    }
    
}


func tmp() -> Void {

}
