import SwiftUI

struct Content: View {
    @State private var inputText: String = ""
    @State private var records = Records()
    
    private let fileName = "records.json"
    
    var body: some View {
        VStack {
            TextField("Wprowadź tekst", text: $inputText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Zapisz do JSON") {
                let newRecord = Record(text: inputText)
                records.addRecord(newRecord)
                saveRecordsToFile(records: records, fileName: fileName)
                inputText = ""
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            List(records.items, id: \.text) { record in
                Text(record.text)
            }
            .padding()
        }
        .padding()
        .onAppear {
            records = loadRecordsFromFile(fileName: fileName)
        }
    }
}

struct Content_Preview: PreviewProvider {
    static var previews: some View {
        Content()
    }
}
