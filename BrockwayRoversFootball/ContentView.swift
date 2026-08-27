import SwiftUI
import WebKit

struct ContentView: View {
    private let siteURL = URL(string: "https://brockway-rovers-football-qlzq150as-5gk6zvmwgc-1063.vercel.app")!
    private let storeURL = URL(string: "https://www.dansproshop.com/product-page/100-cotton-t-shirt-256")!
    private let newsURL = URL(string: "https://www.connectradio.fm/news/brockway-school-board-approves-ben-donlin-as-next-superintendent/")!
    private let archiveURL = URL(string: "https://tricounty.tv/brockway-football-2025")!

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 22) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "dot.radiowaves.left.and.right")
                            Text("WATCH LIVE")
                                .font(.title2.bold())
                            Spacer()
                            Text("ROVERS")
                                .font(.caption.bold())
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.white.opacity(0.14))
                                .clipShape(Capsule())
                        }
                        .foregroundStyle(.white)

                        MediaCDNPlayer()
                            .frame(height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 16))

                        Link("View broadcast archive", destination: archiveURL)
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                    }
                    .padding(16)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 18))

                    HStack(spacing: 12) {
                        HomeLink(title: "TEAM STORE", systemImage: "bag.fill", destination: storeURL)
                        HomeLink(title: "NEWS", systemImage: "newspaper.fill", destination: newsURL)
                    }

                    VStack(alignment: .leading, spacing: 14) {
                        Text("Rover History")
                            .font(.title.bold())
                            .foregroundStyle(.white)

                        YouTubePlayer(videoID: "bWv_kVXIlmc")
                            .frame(height: 210)
                            .clipShape(RoundedRectangle(cornerRadius: 14))

                        YouTubePlayer(videoID: "lQGdEa0o3Sg")
                            .frame(height: 210)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Rovers Home")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                        RoverWebView(url: siteURL)
                            .frame(height: 600)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
                .padding()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Brockway Rovers")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

struct HomeLink: View {
    let title: String
    let systemImage: String
    let destination: URL

    var body: some View {
        Link(destination: destination) {
            VStack(spacing: 10) {
                Image(systemName: systemImage)
                    .font(.title2)
                Text(title)
                    .font(.subheadline.bold())
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, minHeight: 88)
            .foregroundStyle(.white)
            .background(Color.white.opacity(0.10))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

struct MediaCDNPlayer: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .black
        webView.isOpaque = false

        let html = """
        <!doctype html>
        <html>
        <head>
          <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0'>
          <style>
            html,body{margin:0;padding:0;background:#000;height:100%;overflow:hidden;}
            iframe{position:absolute;top:0;left:0;width:100%;height:100%;border:0;}
          </style>
        </head>
        <body>
          <iframe src='https://c.themediacdn.com/embed/media/W8s3JF/iINcoCPsYZL/mcJ9iksp2xE_5' scrolling='no' allow='autoplay; fullscreen' allowfullscreen></iframe>
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: URL(string: "https://c.themediacdn.com"))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}
}

struct YouTubePlayer: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .black
        webView.isOpaque = false

        let html = """
        <!doctype html>
        <html>
        <head>
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0'>
        <style>
        html,body{margin:0;padding:0;background:#000;height:100%;overflow:hidden;}
        iframe{position:absolute;top:0;left:0;width:100%;height:100%;border:0;}
        </style>
        </head>
        <body>
        <iframe src='https://www.youtube.com/embed/\(videoID)?playsinline=1&rel=0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' allowfullscreen></iframe>
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube.com"))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}
}

struct RoverWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.contentInsetAdjustmentBehavior = .automatic
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}
}
