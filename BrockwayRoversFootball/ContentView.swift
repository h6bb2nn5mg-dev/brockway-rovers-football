import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house.fill") }
            ScheduleView().tabItem { Label("Schedule", systemImage: "calendar") }
            RosterView().tabItem { Label("Roster", systemImage: "person.3.fill") }
            NewsView().tabItem { Label("News", systemImage: "newspaper.fill") }
            MoreView().tabItem { Label("More", systemImage: "square.grid.2x2.fill") }
        }
        .tint(RoverTheme.red)
        .preferredColorScheme(.dark)
    }
}

enum RoverTheme {
    static let red = Color(red: 0.78, green: 0.08, blue: 0.06)
    static let card = Color.white.opacity(0.07)
    static let border = Color.white.opacity(0.13)
    static let muted = Color.white.opacity(0.62)
}

private let liveStreamURL = URL(string: "https://www.nfhsnetwork.com/schools/brockway-area-high-school-brockway-pa/football")!

struct BundledImage: View {
    let name: String
    let ext: String
    private var image: UIImage? {
        UIImage(named: "\(name).\(ext)") ?? UIImage(named: name) ?? Bundle.main.url(forResource: name, withExtension: ext).flatMap { UIImage(contentsOfFile: $0.path) }
    }
    var body: some View {
        Group {
            if let image { Image(uiImage: image).resizable() }
            else { Rectangle().fill(Color(red: 0.07, green: 0.07, blue: 0.08)).overlay { Image(systemName: "photo").font(.largeTitle).foregroundStyle(.white.opacity(0.18)) } }
        }
    }
}

extension View {
    func roverCard() -> some View {
        self.padding(18).background(RoverTheme.card).overlay(RoundedRectangle(cornerRadius: 20).stroke(RoverTheme.border)).clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct TeamHero: View {
    let height: CGFloat
    let title: String
    let subtitle: String
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            BundledImage(name: "team-hero", ext: "jpg").scaledToFill().frame(maxWidth: .infinity).frame(height: height).clipped()
            LinearGradient(colors: [.clear, .black.opacity(0.18), .black.opacity(0.94)], startPoint: .top, endPoint: .bottom)
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.system(size: 29, weight: .black, design: .rounded))
                Text(subtitle).font(.caption.weight(.bold)).foregroundStyle(RoverTheme.muted)
            }.padding(18)
        }.frame(maxWidth: .infinity).frame(height: height).clipped()
    }
}

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                TeamHero(height: 245, title: "BROCKWAY ROVERS", subtitle: "2026 FOOTBALL")
                VStack(alignment: .leading, spacing: 14) {
                    HStack { Text("NEXT GAME").font(.caption.weight(.black)).foregroundStyle(RoverTheme.red); Spacer(); Text("FRI • SEPT 4").font(.caption.weight(.bold)).foregroundStyle(RoverTheme.muted) }
                    HStack {
                        VStack(alignment: .leading, spacing: 3) { Text("BROCKWAY").font(.title2.weight(.black)); Text("at DuBois").foregroundStyle(RoverTheme.muted) }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 3) { Text("7:00 PM").font(.title3.weight(.black)); Text("Away").font(.caption.weight(.bold)).foregroundStyle(RoverTheme.red) }
                    }
                    Link(destination: liveStreamURL) {
                        HStack { Image(systemName: "play.rectangle.fill"); Text("WATCH LIVE").fontWeight(.black); Spacer(); Image(systemName: "arrow.up.right") }
                            .foregroundStyle(.white).padding(.horizontal, 16).frame(height: 50).background(RoverTheme.red).clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }.roverCard().padding(.horizontal, 16)
                VStack(alignment: .leading, spacing: 13) {
                    Text("COMING UP").font(.headline.weight(.black))
                    CompactGame(date: "SEP 4", opponent: "@ DuBois", time: "7:00 PM")
                    Divider().overlay(Color.white.opacity(0.12))
                    CompactGame(date: "SEP 11", opponent: "St. Marys", time: "7:00 PM")
                    Divider().overlay(Color.white.opacity(0.12))
                    CompactGame(date: "SEP 18", opponent: "Port Allegany", time: "7:00 PM")
                }.roverCard().padding(.horizontal, 16)
            }.padding(.bottom, 105)
        }.background(Color.black.ignoresSafeArea())
    }
}

struct CompactGame: View {
    let date: String; let opponent: String; let time: String
    var body: some View {
        HStack(spacing: 10) {
            Text(date).font(.caption.weight(.black)).foregroundStyle(RoverTheme.red).frame(width: 54, alignment: .leading)
            Text(opponent).font(.subheadline.weight(.bold)); Spacer(); Text(time).font(.caption.weight(.semibold)).foregroundStyle(RoverTheme.muted)
        }
    }
}

struct Game: Identifiable { let id = UUID(); let date: String; let opponent: String; let location: String; let time: String }
let roverSchedule = [
    Game(date: "AUG 28", opponent: "Keystone", location: "Away", time: "7:00 PM"), Game(date: "SEP 4", opponent: "DuBois", location: "Away", time: "7:00 PM"), Game(date: "SEP 11", opponent: "St. Marys", location: "Home", time: "7:00 PM"), Game(date: "SEP 18", opponent: "Port Allegany", location: "Home", time: "7:00 PM"), Game(date: "SEP 25", opponent: "Redbank", location: "Away", time: "7:00 PM"), Game(date: "OCT 2", opponent: "Brookville", location: "Home", time: "7:00 PM"), Game(date: "OCT 9", opponent: "Punxsutawney", location: "Away", time: "7:00 PM"), Game(date: "OCT 16", opponent: "Cameron County", location: "Home", time: "7:00 PM"), Game(date: "OCT 23", opponent: "Bradford", location: "Away", time: "7:00 PM"), Game(date: "OCT 30", opponent: "Maplewood", location: "Home", time: "7:00 PM")
]

struct ScheduleView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 3) { Text("2026 SCHEDULE").font(.system(size: 28, weight: .black, design: .rounded)); Text("BROCKWAY ROVERS FOOTBALL").font(.caption.weight(.bold)).foregroundStyle(RoverTheme.muted) }.padding(.top, 16).padding(.bottom, 4)
                ForEach(roverSchedule) { game in
                    HStack(spacing: 12) {
                        Text(game.date).font(.caption.weight(.black)).foregroundStyle(RoverTheme.red).frame(width: 62, alignment: .leading)
                        VStack(alignment: .leading, spacing: 3) { Text(game.opponent).font(.headline); Text(game.location).font(.caption).foregroundStyle(RoverTheme.muted) }
                        Spacer(); Text(game.time).font(.subheadline.weight(.bold))
                    }.roverCard()
                }
            }.padding(.horizontal, 16).padding(.bottom, 105)
        }.background(Color.black.ignoresSafeArea())
    }
}

struct Player: Identifiable { let id = UUID(); let number: Int; let name: String; let grade: String; let height: String; let weight: String? }
let roverRoster: [Player] = [
    Player(number: 0, name: "Kolton Kahle", grade: "Sr.", height: "6'3\"", weight: "195"), Player(number: 1, name: "Cole Senior", grade: "Jr.", height: "5'10\"", weight: "160"), Player(number: 2, name: "Nico Inzana", grade: "So.", height: "6'2\"", weight: "188"), Player(number: 3, name: "Quentin Perrin", grade: "Jr.", height: "5'7\"", weight: "150"), Player(number: 4, name: "Ben Bash", grade: "Fr.", height: "6'2\"", weight: "178"), Player(number: 6, name: "Rylan Kuhar", grade: "Fr.", height: "5'10\"", weight: "170"), Player(number: 7, name: "Chase Little", grade: "Fr.", height: "5'9\"", weight: "150"), Player(number: 8, name: "Matthew Winnings", grade: "Jr.", height: "5'9\"", weight: "170"), Player(number: 9, name: "Collin Weir", grade: "Sr.", height: "5'11\"", weight: "173"), Player(number: 10, name: "Aiden Patton", grade: "Sr.", height: "6'3\"", weight: "212"), Player(number: 11, name: "Caleb Daugherty", grade: "Sr.", height: "6'1\"", weight: "195"), Player(number: 12, name: "Eli Miller", grade: "Fr.", height: "5'10\"", weight: "155"), Player(number: 13, name: "Brian Zameroski", grade: "Fr.", height: "5'7\"", weight: "140"), Player(number: 15, name: "Brady Ferraro", grade: "So.", height: "5'10\"", weight: "150"), Player(number: 17, name: "Kyle Kennedy", grade: "Sr.", height: "5'10\"", weight: "170"), Player(number: 22, name: "Cole Gooding", grade: "So.", height: "5'10\"", weight: "175"), Player(number: 30, name: "Dylan Colbey", grade: "Fr.", height: "5'5\"", weight: "135"), Player(number: 32, name: "Skyler Logan", grade: "Jr.", height: "5'9\"", weight: "175"), Player(number: 50, name: "Madox Decker", grade: "Sr.", height: "6'4\"", weight: "235"), Player(number: 51, name: "Cash Butters", grade: "Sr.", height: "5'10\"", weight: "215"), Player(number: 52, name: "Chase Wolfe", grade: "Jr.", height: "5'11\"", weight: "275"), Player(number: 53, name: "Liam Schwentner", grade: "Fr.", height: "6'2\"", weight: "185"), Player(number: 54, name: "Keagan Allaman", grade: "Fr.", height: "5'11\"", weight: "205"), Player(number: 55, name: "Blake Mowrey", grade: "Jr.", height: "6'4\"", weight: "259"), Player(number: 56, name: "Zayden Faith", grade: "Sr.", height: "6'1\"", weight: "195"), Player(number: 57, name: "Brock Yale", grade: "Fr.", height: "5'11\"", weight: "230"), Player(number: 58, name: "Xavier Schwentner", grade: "Sr.", height: "6'0\"", weight: "225"), Player(number: 59, name: "Marley Carlson", grade: "Fr.", height: "5'11\"", weight: nil), Player(number: 60, name: "Mario Berta", grade: "Fr.", height: "5'11\"", weight: "175"), Player(number: 61, name: "Noah Crawford", grade: "Fr.", height: "5'7\"", weight: "140"), Player(number: 63, name: "Logan Rakvin", grade: "Jr.", height: "5'10\"", weight: "220"), Player(number: 66, name: "Carter Reed", grade: "Fr.", height: "5'5\"", weight: "160"), Player(number: 71, name: "Peter O'Donnel", grade: "Fr.", height: "6'3\"", weight: "215"), Player(number: 77, name: "Lincoln Woods", grade: "Fr.", height: "6'0\"", weight: "170")
]

struct PlayerPortrait: View {
    let player: Player
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let photo = PlayerPhotoAtlas.image(for: player.number) { Image(uiImage: photo).resizable().scaledToFill() }
                else { ZStack { RoverTheme.card; Image(systemName: "person.fill").font(.title2).foregroundStyle(.white.opacity(0.4)) } }
            }.frame(width: 68, height: 68).clipShape(RoundedRectangle(cornerRadius: 14))
            Text("\(player.number)").font(.caption2.weight(.black)).foregroundStyle(.white).padding(.horizontal, 7).padding(.vertical, 4).background(RoverTheme.red).clipShape(Capsule()).offset(x: 5, y: 5)
        }.frame(width: 73, height: 73)
    }
}

struct RosterView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                TeamHero(height: 205, title: "ROVERS ROSTER", subtitle: "2026 VARSITY • 34 PLAYERS")
                LazyVStack(spacing: 0) {
                    ForEach(roverRoster) { player in
                        HStack(spacing: 14) {
                            PlayerPortrait(player: player)
                            VStack(alignment: .leading, spacing: 5) {
                                Text(player.name).font(.headline.weight(.bold))
                                Text("\(player.grade)  •  \(player.height)  •  \(player.weight.map { $0 + " lbs" } ?? "—")").font(.caption).foregroundStyle(RoverTheme.muted)
                            }
                            Spacer(minLength: 4)
                        }.padding(.horizontal, 16).padding(.vertical, 10)
                        Divider().overlay(Color.white.opacity(0.10)).padding(.leading, 102)
                    }
                }
            }.padding(.bottom, 105)
        }.background(Color.black.ignoresSafeArea())
    }
}

struct NewsView: View {
    let featureURL = URL(string: "https://www.exploreclarion.com/sports/2026/08/25/more-than-the-sum-brockway-banking-on-collective-strength-in-return-to-class-a-872817/")!
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 3) { Text("ROVERS NEWS").font(.system(size: 28, weight: .black, design: .rounded)); Text("LATEST FROM BROCKWAY FOOTBALL").font(.caption.weight(.bold)).foregroundStyle(RoverTheme.muted) }.padding(.top, 16)
                Link(destination: featureURL) { VStack(alignment: .leading, spacing: 10) { Text("FEATURED").font(.caption.weight(.black)).foregroundStyle(RoverTheme.red); Text("More Than the Sum: Brockway Banking on Collective Strength").font(.title3.weight(.black)).foregroundStyle(.white); Text("ExploreClarion  ↗").foregroundStyle(RoverTheme.muted) }.frame(maxWidth: .infinity, alignment: .leading).roverCard() }
                Link(destination: liveStreamURL) { HStack { Image(systemName: "play.rectangle.fill").font(.title2).foregroundStyle(RoverTheme.red); VStack(alignment: .leading, spacing: 3) { Text("Rovers Live & On Demand").font(.headline.weight(.bold)).foregroundStyle(.white); Text("Open the Brockway football stream page").font(.caption).foregroundStyle(RoverTheme.muted) }; Spacer(); Image(systemName: "arrow.up.right").foregroundStyle(.white) }.roverCard() }
            }.padding(.horizontal, 16).padding(.bottom, 105)
        }.background(Color.black.ignoresSafeArea())
    }
}

struct MoreView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 3) { Text("BROCKWAY ROVERS").font(.system(size: 28, weight: .black, design: .rounded)); Text("2026 FOOTBALL").font(.caption.weight(.bold)).foregroundStyle(RoverTheme.muted) }.padding(.top, 16)
                Link(destination: liveStreamURL) { HStack { Image(systemName: "play.rectangle.fill").foregroundStyle(RoverTheme.red); Text("Watch Rovers Live").font(.headline).foregroundStyle(.white); Spacer(); Image(systemName: "arrow.up.right").foregroundStyle(.white) }.roverCard() }
                VStack(alignment: .leading, spacing: 10) { Text("BROCKWAY AREA HIGH SCHOOL").font(.headline.weight(.black)); Text("Rovers Football • District 9").foregroundStyle(RoverTheme.muted) }.roverCard()
            }.padding(.horizontal, 16).padding(.bottom, 105)
        }.background(Color.black.ignoresSafeArea())
    }
}
