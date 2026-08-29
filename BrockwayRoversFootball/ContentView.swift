import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack { HomeView() }.tabItem { Label("Home", systemImage: "house.fill") }
            NavigationStack { ScheduleView() }.tabItem { Label("Schedule", systemImage: "calendar") }
            NavigationStack { RosterView() }.tabItem { Label("Roster", systemImage: "person.3.fill") }
            NavigationStack { NewsView() }.tabItem { Label("News", systemImage: "newspaper.fill") }
            NavigationStack { MoreView() }.tabItem { Label("More", systemImage: "square.grid.2x2.fill") }
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
                ZStack(alignment: .bottomLeading) {
                    Image("team-hero").resizable().scaledToFill().frame(height: 330).clipped()
                    LinearGradient(colors: [.clear, .black.opacity(0.2), .black.opacity(0.95)], startPoint: .top, endPoint: .bottom)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 10) {
                            Image("rover-icon-source").resizable().scaledToFit().frame(width: 50, height: 50).clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("BROCKWAY").font(.system(size: 28, weight: .black, design: .rounded))
                                Text("ROVERS FOOTBALL").font(.system(size: 15, weight: .bold, design: .rounded)).foregroundStyle(RoverTheme.red)
                            }
                        }
                        Text("2026 SEASON").font(.caption.weight(.heavy)).tracking(2.2).foregroundStyle(.white.opacity(0.75))
                    }.padding(18)
                }.frame(height: 330)

                VStack(spacing: 18) {
                    VStack(alignment: .leading, spacing: 13) {
                        HStack { Text("NEXT GAME").font(.caption.weight(.black)).tracking(1.6).foregroundStyle(RoverTheme.red); Spacer(); Text("FRI • SEPT 4").font(.caption.weight(.bold)).foregroundStyle(.secondary) }
                        HStack { VStack(alignment: .leading) { Text("BROCKWAY").font(.title2.weight(.black)); Text("at DuBois").font(.headline).foregroundStyle(.secondary) }; Spacer(); VStack(alignment: .trailing) { Text("7:00 PM").font(.title3.weight(.black)); Text("Away").foregroundStyle(RoverTheme.red) } }
                    }.padding(18).background(RoverTheme.card).clipShape(RoundedRectangle(cornerRadius: 20))
                    HStack(spacing: 12) {
                        NavigationLink(destination: ScheduleView()) { QuickAction(icon: "calendar", title: "Schedule") }
                        NavigationLink(destination: RosterView()) { QuickAction(icon: "person.3.fill", title: "Roster") }
                        NavigationLink(destination: NewsView()) { QuickAction(icon: "newspaper.fill", title: "News") }
                    }.buttonStyle(.plain)
                    VStack(alignment: .leading, spacing: 13) {
                        Text("COMING UP").font(.headline.weight(.black))
                        CompactGame(date: "SEP 4", opponent: "@ DuBois", time: "7:00 PM")
                        CompactGame(date: "SEP 11", opponent: "St. Marys", time: "7:30 PM")
                        CompactGame(date: "SEP 18", opponent: "Port Allegany", time: "7:30 PM")
                    }.padding(18).background(RoverTheme.card).clipShape(RoundedRectangle(cornerRadius: 20))
                }.padding(18)
            }
        }.background(Color.black.ignoresSafeArea()).toolbar(.hidden, for: .navigationBar)
    }
}

struct QuickAction: View { let icon: String; let title: String; var body: some View { VStack(spacing: 10) { Image(systemName: icon).font(.title2.weight(.bold)).foregroundStyle(RoverTheme.red); Text(title).font(.caption.weight(.bold)).foregroundStyle(.white) }.frame(maxWidth: .infinity).frame(height: 90).background(RoverTheme.card).clipShape(RoundedRectangle(cornerRadius: 18)) } }
struct CompactGame: View { let date: String; let opponent: String; let time: String; var body: some View { HStack { Text(date).font(.caption.weight(.black)).foregroundStyle(RoverTheme.red).frame(width: 54, alignment: .leading); Text(opponent).font(.subheadline.weight(.bold)); Spacer(); Text(time).font(.caption.weight(.semibold)).foregroundStyle(.secondary) } } }

struct Game: Identifiable { let id = UUID(); let date: String; let opponent: String; let location: String; let time: String }
let roverSchedule = [
    Game(date:"AUG 28",opponent:"Keystone",location:"Away",time:"7:00 PM"), Game(date:"SEP 4",opponent:"DuBois",location:"Away",time:"7:00 PM"), Game(date:"SEP 11",opponent:"St. Marys",location:"Home",time:"7:30 PM"), Game(date:"SEP 18",opponent:"Port Allegany",location:"Home",time:"7:30 PM"), Game(date:"SEP 25",opponent:"Redbank",location:"Away",time:"7:00 PM"), Game(date:"OCT 2",opponent:"Brookville",location:"Home",time:"7:30 PM"), Game(date:"OCT 9",opponent:"Punxsutawney",location:"Away",time:"7:00 PM"), Game(date:"OCT 16",opponent:"Cameron County",location:"Home",time:"7:00 PM"), Game(date:"OCT 23",opponent:"Bradford",location:"Away",time:"7:00 PM"), Game(date:"OCT 30",opponent:"Maplewood",location:"Home",time:"7:00 PM")
]
struct ScheduleView: View { var body: some View { List(roverSchedule) { game in HStack { Text(game.date).font(.caption.weight(.black)).foregroundStyle(RoverTheme.red).frame(width:70); VStack(alignment:.leading){Text(game.opponent).font(.headline);Text(game.location).font(.caption).foregroundStyle(.secondary)}; Spacer(); Text(game.time).font(.subheadline.weight(.bold)) }.padding(.vertical,7).listRowBackground(Color.black) }.scrollContentBackground(.hidden).background(Color.black).navigationTitle("2026 Schedule") } }

struct Player: Identifiable { let id = UUID(); let number: Int; let name: String; let grade: String; let height: String; let weight: String? }
let roverRoster: [Player] = [
    Player(number:0,name:"Kolton Kahle",grade:"Sr.",height:"6'3\"",weight:"195"),
    Player(number:1,name:"Cole Senior",grade:"Jr.",height:"5'10\"",weight:"160"),
    Player(number:2,name:"Nico Inzana",grade:"So.",height:"6'2\"",weight:"188"),
    Player(number:3,name:"Quentin Perrin",grade:"Jr.",height:"5'7\"",weight:"150"),
    Player(number:4,name:"Ben Bash",grade:"Fr.",height:"6'2\"",weight:"178"),
    Player(number:6,name:"Rylan Kuhar",grade:"Fr.",height:"5'10\"",weight:"170"),
    Player(number:7,name:"Chase Little",grade:"Fr.",height:"5'9\"",weight:"150"),
    Player(number:8,name:"Matthew Winnings",grade:"Jr.",height:"5'9\"",weight:"170"),
    Player(number:9,name:"Collin Weir",grade:"Sr.",height:"5'11\"",weight:"173"),
    Player(number:10,name:"Aiden Patton",grade:"Sr.",height:"6'3\"",weight:"212"),
    Player(number:11,name:"Caleb Daugherty",grade:"Sr.",height:"6'1\"",weight:"195"),
    Player(number:12,name:"Eli Miller",grade:"Fr.",height:"5'10\"",weight:"155"),
    Player(number:13,name:"Brian Zameroski",grade:"Fr.",height:"5'7\"",weight:"140"),
    Player(number:15,name:"Brady Ferraro",grade:"So.",height:"5'10\"",weight:"150"),
    Player(number:17,name:"Kyle Kennedy",grade:"Sr.",height:"5'10\"",weight:"170"),
    Player(number:22,name:"Cole Gooding",grade:"So.",height:"5'10\"",weight:"175"),
    Player(number:30,name:"Dylan Colbey",grade:"Fr.",height:"5'5\"",weight:"135"),
    Player(number:32,name:"Skyler Logan",grade:"Jr.",height:"5'9\"",weight:"175"),
    Player(number:50,name:"Madox Decker",grade:"Sr.",height:"6'4\"",weight:"235"),
    Player(number:51,name:"Cash Butters",grade:"Sr.",height:"5'10\"",weight:"215"),
    Player(number:52,name:"Chase Wolfe",grade:"Jr.",height:"5'11\"",weight:"275"),
    Player(number:53,name:"Liam Schwentner",grade:"Fr.",height:"6'2\"",weight:"185"),
    Player(number:54,name:"Keagan Allaman",grade:"Fr.",height:"5'11\"",weight:"205"),
    Player(number:55,name:"Blake Mowrey",grade:"Jr.",height:"6'4\"",weight:"259"),
    Player(number:56,name:"Zayden Faith",grade:"Sr.",height:"6'1\"",weight:"195"),
    Player(number:57,name:"Brock Yale",grade:"Fr.",height:"5'11\"",weight:"230"),
    Player(number:58,name:"Xavier Schwentner",grade:"Sr.",height:"6'0\"",weight:"225"),
    Player(number:59,name:"Marley Carlson",grade:"Fr.",height:"5'11\"",weight:nil),
    Player(number:60,name:"Mario Berta",grade:"Fr.",height:"5'11\"",weight:"175"),
    Player(number:61,name:"Noah Crawford",grade:"Fr.",height:"5'7\"",weight:"140"),
    Player(number:63,name:"Logan Rakvin",grade:"Jr.",height:"5'10\"",weight:"220"),
    Player(number:66,name:"Carter Reed",grade:"Fr.",height:"5'5\"",weight:"160"),
    Player(number:71,name:"Peter O'Donnel",grade:"Fr.",height:"6'3\"",weight:"215"),
    Player(number:77,name:"Lincoln Woods",grade:"Fr.",height:"6'0\"",weight:"170")
]

struct RosterView: View {
    var body: some View {
        List {
            Section {
                Image("team-hero").resizable().scaledToFill().frame(height:190).clipped().listRowInsets(EdgeInsets()).listRowBackground(Color.black)
            }
            Section("2026 VARSITY • 34 PLAYERS") {
                ForEach(roverRoster) { player in
                    HStack(spacing:14) {
                        ZStack { Circle().fill(RoverTheme.red); Text("\(player.number)").font(.headline.weight(.black)).foregroundStyle(.white) }.frame(width:46,height:46)
                        VStack(alignment:.leading,spacing:4) { Text(player.name).font(.headline.weight(.bold)); Text("\(player.grade)  •  \(player.height)  •  \(player.weight.map { $0 + " lbs" } ?? "—")").font(.caption).foregroundStyle(.secondary) }
                        Spacer()
                    }.padding(.vertical,5).listRowBackground(Color.black)
                }
            }
        }.scrollContentBackground(.hidden).background(Color.black).navigationTitle("Rovers Roster")
    }
}

struct NewsView: View {
    let featureURL = URL(string:"https://www.exploreclarion.com/sports/2026/08/25/more-than-the-sum-brockway-banking-on-collective-strength-in-return-to-class-a-872817/")!
    var body: some View { ScrollView { VStack(alignment:.leading,spacing:18) { Text("Latest from Rover Football").font(.title2.weight(.black)); Link(destination:featureURL) { VStack(alignment:.leading,spacing:10){Text("FEATURED").font(.caption.weight(.black)).foregroundStyle(RoverTheme.red);Text("More Than the Sum: Brockway Banking on Collective Strength").font(.title3.weight(.black)).foregroundStyle(.white);Text("ExploreClarion  ↗").foregroundStyle(.secondary)}.padding(20).background(RoverTheme.card).clipShape(RoundedRectangle(cornerRadius:20)) } }.padding(18) }.background(Color.black).navigationTitle("News") }
}
struct MoreView: View { var body: some View { List { Section("Rovers") { NavigationLink(destination:ScheduleView()){Label("Schedule",systemImage:"calendar")};NavigationLink(destination:RosterView()){Label("Roster",systemImage:"person.3.fill")};NavigationLink(destination:NewsView()){Label("News",systemImage:"newspaper.fill")} }; Section("Coming Next") { Label("Live & Media",systemImage:"play.rectangle.fill");Label("Team Store",systemImage:"bag.fill") } }.scrollContentBackground(.hidden).background(Color.black).navigationTitle("Brockway Rovers") } }
