import SwiftUI
import Foundation

struct UserProfileView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Your Profile")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Username:")
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Text(appState.username)
                            .foregroundColor(.white)
                    }

                    HStack {
                        Text("Birth Date:")
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Text(appState.birthDate, formatter: DateFormatter.shortDate)
                            .foregroundColor(.white)
                    }

                    HStack {
                        Text("Height:")
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(appState.height ?? 0) cm")
                            .foregroundColor(.white)
                    }

                    HStack {
                        Text("Weight:")
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(appState.weight ?? 0) kg")
                            .foregroundColor(.white)
                    }

                    HStack {
                        Text("Activity Level:")
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Text(appState.activityLevel)
                            .foregroundColor(.white)
                    }

                    HStack {
                        Text("BMI:")
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Text(String(format: "%.2f", appState.bmi))
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

                Spacer()
            }
            .padding()
        }
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
