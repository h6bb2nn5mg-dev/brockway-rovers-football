import SwiftUI
import WebKit

struct ContentView: View {
    private let liveURL = URL(string: "https://tricounty.tv/brockway-football-2025")!
    private let siteURL = URL(string: "https://brockway-rovers-football-qlzq150as-5gk6zvmwgc-1063.vercel.app")!
    private let storeURL = URL(string: "https://www.dansproshop.com/product-page/100-cotton-t-shirt-256")!

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 22) {
                    Link(destination: liveURL) {
                        HStack(spacing: 14) {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 38))
                            VStack(alignment: .leading, spacing: 3) {
                                Text("WATCH LIVE")
                                    .font(.title2.bold())
                                Text("Brockway Rovers Football")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding(18)
                        .foregroundStyle(.white)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
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

                    Link(destination: storeURL) {
                        HStack {
                            Image(systemName: "bag.fill")
                            Text("TEAM STORE")
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.gray.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Rovers Home")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                        RoverWebView(url: siteURL)
                            .frame(height: 560)
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
