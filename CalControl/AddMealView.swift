import SwiftUI

struct AddMealView: View {
    @ObservedObject var appState: AppState
    let product: Product

    @Environment(\.presentationMode) var presentationMode
    
    @State private var gramsEaten: String = ""
    @State private var optionalNotes: String = ""

    var totalKcal: Double {
        guard let grams = Double(gramsEaten) else { return 0 }
        return (grams / 100.0) * product.kcalPer100g
    }
    var totalProtein: Double {
        guard let grams = Double(gramsEaten) else { return 0 }
        return (grams / 100.0) * product.proteinPer100g
    }
    var totalCarbs: Double {
        guard let grams = Double(gramsEaten) else { return 0 }
        return (grams / 100.0) * product.carbsPer100g
    }
    var totalFat: Double {
        guard let grams = Double(gramsEaten) else { return 0 }
        return (grams / 100.0) * product.fatPer100g
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        // Cofnij się w istniejącym stosie nawigacji
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding(.leading, 16)
                    }
                    Spacer()
                    Text("Add new meal")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Spacer().frame(width: 30)
                }
                .padding([.top, .horizontal], 10)

                Text("Product: \(product.name)")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                HStack(spacing: 16) {
                    if let imageName = product.imageName, !imageName.isEmpty {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                VStack(spacing: 10) {
                    Text("Grams")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    TextField("Enter grams", text: $gramsEaten)
                        .keyboardType(.decimalPad)
                        .padding()
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }

                VStack(spacing: 10) {
                    HStack {
                        Text("Kcal:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(Int(totalKcal))")
                    }
                    HStack {
                        Text("Protein:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(Int(totalProtein)) g")
                    }
                    HStack {
                        Text("Carbs:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(Int(totalCarbs)) g")
                    }
                    HStack {
                        Text("Fat:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(Int(totalFat)) g")
                    }
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 50)

                VStack(spacing: 10) {
                    Text("Optional notes")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    TextEditor(text: $optionalNotes)
                        .frame(height: 80)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }

                Button(action: {
                    guard let gramsValue = Double(gramsEaten), gramsValue > 0 else { return }

                    let newMeal = EatenMeal(
                        product: product,
                        grams: gramsValue,
                        dateEaten: Date()
                    )
                    appState.eatenMeals.append(newMeal)
                    appState.kcal_consumed += Int(newMeal.totalKcal)
                }) {
                    Text("Add")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }
                .padding(.top, 10)

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
