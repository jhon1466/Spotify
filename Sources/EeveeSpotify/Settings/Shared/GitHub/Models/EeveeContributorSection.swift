struct GalapagameContributorSection: Decodable, Equatable {
    var title: String
    var shuffled: Bool
    var contributors: [GalapagameContributor]
}
