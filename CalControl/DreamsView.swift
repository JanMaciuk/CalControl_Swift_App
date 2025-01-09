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
            let sleepEntry = AppState.SleepHistory(went: wentSleep, wake: wakeUp)
            appState.sleep_history.append(sleepEntry)

        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
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

                    HStack {
                        Image(systemName: "star")
                            .frame(width: 40, height: 40)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .padding()

                        if let lastSleep = appState.sleep_history.last {
                            let hours = Int(lastSleep.interval) / 3600
                            let minutes = (Int(lastSleep.interval) % 3600) / 60
                            Text("You sleep: \(hours) h \(minutes) min")
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
                        ScrollViewReader { proxy in
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack {
                                    ForEach(0..<appState.sleep_history.count, id: \.self) { i in
                                        HStack {
                                            let lastSleep = appState.sleep_history[i]
                                            let hours = Int(lastSleep.interval) / 3600
                                            let minutes = (Int(lastSleep.interval) % 3600) / 60
                                            Text("You sleep: \(hours) h \(minutes) min")
                                                .foregroundColor(.white)
                                                .font(.system(size: 18, weight: .regular))
                                            
                                            Text("From: \(appState.sleep_history[i].went, formatter: dateFormatter) to: \(appState.sleep_history[i].wake, formatter: dateFormatter)")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .regular))
                                        }
                                        .padding()
                                        .background(Color.white.opacity(0.1))
                                        .cornerRadius(30)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(.white, lineWidth: 4)
                                        )
                                        .id(i)
                                    }
                                }
                                .padding()
                            }
                            .frame(maxHeight: UIScreen.main.bounds.height * 0.5)
                            .onChange(of: appState.sleep_history.count) { _ in
                                if let lastIndex = appState.sleep_history.indices.last {
                                    withAnimation {
                                        proxy.scrollTo(lastIndex, anchor: .bottom)
                                    }
                                }
                            }
                        }
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
