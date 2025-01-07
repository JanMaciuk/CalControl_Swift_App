//
import Foundation

struct Record: Codable {
    let text: String
}

struct Records: Codable {
    var items: [Record]
    
    init() {
        self.items = []
    }
    
    mutating func addRecord(_ record: Record) {
        self.items.append(record)
    }
}
