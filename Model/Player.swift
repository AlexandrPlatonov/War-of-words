

import Foundation

struct Player {
    let name: String
    private(set) var score: Int = 0
    
    mutating func add(score: Int) {
        self.score += score
    }
}
