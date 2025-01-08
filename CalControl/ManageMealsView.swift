import SwiftUI

struct ManageMealsView: View {
    @ObservedObject var appState: AppState
    
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return appState.allProducts
        } else {
            return appState.allProducts.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                // Górny customowy nagłówek z przyciskiem cofania
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
                    
                    Text("Manage Meals")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .bold))
                    
                    Spacer()
                    // Pusty, żeby tytuł był wyśrodkowany
                    Spacer().frame(width: 46)
                }
                .padding(.top, 10)

                // Pasek wyszukiwania
                HStack {
                    TextField("Search product...", text: $searchText, onEditingChanged: { editing in
                        isSearching = editing
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 8)

                    if isSearching {
                        Button(action: {
                            searchText = ""
                            isSearching = false
                            UIApplication.shared.endEditing()
                        }) {
                            Text("Cancel")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 8)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)

                // Lista produktów
                List(filteredProducts) { product in
                    NavigationLink(destination:
                        AddMealView(appState: appState, product: product)
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    ) {
                        HStack(spacing: 16) {
                            if let imageName = product.imageName, !imageName.isEmpty {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            Text(product.name)
                                .foregroundColor(.white)
                        }
                    }
                    .listRowBackground(Color.gray.opacity(0.25))
                }
                .listStyle(PlainListStyle())
                .background(Color.black)
                
                Spacer()
            }
        }
        // Ukrywamy systemowy pasek nawigacji
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}
