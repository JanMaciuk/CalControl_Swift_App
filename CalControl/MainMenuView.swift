import SwiftUI

struct MainMenuView: View {
    @State private var showWeightPopup = false

    var body: some View {
        NavigationView {
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
                        
                        Button(action: {
                            showWeightPopup.toggle()
                        }) {
                            MenuOptionView(title: "Manage weight")
                        }

                        NavigationLink(destination: AddMealView().navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                            MenuOptionView(title: "Manage meals")
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    .font(.system(size: 30, weight: .bold))

                    Spacer()
                    Spacer()

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

                if showWeightPopup {
                    WeightPopupView(showPopup: $showWeightPopup)
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct WeightPopupView: View {
    @Binding var showPopup: Bool
    @State private var newWeight = ""

    var body: some View {
        ZStack {
            Color.black.opacity(0.7).edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button(action: {
                        showPopup = false
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }

                HStack {
                    Text("Last change:")
                        .foregroundColor(.white)
                    Spacer()
                    Text("xx-xx-xxxx")
                        .foregroundColor(.white)
                }

                HStack {
                    Text("New weight:")
                        .foregroundColor(.white)
                    Spacer()
                    TextField("Enter weight", text: $newWeight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .padding(.leading, 10)
                        .frame(maxWidth: 150)
                }

                HStack {
                    Button(action: {
                        // More logic
                    }) {
                        Text("More")
                            .padding()
                            .frame(maxWidth: 100)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Spacer()

                    Button(action: {
                        // Apply logic
                        showPopup = false
                    }) {
                        Text("Apply")
                            .padding()
                            .frame(maxWidth: 100)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(15)
            .padding(.horizontal, 30)
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
