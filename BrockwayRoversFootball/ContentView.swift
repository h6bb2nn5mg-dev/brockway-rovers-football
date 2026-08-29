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
}

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                hero

                VStack(spacing: 18) {
                    nextGame
                    quickActions
                    schedulePreview
                    traditionCard
                }
                .padding(.horizontal, 18)
                .padding(.top, 18)
                .padding(.bottom, 34)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            Image("team-hero")
                .resizable()
                .scaledToFill()
                .frame(height: 330)
                .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.2), .black.opacity(0.95)],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 10) {
                    Image("rover-icon-source")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white.opacity(0.35), lineWidth: 1))

                    VStack(alignment: .leading, spacing: 0) {
                        Text("BROCKWAY")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                        Text("ROVERS FOOTBALL")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(RoverTheme.red)
                    }
                }

                Text("2026 SEASON")
                    .font(.caption.weight(.heavy))
                    .tracking(2.2)
                    .foregroundStyle(.white.opacity(0.75))
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 20)
        }
        .frame(height: 330)
    }

    private var nextGame: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack {
                Text("NEXT GAME")
                    .font(.caption.weight(.black))
                    .tracking(1.6)
                    .foregroundStyle(RoverTheme.red)
                Spacer()
                Text("FRI • SEPT 4")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
            }

            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("BROCKWAY")
                        .font(.title2.weight(.black))
                    Text("at DuBois")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("7:00 PM")
                        .font(.title3.weight(.black))
                    Text("Away")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(RoverTheme.red)
                }
            }
        }
        .padding(18)
        .background(RoverTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(RoverTheme.border, lineWidth: 1))
    }

    private var quickActions: some View {
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
    }

    private var schedulePreview: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack {
                Text("COMING UP")
                    .font(.headline.weight(.black))
                Spacer()
                NavigationLink("Full Schedule") { ScheduleView() }
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(RoverTheme.red)
            }

            CompactGame(date: "SEP 4", opponent: "@ DuBois", time: "7:00 PM")
            Divider().overlay(Color.white.opacity(0.12))
            CompactGame(date: "SEP 11", opponent: "St. Marys", time: "7:30 PM")
            Divider().overlay(Color.white.opacity(0.12))
            CompactGame(date: "SEP 18", opponent: "Port Allegany", time: "7:30 PM")
        }
        .padding(18)
        .background(RoverTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var traditionCard: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(RoverTheme.red)
            VStack(alignment: .leading, spacing: 7) {
                Text("ROVER PRIDE")
                    .font(.title2.weight(.black))
                Text("Brockway football. Built on tradition, toughness and team.")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(20)
        }
    }
}

struct QuickAction: View {
    let icon: String
    let title: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2.weight(.bold))
                .foregroundStyle(RoverTheme.red)
            Text(title)
                .font(.caption.weight(.bold))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .background(RoverTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(RoverTheme.border, lineWidth: 1))
    }
}

struct CompactGame: View {
    let date: String
    let opponent: String
    let time: String

    var body: some View {
        HStack {
            Text(date)
                .font(.caption.weight(.black))
                .foregroundStyle(RoverTheme.red)
                .frame(width: 54, alignment: .leading)
            Text(opponent)
                .font(.subheadline.weight(.bold))
            Spacer()
            Text(time)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
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

let roverSchedule: [Game] = [
    Game(date: "AUG 28", opponent: "Keystone", location: "Away", time: "7:00 PM"),
    Game(date: "SEP 4", opponent: "DuBois", location: "Away", time: "7:00 PM"),
    Game(date: "SEP 11", opponent: "St. Marys", location: "Home", time: "7:30 PM"),
    Game(date: "SEP 18", opponent: "Port Allegany", location: "Home", time: "7:30 PM"),
    Game(date: "SEP 25", opponent: "Redbank", location: "Away", time: "7:00 PM"),
    Game(date: "OCT 2", opponent: "Brookville", location: "Home", time: "7:30 PM"),
    Game(date: "OCT 9", opponent: "Punxsutawney", location: "Away", time: "7:00 PM"),
    Game(date: "OCT 16", opponent: "Cameron County", location: "Home", time: "7:00 PM"),
    Game(date: "OCT 23", opponent: "Bradford", location: "Away", time: "7:00 PM"),
    Game(date: "OCT 30", opponent: "Maplewood", location: "Home", time: "7:00 PM")
]

struct ScheduleView: View {
    var body: some View {
        List {
            ForEach(roverSchedule) { game in
                HStack(spacing: 14) {
                    VStack(spacing: 2) {
                        Text(game.date.components(separatedBy: " ").first ?? "")
                            .font(.caption2.weight(.black))
                            .foregroundStyle(RoverTheme.red)
                        Text(game.date.components(separatedBy: " ").last ?? "")
                            .font(.title3.weight(.black))
                    }
                    .frame(width: 58)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(game.opponent)
                            .font(.headline.weight(.bold))
                        Text(game.location)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(game.location == "Home" ? RoverTheme.red : .secondary)
                    }

                    Spacer()
                    Text(game.time)
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 7)
                .listRowBackground(Color.black)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .navigationTitle("2026 Schedule")
    }
}

struct RosterView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                Image("team-hero")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                VStack(spacing: 10) {
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(RoverTheme.red)
                    Text("2026 Rovers Roster")
                        .font(.title2.weight(.black))
                    Text("Player profiles are being added next so the roster is accurate down to jersey number, height and weight.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
                .padding(22)
                .frame(maxWidth: .infinity)
                .background(RoverTheme.card)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .padding(18)
        }
        .background(Color.black)
        .navigationTitle("Roster")
    }
}

struct NewsView: View {
    private let featureURL = URL(string: "https://www.exploreclarion.com/sports/2026/08/25/more-than-the-sum-brockway-banking-on-collective-strength-in-return-to-class-a-872817/")!

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("Latest from Rover Football")
                    .font(.title2.weight(.black))

                Link(destination: featureURL) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("FEATURED")
                            .font(.caption.weight(.black))
                            .tracking(1.4)
                            .foregroundStyle(RoverTheme.red)
                        Text("More Than the Sum: Brockway Banking on Collective Strength")
                            .font(.title3.weight(.black))
                            .foregroundStyle(.white)
                        HStack {
                            Text("ExploreClarion")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                        }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                    }
                    .padding(20)
                    .background(RoverTheme.card)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
                .buttonStyle(.plain)
            }
            .padding(18)
        }
        .background(Color.black)
        .navigationTitle("News")
    }
}

struct MoreView: View {
    var body: some View {
        List {
            Section("Rovers") {
                NavigationLink(destination: ScheduleView()) { Label("Schedule", systemImage: "calendar") }
                NavigationLink(destination: RosterView()) { Label("Roster", systemImage: "person.3.fill") }
                NavigationLink(destination: NewsView()) { Label("News", systemImage: "newspaper.fill") }
            }

            Section("Coming Next") {
                Label("Live & Media", systemImage: "play.rectangle.fill")
                Label("Team Store", systemImage: "bag.fill")
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .navigationTitle("Brockway Rovers")
    }
}
