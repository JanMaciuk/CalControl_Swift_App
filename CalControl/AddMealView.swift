import SwiftUI

struct AddMealView: View {
    @ObservedObject var appState: AppState
    @State private var selectedProducer = "Value"
    @State private var gramsEaten = ""
    @State private var optionalNotes = ""
    @State private var showProducerPicker = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    NavigationLink(destination: MainMenuView(appState: appState).navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                        ChevronLeft()
                    }
                    Spacer()
                    Text("Add new meal")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 8) {
                    Text("Producer")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button(action: {
                        showProducerPicker.toggle()
                    }) {
                        HStack {
                            Text(selectedProducer)
                                .foregroundColor(.black)
                                .padding(.leading)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                }

                VStack(spacing: 8) {
                    Text("Grams")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack {
                        TextField("Enter grams", text: $gramsEaten)
                            .keyboardType(.decimalPad) // Klawiatura numeryczna
                            .padding(.leading, 10)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }

                VStack(spacing: 10) {
                    HStack {
                        Text("Kcal:").fontWeight(.semibold)
                        Spacer()
                        Text("x")
                    }
                    HStack {
                        Text("Protein:").fontWeight(.semibold)
                        Spacer()
                        Text("x")
                    }
                    HStack {
                        Text("Carbs:").fontWeight(.semibold)
                        Spacer()
                        Text("x")
                    }
                    HStack {
                        Text("Fat:").fontWeight(.semibold)
                        Spacer()
                        Text("x")
                    }
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)

                Divider()
                    .background(Color.white)

                VStack(spacing: 8) {
                    Text("Optional notes")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    TextEditor(text: $optionalNotes)
                        .frame(height: 100)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    // Add logic
                }) {
                    Text("Add")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)

                Spacer(minLength: 30)
            }
            .padding(.horizontal, 20)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
            .actionSheet(isPresented: $showProducerPicker) {
                ActionSheet(
                    title: Text("Choose a producer"),
                    buttons: [
                        .default(Text("Producer 1")) { selectedProducer = "Producer 1" },
                        .default(Text("Producer 2")) { selectedProducer = "Producer 2" },
                        .cancel()
                    ]
                )
            }
        }
    }
}

struct ChevronLeft: View {
    var body: some View {
        Image(systemName: "chevron.left")
            .font(.system(size: 30))
            .foregroundColor(.white)
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(appState: AppState())
    }
}
