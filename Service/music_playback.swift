import SpotifyiOS

public class SpotifyManager: NSObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    private let clientID = "391a27fc849343d3914d6b04aa0fff41" // Replace with your Client ID
    private let redirectURI = URL(string: "https://art_words.org/callback")! // Replace with your Redirect URI
    
    private var appRemote: SPTAppRemote!
    private var configuration: SPTConfiguration!
    
    private var musicUrl: String
    
    public init(musicUrl: String) {
        self.musicUrl = musicUrl
        super.init()
        // Initialize the configuration
        configuration = SPTConfiguration(clientID: clientID, redirectURL: redirectURI)
        configuration.playURI = musicUrl // Replace with your Spotify URI
        
        // Initialize the app remote
        appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
    }
    
    public func updateMusicUrl(newMusicUrl: String) {
        self.musicUrl = newMusicUrl
        configuration.playURI = newMusicUrl
    }
    		
    public func connect() {
        appRemote.connect()
    }

    public func disconnect() {
        appRemote.disconnect()
    }
    
//    public func play(spotifyURI: String) {
    public func play() {
        guard appRemote.isConnected else {
            print("Spotify is not connected")
            return
        }
        
        appRemote.playerAPI?.play(musicUrl, callback: { (result, error) in
            if let error = error {
                print("Error playing: \(error.localizedDescription)")
            } else {
                print("Playback started!")
            }
        })
    }
    
    // MARK: - SPTAppRemoteDelegate Methods
    
    public func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("Spotify connected!")
        appRemote.playerAPI?.delegate = self
        
        // Start playback using the playURI from the configuration
        if let playURI = configuration.playURI {
            appRemote.playerAPI?.play(playURI, callback: { (result, error) in
                if let error = error {
                    print("Error playing: \(error.localizedDescription)")
                } else {
                    print("Playback started!")
                }
            })
        }
    }
    
    public func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("Failed to connect: \(String(describing: error?.localizedDescription))")
    }
    
    public func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("Disconnected: \(String(describing: error?.localizedDescription))")
    }
    
    // MARK: - SPTAppRemotePlayerStateDelegate Method
    
    public func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("Player state changed: \(playerState)")
    }
}
