import SwiftUI

struct MainMenuView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
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
                
                VStack(alignment: .leading, spacing: 35) {
                    MenuOptionView(title: "Manage dreams")
                    MenuOptionView(title: "Manage activity")
                    MenuOptionView(title: "Manage weight")
                    MenuOptionView(title: "Manage meals")
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
        MainMenuView()
    }
}
