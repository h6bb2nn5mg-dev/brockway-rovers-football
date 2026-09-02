import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
            ScheduleView()
                .tabItem { Label("Schedule", systemImage: "calendar") }
            RosterView()
                .tabItem { Label("Roster", systemImage: "person.3.fill") }
            NewsView()
                .tabItem { Label("News", systemImage: "newspaper.fill") }
            MoreView()
                .tabItem { Label("More", systemImage: "ellipsis.circle.fill") }
        }
        .tint(RoverTheme.red)
        .preferredColorScheme(.dark)
    }
}

enum RoverTheme {
    static let red = Color(red: 0.82, green: 0.06, blue: 0.05)
    static let card = Color.white.opacity(0.075)
    static let border = Color.white.opacity(0.13)
    static let muted = Color.white.opacity(0.64)
}

private let liveStreamURL = URL(string: "https://www.nfhsnetwork.com/schools/brockway-area-high-school-brockway-pa/football")!

struct BundledImage: View {
    let name: String
    let ext: String

    var body: some View {
        Group {
            if let url = Bundle.main.url(forResource: name, withExtension: ext),
               let image = UIImage(contentsOfFile: url.path) {
                Image(uiImage: image)
                    .resizable()
            } else {
                Rectangle().fill(Color.black)
            }
        }
    }
}

struct PlayerAvatar: View {
    let number: Int

    var body: some View {
        ZStack {
            Circle().fill(Color.white.opacity(0.08))
            if let image = PlayerPhotoAtlas.image(for: number) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            } else {
                VStack(spacing: 1) {
                    Text("#\(number)")
                        .font(.headline.weight(.black))
                    Text("ROVERS")
                        .font(.system(size: 7, weight: .bold))
                        .foregroundStyle(RoverTheme.muted)
                }
            }
        }
        .overlay(Circle().stroke(RoverTheme.red, lineWidth: 2))
        .frame(width: 66, height: 66)
        .accessibilityLabel("Player number \(number)")
    }
}

extension View {
    func roverCard() -> some View {
        self
            .padding(16)
            .background(RoverTheme.card)
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(RoverTheme.border, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct LiveButton: View {
    var body: some View {
        Link(destination: liveStreamURL) {
            HStack(spacing: 10) {
                Image(systemName: "play.rectangle.fill")
                    .font(.title3)
                VStack(alignment: .leading, spacing: 1) {
                    Text("WATCH LIVE")
                        .font(.headline.weight(.black))
                    Text("Rovers Football on NFHS Network")
                        .font(.caption)
                        .foregroundStyle(Color.white.opacity(0.85))
                }
                Spacer(minLength: 8)
                Image(systemName: "arrow.up.right")
                    .fontWeight(.bold)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, minHeight: 62)
            .background(RoverTheme.red)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ZStack(alignment: .bottomLeading) {
                    BundledImage(name: "team-hero", ext: "jpg")
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 260)
                        .clipped()

                    LinearGradient(
                        colors: [.clear, .black.opacity(0.95)],
                        startPoint: .top,
                        endPoint: .bottom
                    )

                    VStack(alignment: .leading, spacing: 4) {
                        Text("BROCKWAY")
                            .font(.system(size: 34, weight: .black, design: .rounded))
                        Text("ROVERS FOOTBALL")
                            .font(.headline.weight(.black))
                            .foregroundStyle(RoverTheme.red)
                        Text("2026 SEASON")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(RoverTheme.muted)
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 18)
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("NEXT GAME")
                            .font(.caption.weight(.black))
                            .foregroundStyle(RoverTheme.red)
                        Spacer()
                        Text("FRI • SEPT 4")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(RoverTheme.muted)
                    }

                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("BROCKWAY")
                                .font(.title2.weight(.black))
                            Text("at DuBois")
                                .font(.headline)
                                .foregroundStyle(RoverTheme.muted)
                        }
                        Spacer()
                        Text("7:00 PM")
                            .font(.title3.weight(.black))
                            .multilineTextAlignment(.trailing)
                    }

                    LiveButton()
                }
                .roverCard()
                .padding(.horizontal, 14)

                VStack(alignment: .leading, spacing: 12) {
                    Text("COMING UP")
                        .font(.headline.weight(.black))
                    upcomingRow(date: "SEP 4", opponent: "@ DuBois", time: "7:00 PM")
                    upcomingRow(date: "SEP 11", opponent: "St. Marys", time: "7:00 PM")
                    upcomingRow(date: "SEP 18", opponent: "Port Allegany", time: "7:00 PM")
                }
                .roverCard()
                .padding(.horizontal, 14)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 28)
        }
        .background(Color.black.ignoresSafeArea())
    }

    private func upcomingRow(date: String, opponent: String, time: String) -> some View {
        HStack(spacing: 10) {
            Text(date)
                .font(.caption.weight(.black))
                .foregroundStyle(RoverTheme.red)
                .frame(width: 54, alignment: .leading)
            Text(opponent)
                .font(.subheadline.weight(.semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.82)
            Spacer(minLength: 6)
            Text(time)
                .font(.caption.weight(.bold))
                .foregroundStyle(RoverTheme.muted)
        }
    }
}

struct Game: Identifiable {
    let id = UUID()
    let date: String
    let opponent: String
    let location: String
    let time: String
}

let roverSchedule = [
    Game(date: "AUG 28", opponent: "Keystone", location: "Away", time: "7:00 PM"),
    Game(date: "SEP 4", opponent: "DuBois", location: "Away", time: "7:00 PM"),
    Game(date: "SEP 11", opponent: "St. Marys", location: "Home", time: "7:00 PM"),
    Game(date: "SEP 18", opponent: "Port Allegany", location: "Home", time: "7:00 PM"),
    Game(date: "SEP 25", opponent: "Redbank", location: "Away", time: "7:00 PM"),
    Game(date: "OCT 2", opponent: "Brookville", location: "Home", time: "7:00 PM"),
    Game(date: "OCT 9", opponent: "Punxsutawney", location: "Away", time: "7:00 PM"),
    Game(date: "OCT 16", opponent: "Cameron County", location: "Home", time: "7:00 PM"),
    Game(date: "OCT 23", opponent: "Bradford", location: "Away", time: "7:00 PM"),
    Game(date: "OCT 30", opponent: "Maplewood", location: "Home", time: "7:00 PM")
]

struct ScheduleView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(roverSchedule) { game in
                        HStack(spacing: 12) {
                            Text(game.date)
                                .font(.caption.weight(.black))
                                .foregroundStyle(RoverTheme.red)
                                .frame(width: 64, alignment: .leading)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(game.opponent)
                                    .font(.headline)
                                Text(game.location)
                                    .font(.caption)
                                    .foregroundStyle(RoverTheme.muted)
                            }
                            Spacer(minLength: 8)
                            Text(game.time)
                                .font(.subheadline.weight(.bold))
                                .multilineTextAlignment(.trailing)
                        }
                        .roverCard()
                    }
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 28)
            }
            .navigationTitle("2026 Schedule")
            .background(Color.black.ignoresSafeArea())
        }
    }
}

struct Player: Identifiable {
    let id = UUID()
    let number: Int
    let name: String
    let grade: String
    let height: String
    let weight: String?
}

let roverRoster: [Player] = [
    Player(number: 0, name: "Kolton Kahle", grade: "Sr.", height: "6'3\"", weight: "195"),
    Player(number: 1, name: "Cole Senior", grade: "Jr.", height: "5'10\"", weight: "160"),
    Player(number: 2, name: "Nico Inzana", grade: "So.", height: "6'2\"", weight: "188"),
    Player(number: 3, name: "Quentin Perrin", grade: "Jr.", height: "5'7\"", weight: "150"),
    Player(number: 4, name: "Ben Bash", grade: "Fr.", height: "6'2\"", weight: "178"),
    Player(number: 6, name: "Rylan Kuhar", grade: "Fr.", height: "5'10\"", weight: "170"),
    Player(number: 7, name: "Chase Little", grade: "Fr.", height: "5'9\"", weight: "150"),
    Player(number: 8, name: "Matthew Winnings", grade: "Jr.", height: "5'9\"", weight: "170"),
    Player(number: 9, name: "Collin Weir", grade: "Sr.", height: "5'11\"", weight: "173"),
    Player(number: 10, name: "Aiden Patton", grade: "Sr.", height: "6'3\"", weight: "212"),
    Player(number: 11, name: "Caleb Daugherty", grade: "Sr.", height: "6'1\"", weight: "195"),
    Player(number: 12, name: "Eli Miller", grade: "Fr.", height: "5'10\"", weight: "155"),
    Player(number: 13, name: "Brian Zameroski", grade: "Fr.", height: "5'7\"", weight: "140"),
    Player(number: 15, name: "Brady Ferraro", grade: "So.", height: "5'10\"", weight: "150"),
    Player(number: 17, name: "Kyle Kennedy", grade: "Sr.", height: "5'10\"", weight: "170"),
    Player(number: 22, name: "Cole Gooding", grade: "So.", height: "5'10\"", weight: "175"),
    Player(number: 30, name: "Dylan Colbey", grade: "Fr.", height: "5'5\"", weight: "135"),
    Player(number: 32, name: "Skyler Logan", grade: "Jr.", height: "5'9\"", weight: "175"),
    Player(number: 50, name: "Madox Decker", grade: "Sr.", height: "6'4\"", weight: "235"),
    Player(number: 51, name: "Cash Butters", grade: "Sr.", height: "5'10\"", weight: "215"),
    Player(number: 52, name: "Chase Wolfe", grade: "Jr.", height: "5'11\"", weight: "275"),
    Player(number: 53, name: "Liam Schwentner", grade: "Fr.", height: "6'2\"", weight: "185"),
    Player(number: 54, name: "Keagan Allaman", grade: "Fr.", height: "5'11\"", weight: "205"),
    Player(number: 55, name: "Blake Mowrey", grade: "Jr.", height: "6'4\"", weight: "259"),
    Player(number: 56, name: "Zayden Faith", grade: "Sr.", height: "6'1\"", weight: "195"),
    Player(number: 57, name: "Brock Yale", grade: "Fr.", height: "5'11\"", weight: "230"),
    Player(number: 58, name: "Xavier Schwentner", grade: "Sr.", height: "6'0\"", weight: "225"),
    Player(number: 59, name: "Marley Carlson", grade: "Fr.", height: "5'11\"", weight: nil),
    Player(number: 60, name: "Mario Berta", grade: "Fr.", height: "5'11\"", weight: "175"),
    Player(number: 61, name: "Noah Crawford", grade: "Fr.", height: "5'7\"", weight: "140"),
    Player(number: 63, name: "Logan Rakvin", grade: "Jr.", height: "5'10\"", weight: "220"),
    Player(number: 66, name: "Carter Reed", grade: "Fr.", height: "5'5\"", weight: "160"),
    Player(number: 71, name: "Peter O'Donnel", grade: "Fr.", height: "6'3\"", weight: "215"),
    Player(number: 77, name: "Lincoln Woods", grade: "Fr.", height: "6'0\"", weight: "170")
]

struct RosterView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    BundledImage(name: "team-hero", ext: "jpg")
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 210)
                        .clipped()
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.94)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    VStack(alignment: .leading, spacing: 3) {
                        Text("ROVERS ROSTER")
                            .font(.title2.weight(.black))
                        Text("2026 VARSITY • 34 PLAYERS")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(RoverTheme.muted)
                    }
                    .padding(18)
                }
                .frame(maxWidth: .infinity)

                ForEach(roverRoster) { player in
                    HStack(spacing: 14) {
                        PlayerAvatar(number: player.number)

                        VStack(alignment: .leading, spacing: 5) {
                            Text(player.name)
                                .font(.headline.weight(.bold))
                                .lineLimit(1)
                                .minimumScaleFactor(0.82)
                            HStack(spacing: 7) {
                                Text("#\(player.number)")
                                    .foregroundStyle(RoverTheme.red)
                                    .fontWeight(.black)
                                Text(player.grade)
                                Text(player.height)
                                Text(player.weight.map { "\($0) lbs" } ?? "—")
                            }
                            .font(.caption)
                            .foregroundStyle(RoverTheme.muted)
                        }
                        Spacer(minLength: 4)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)

                    Divider()
                        .overlay(Color.white.opacity(0.12))
                        .padding(.leading, 96)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 28)
        }
        .background(Color.black.ignoresSafeArea())
    }
}

struct NewsView: View {
    let featureURL = URL(string: "https://www.exploreclarion.com/sports/2026/08/25/more-than-the-sum-brockway-banking-on-collective-strength-in-return-to-class-a-872817/")!

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Link(destination: featureURL) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("FEATURED")
                                .font(.caption.weight(.black))
                                .foregroundStyle(RoverTheme.red)
                            Text("More Than the Sum: Brockway Banking on Collective Strength")
                                .font(.title3.weight(.black))
                                .foregroundStyle(.white)
                            Text("ExploreClarion  ↗")
                                .font(.subheadline)
                                .foregroundStyle(RoverTheme.muted)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .roverCard()
                    }

                    LiveButton()
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 28)
            }
            .navigationTitle("Rovers News")
            .background(Color.black.ignoresSafeArea())
        }
    }
}

struct MoreView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    LiveButton()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("BROCKWAY AREA HIGH SCHOOL")
                            .font(.headline.weight(.black))
                        Text("Rovers Football • District 9")
                            .foregroundStyle(RoverTheme.muted)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .roverCard()
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 28)
            }
            .navigationTitle("Brockway Rovers")
            .background(Color.black.ignoresSafeArea())
        }
    }
}
