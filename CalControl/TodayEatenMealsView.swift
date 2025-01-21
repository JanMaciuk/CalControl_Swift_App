import SwiftUI

struct TodayEatenMealsView: View {
    @ObservedObject var appState: AppState

    @Environment(\.presentationMode) var presentationMode
    
    var totalKcal: Double {
        appState.eatenMeals.reduce(0) { $0 + $1.totalKcal }
    }
    var totalProtein: Double {
        appState.eatenMeals.reduce(0) { $0 + $1.totalProtein }
    }
    var totalCarbs: Double {
        appState.eatenMeals.reduce(0) { $0 + $1.totalCarbs }
    }
    var totalFat: Double {
        appState.eatenMeals.reduce(0) { $0 + $1.totalFat }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                // Górny pasek
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
                    Text("Today eaten meals")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .bold))
                    Spacer()
                    Spacer().frame(width: 46)
                }
                .padding(.top, 10)

                // Lista
                List {
                    ForEach(appState.eatenMeals) { eaten in
                        HStack(spacing: 16) {
                            if let imageName = eaten.product.imageName, !imageName.isEmpty {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else {
                                // Placeholder
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(eaten.product.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("\(Int(eaten.grams)) g, \(Int(eaten.totalKcal)) kcal")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .listRowBackground(Color.gray.opacity(0.2))
                    }
                    .onDelete(perform: deleteMeal)
                }
                .listStyle(PlainListStyle())
                .background(Color.black)

                // Podsumowanie
                VStack(spacing: 5) {
                    Text("Total Kcal: \(Int(totalKcal))").accessibilityIdentifier("mainMenuViewKcalConsumed")
                    Text("Protein: \(Int(totalProtein)) g").accessibilityIdentifier("mainMenuViewProteinConsumed")
                    Text("Carbs: \(Int(totalCarbs)) g").accessibilityIdentifier("mainMenuViewCarbsConsumed")
                    Text("Fat: \(Int(totalFat)) g").accessibilityIdentifier("mainMenuViewFatConsumed")
                }
                .foregroundColor(.white)
                .padding(.vertical, 20)

                Spacer()
            }
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }

    private func deleteMeal(at offsets: IndexSet) {
        for index in offsets {
            let meal = appState.eatenMeals[index]
            // Odejmij od kcal_consumed
            appState.kcal_consumed -= Int(meal.totalKcal)
            // Usuń z tablicy
            appState.eatenMeals.remove(at: index)
        }
    }
}
