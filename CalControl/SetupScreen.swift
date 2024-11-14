import SwiftUI

struct SetupScreenView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Background color

            VStack {
                Spacer()
                Text("Welcome to the first step to calorie balance")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                Text("Fill in some of your information first")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.bottom, 20)
                Text("Gender:")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.bottom, 20)
                HStack {
                    Spacer()
                    Text("♀")
                        .foregroundColor(.white)
                        .font(.system(size: 70, weight: .semibold))
                        .padding(.bottom, 20)
                    Spacer()
                    Text("♂")
                        .foregroundColor(.white)
                        .font(.system(size: 70, weight: .semibold))
                        .padding(.bottom, 20)
                    Spacer()
                }
                @State var username: String = "username"
                VStack {
                    TextField(
                        "text",
                        text: $username,
                        prompt: Text("prompt")
                    ).foregroundColor(.white)

                }
                
                HStack {
                    Image(systemName: "person.circle")
                        .font(.system(size: 46, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    Image(systemName: "gearshape")
                        .font(.system(size: 46, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                }
                
                Spacer()
                //Spacer()
                
                VStack(alignment: .leading, spacing: 35) {
                    MenuOptionView(title: "Manage dreams")
                    MenuOptionView(title: "Manage activity")

                }
                .padding(.top, 20)
                .padding(.horizontal)
                .font(.system(size: 30, weight: .bold))
                Spacer()
                Spacer()
                // Calorie tracker section
                Divider()
                    .background(Color.white)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Kcal consumed:       x")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Text("Kcal burned:             x")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Text("Total balance:           x")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                Spacer()
                
                Text("--daily goal status--")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.bottom, 20)
            }
        }
    }
}

struct MenuOption2View: View {
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

struct SetupScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SetupScreenView()
    }
}
