import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack { HomeView() }
                .tabItem { Label("Home", systemImage: "house.fill") }

            NavigationStack { ScheduleView() }
                .tabItem { Label("Schedule", systemImage: "calendar") }

            NavigationStack { RosterView() }
                .tabItem { Label("Roster", systemImage: "person.3.fill") }

            NavigationStack { NewsView() }
                .tabItem { Label("News", systemImage: "newspaper.fill") }

            NavigationStack { MoreView() }
                .tabItem { Label("More", systemImage: "square.grid.2x2.fill") }
        }
        .tint(RoverTheme.red)
        .preferredColorScheme(.dark)
    }
}

enum RoverTheme {
    static let red = Color(red: 0.78, green: 0.02, blue: 0.05)
    static let card = Color.white.opacity(0.07)
    static let border = Color.white.opacity(0.12)
    static let muted = Color.white.opacity(0.62)
}

private let liveStreamURL = URL(string: "https://www.nfhsnetwork.com/schools/brockway-area-high-school-brockway-pa/football")!

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    Image("team-hero")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 285)
                        .clipped()

                    LinearGradient(
                        colors: [.black.opacity(0.05), .black.opacity(0.18), .black.opacity(0.96)],
                        startPoint: .top,
                        endPoint: .bottom
                    )

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 11) {
                            Image("rover-icon-source")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .background(Color.black.opacity(0.35))
                                .clipShape(Circle())

                            VStack(alignment: .leading, spacing: 1) {
                                Text("BROCKWAY")
                                    .font(.system(size: 30, weight: .black, design: .rounded))
                                Text("ROVERS FOOTBALL")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(RoverTheme.red)
                            }
                        }

                        Text("2026 SEASON")
                            .font(.caption.weight(.heavy))
                            .tracking(2.2)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    .padding(18)
                }
                .frame(height: 285)

                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("NEXT GAME")
                                .font(.caption.weight(.black))
                                .tracking(1.6)
                                .foregroundStyle(RoverTheme.red)
                            Spacer()
                            Text("FRI • SEPT 4")
                                .font(.caption.weight(.bold))
                                .foregroundStyle(RoverTheme.muted)
                        }

                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("BROCKWAY")
                                    .font(.title2.weight(.black))
                                Text("at DuBois")
                                    .font(.headline)
                                    .foregroundStyle(RoverTheme.muted)
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 3) {
                                Text("7:00 PM")
                                    .font(.title3.weight(.black))
                                Text("Away")
                                    .foregroundStyle(RoverTheme.red)
                            }
                        }

                        Link(destination: liveStreamURL) {
                            HStack {
                                Image(systemName: "play.rectangle.fill")
                                Text("WATCH LIVE")
                                    .font(.subheadline.weight(.black))
                                Spacer()
                                Image(systemName: "arrow.up.right")
                                    .font(.caption.weight(.bold))
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .frame(height: 48)
                            .background(RoverTheme.red)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                    }
                    .padding(18)
                    .background(RoverTheme.card)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(RoverTheme.border, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    HStack(spacing: 12) {
                        NavigationLink(destination: ScheduleView()) {
                            QuickAction(icon: "calendar", title: "Schedule")
                        }
                        NavigationLink(destination: RosterView()) {
                            QuickAction(icon: "person.3.fill", title: "Roster")
                        }
                        NavigationLink(destination: NewsView()) {
                            QuickAction(icon: "newspaper.fill", title: "News")
                        }
                    }
                    .buttonStyle(.plain)

                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("COMING UP")
                                .font(.headline.weight(.black))
                            Spacer()
                            NavigationLink("Full Schedule", destination: ScheduleView())
                                .font(.caption.weight(.bold))
                                .foregroundStyle(RoverTheme.red)
                        }

                        CompactGame(date: "SEP 4", opponent: "@ DuBois", time: "7:00 PM")
                        Divider().overlay(Color.white.opacity(0.12))
                        CompactGame(date: "SEP 11", opponent: "St. Marys", time: "7:00 PM")
                        Divider().overlay(Color.white.opacity(0.12))
                        CompactGame(date: "SEP 18", opponent: "Port Allegany", time: "7:00 PM")
                    }
                    .padding(18)
                    .background(RoverTheme.card)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(RoverTheme.border, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.horizontal, 18)
                .padding(.top, 16)
                .padding(.bottom, 120)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct QuickAction: View {
    let icon: String
    let title: String

    var body: some View {
        VStack(spacing: 9) {
            Image(systemName: icon)
                .font(.title2.weight(.bold))
                .foregroundStyle(RoverTheme.red)
            Text(title)
                .font(.caption.weight(.bold))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 88)
        .background(RoverTheme.card)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(RoverTheme.border, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

struct CompactGame: View {
    let date: String
    let opponent: String
    let time: String

    var body: some View {
        HStack(spacing: 12) {
            Text(date)
                .font(.caption.weight(.black))
                .foregroundStyle(RoverTheme.red)
                .frame(width: 56, alignment: .leading)
            Text(opponent)
                .font(.subheadline.weight(.bold))
            Spacer()
            Text(time)
                .font(.caption.weight(.semibold))
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
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(roverSchedule) { game in
                    HStack(spacing: 14) {
                        Text(game.date)
                            .font(.caption.weight(.black))
                            .foregroundStyle(RoverTheme.red)
                            .frame(width: 62, alignment: .leading)

                        VStack(alignment: .leading, spacing: 3) {
                            Text(game.opponent)
                                .font(.headline)
                            Text(game.location)
                                .font(.caption)
                                .foregroundStyle(RoverTheme.muted)
                        }

                        Spacer()

                        Text(game.time)
                            .font(.subheadline.weight(.bold))
                    }
                    .padding(16)
                    .background(RoverTheme.card)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(RoverTheme.border, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding(.horizontal, 18)
            .padding(.top, 8)
            .padding(.bottom, 120)
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("2026 Schedule")
        .navigationBarTitleDisplayMode(.inline)
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
                    Image("team-hero")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 205)
                        .clipped()

                    LinearGradient(
                        colors: [.clear, .black.opacity(0.9)],
                        startPoint: .top,
                        endPoint: .bottom
                    )

                    VStack(alignment: .leading, spacing: 3) {
                        Text("ROVERS ROSTER")
                            .font(.title2.weight(.black))
                        Text("2026 VARSITY • 34 PLAYERS")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(RoverTheme.muted)
                    }
                    .padding(18)
                }

                LazyVStack(spacing: 0) {
                    ForEach(roverRoster) { player in
                        HStack(spacing: 14) {
                            ZStack {
                                Circle().fill(RoverTheme.red)
                                Text("\(player.number)")
                                    .font(.headline.weight(.black))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 52, height: 52)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(player.name)
                                    .font(.headline.weight(.bold))
                                Text("\(player.grade)  •  \(player.height)  •  \(player.weight.map { $0 + " lbs" } ?? "—")")
                                    .font(.caption)
                                    .foregroundStyle(RoverTheme.muted)
                            }

                            Spacer()
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 13)

                        Divider()
                            .overlay(Color.white.opacity(0.11))
                            .padding(.leading, 84)
                    }
                }
                .padding(.bottom, 120)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct NewsView: View {
    let featureURL = URL(string: "https://www.exploreclarion.com/sports/2026/08/25/more-than-the-sum-brockway-banking-on-collective-strength-in-return-to-class-a-872817/")!

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("Latest from Rover Football")
                    .font(.title2.weight(.black))

                Link(destination: featureURL) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("FEATURED")
                            .font(.caption.weight(.black))
                            .foregroundStyle(RoverTheme.red)
                        Text("More Than the Sum: Brockway Banking on Collective Strength")
                            .font(.title3.weight(.black))
                            .foregroundStyle(.white)
                        Text("ExploreClarion  ↗")
                            .foregroundStyle(RoverTheme.muted)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(RoverTheme.card)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(RoverTheme.border, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }

                Link(destination: liveStreamURL) {
                    HStack(spacing: 12) {
                        Image(systemName: "play.rectangle.fill")
                            .font(.title2)
                            .foregroundStyle(RoverTheme.red)
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Rovers Live & On Demand")
                                .font(.headline.weight(.bold))
                                .foregroundStyle(.white)
                            Text("Open the Brockway football stream page")
                                .font(.caption)
                                .foregroundStyle(RoverTheme.muted)
                        }
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .foregroundStyle(.white)
                    }
                    .padding(18)
                    .background(RoverTheme.card)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(RoverTheme.border, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding(18)
            .padding(.bottom, 120)
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("News")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MoreView: View {
    var body: some View {
        List {
            Section("Rovers") {
                NavigationLink(destination: ScheduleView()) {
                    Label("Schedule", systemImage: "calendar")
                }
                NavigationLink(destination: RosterView()) {
                    Label("Roster", systemImage: "person.3.fill")
                }
                NavigationLink(destination: NewsView()) {
                    Label("News", systemImage: "newspaper.fill")
                }
            }

            Section("Live & Media") {
                Link(destination: liveStreamURL) {
                    Label("Watch Rovers Live", systemImage: "play.rectangle.fill")
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .navigationTitle("Brockway Rovers")
        .navigationBarTitleDisplayMode(.inline)
    }
}
