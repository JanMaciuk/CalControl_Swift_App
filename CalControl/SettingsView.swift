import SwiftUI

struct UserSettingsView: View {
    @ObservedObject var appState: AppState

    @State private var tempUsername: String
    @State private var tempBirthDate: Date
    @State private var tempHeight: Int?
    @State private var tempWeight: Int?
    @State private var tempActivityLevel: String

    init(appState: AppState) {
        self.appState = appState
        _tempUsername = State(initialValue: appState.username)
        _tempBirthDate = State(initialValue: appState.birthDate)
        _tempHeight = State(initialValue: appState.height)
        _tempWeight = State(initialValue: appState.weight)
        _tempActivityLevel = State(initialValue: appState.activityLevel)
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    Text("Settings")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    VStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Username")
                                .foregroundColor(.white)
                                .font(.headline)
                            TextField("Enter username", text: $tempUsername)
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(8)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Birth Date")
                                .foregroundColor(.white)
                                .font(.headline)
                            DatePicker("", selection: $tempBirthDate, displayedComponents: .date)
                                .labelsHidden()
                                .datePickerStyle(WheelDatePickerStyle())
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(8)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Height (cm)")
                                .foregroundColor(.white)
                                .font(.headline)
                            TextField(tempHeight != nil ? "\(tempHeight!)" : "Enter height", value: $tempHeight, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(8)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Weight (kg)")
                                .foregroundColor(.white)
                                .font(.headline)
                            TextField(tempWeight != nil ? "\(tempWeight!)" : "Enter weight", value: $tempWeight, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(8)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Activity Level")
                                .foregroundColor(.white)
                                .bold()
                            Picker("", selection: $tempActivityLevel) {
                                Text("Low").tag("Low")
                                Text("Medium").tag("Medium")
                                Text("High").tag("High")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                        }
                    }
                    .padding()

                    Button(action: {
                        appState.username = tempUsername
                        appState.birthDate = tempBirthDate
                        appState.height = tempHeight
                        appState.weight = tempWeight
                        appState.activityLevel = tempActivityLevel
                        appState.calculateBMI()
                    }) {
                        Text("Save Changes")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
}
