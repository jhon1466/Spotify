enum GalapagamePropertyModification {
    case remove
    case setBool(Bool)
    case setEnum(String)
}

struct GalapagamePropertyReplacement {
    let scope: String?
    let name: String?
    let modification: GalapagamePropertyModification
    
    init(name: String? = nil, scope: String? = nil, modification: GalapagamePropertyModification) {
        self.name = name
        self.scope = scope
        self.modification = modification
    }
}
