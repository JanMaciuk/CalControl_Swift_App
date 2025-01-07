import Foundation

func saveRecordsToFile(records: Records, fileName: String) {
    // Określenie katalogu Downloads
    let fileManager = FileManager.default
    let downloadsDirectory = URL(fileURLWithPath: "/Users/stud/Downloads")
    let fileURL = downloadsDirectory.appendingPathComponent(fileName)
    
    // Wydrukowanie ścieżki do pliku
    print("Plik zapisany w: \(fileURL.path)")
    
    do {
        // Kodowanie danych do formatu JSON
        let encoder = JSONEncoder()
        let data = try encoder.encode(records)
        
        // Zapisanie danych do pliku
        try data.write(to: fileURL)
        print("Dane zapisane do \(fileURL.path)")
    } catch {
        print("Błąd zapisywania do pliku: \(error)")
    }
}


func loadRecordsFromFile(fileName: String) -> Records {
    let fileManager = FileManager.default
    let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentDirectory.appendingPathComponent(fileName)
    
    if fileManager.fileExists(atPath: fileURL.path) {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let records = try decoder.decode(Records.self, from: data)
            return records
        } catch {
            print("Błąd wczytywania danych: \(error)")
        }
    }
    return Records()
}
