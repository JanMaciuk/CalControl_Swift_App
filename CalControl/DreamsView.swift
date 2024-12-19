import SwiftUI

struct DreamsView: View {
    @ObservedObject var appState: AppState
    @State var wakeUp = Date.now
    @State var wentSleep = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date.now

    func changeDates() {
        if (wakeUp < wentSleep){
            let tmp = wakeUp
            wakeUp = wentSleep
            wentSleep = tmp
        }
    }
    
    func updateAppState() {
        if (wakeUp > wentSleep){
            let difference = Calendar.current.dateComponents([.hour, .minute], from: wentSleep, to: wakeUp)
            appState.sleep_history.append((went: wentSleep, wake: wakeUp, interval: (difference.hour ?? 0, difference.minute ?? 0)))
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView { // Owijamy całą zawartość w ScrollView
                VStack {
                    ZStack {
                        NavigationLink(destination: MainMenuView(appState: appState).navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true)) {
                            ChevronLeftView().padding(.top)
                        }

                        Text("Manage dream")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }

                    // TODO bed logo/icon
                    HStack {
                        Image(systemName: "star")
                            .frame(width: 40, height: 40)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .padding()

                        if let lastSleep = appState.sleep_history.last {
                            Text("You sleep: \(lastSleep.interval.0) h \(lastSleep.interval.1) min")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                        } else {
                            Text("You sleep: 0 h 0 min")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                        }
                    }

                    Divider()
                        .background(Color.white)
                        .padding(.horizontal)

                    Spacer()

                    HStack {
                        Text("Add dream today")
                            .frame(maxWidth: .infinity, alignment: .top)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }

                    HStack {
                        Image(systemName: "clock")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .padding()

                        Text("Start sleep:")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.bottom, 5)

                        DatePicker("", selection: $wentSleep, displayedComponents: [.date, .hourAndMinute])
                            .onChange(of: wentSleep) { _ in
                                changeDates()
                            }
                            .colorInvert()
                            .padding(.top, 5)
                            .font(.system(size: 24, weight: .bold))
                            .cornerRadius(15)
                    }

                    HStack {
                        Image(systemName: "clock")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .padding()

                        Text("Wake up:")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.bottom, 5)

                        DatePicker("", selection: $wakeUp, displayedComponents: [.date, .hourAndMinute])
                            .onChange(of: wakeUp) { _ in
                                changeDates()
                            }
                            .colorInvert()
                            .padding(.top, 5)
                            .font(.system(size: 24, weight: .bold))
                            .cornerRadius(15)
                    }
                    .padding(.top, 20)
                    .font(.system(size: 24, weight: .bold))

                    Spacer()

                    NavigationLink(
                        destination: MainMenuView(appState: appState).navigationBarHidden(true).navigationBarBackButtonHidden(true),
                        label: {
                            Text("Add")
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                                .frame(width: UIScreen.main.bounds.width * 0.8)
                                .font(.system(size: 20, weight: .semibold))
                        }
                    ).simultaneousGesture(TapGesture().onEnded {
                        updateAppState()
                    })

                    Divider()

                    Text("Dreams history:")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .semibold))
                        .padding(.bottom, 20)

                    Spacer()
                    
                    if appState.sleep_history.isEmpty {
                        Text("No sleep history available.")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.bottom, 20)
                    } else {
                        List(appState.sleep_history, id: \.went) { sleepRecord in
                            VStack(alignment: .leading) {
                                Text("Sleep: \(sleepRecord.interval.0) hours \(sleepRecord.interval.1) minutes")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .regular))
                                Text("From: \(sleepRecord.went, formatter: dateFormatter) to: \(sleepRecord.wake, formatter: dateFormatter)")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .regular))
                            }
                            .padding()
                        }
                        .background(Color.black)
                        .cornerRadius(10)
                    }
                }
                .background(Color.black)
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}

struct DreamsView_Preview: PreviewProvider {
    static var previews: some View {
        DreamsView(appState: AppState())
    }
}

struct ChevronLeftView: View {
    var body: some View {
        Image(systemName: "chevron.left")
            .font(.system(size: 32, weight: .bold))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
