import SwiftUI

struct ActicityScreen1: View {
    var body: some View {
        NavigationView {
            VStack {
                
                ZStack {
                    NavigationLink(
                        destination: MainMenuView().navigationBarBackButtonHidden(true)
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
                
                Text("Burned kcal:")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .semibold))
                    .padding(.top)
                
                // TODO add kcal global variables
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
                    destination: MainMenuView(),
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
        }
    }
}

struct ActicityScreen1_Preview: PreviewProvider {
    static var previews: some View {
        ActicityScreen1()
    }
}
