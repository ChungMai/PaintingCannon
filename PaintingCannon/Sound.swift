import AVFoundation

class Sound {
    
    var audioPlayer = AVAudioPlayer()
    
    init(_ fileName: String) {
        let soundURL = Bundle.main.url(forResource: fileName, withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: soundURL!)
    }
    
    var looping: Bool {
        get {
            return audioPlayer.numberOfLoops < 0
        }
        set {
            if newValue {
                audioPlayer.numberOfLoops = -1
            } else {
                audioPlayer.numberOfLoops = 0
            }
        }
    }
    
    var volume: Float {
        get {
            return audioPlayer.volume
        }
        set {
            audioPlayer.volume = newValue
        }
    }
    
    func play() {
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    func stop() {
        audioPlayer.pause()
    }
}
