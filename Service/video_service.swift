////
////  video_service.swift
////  art_words_v1.0
////
////  Created by TopDev on 15/2/2025.
////
//
//import SwiftUI
//import AVFoundation
//import Photos
//import Foundation
//
//class VideoService: ObservableObject {
//    @Published var progressMessage: String = ""
//    private var generatingVideoText: String = ""
//
//    func prepareRecording(videoSettings: VideoSettings) -> String {
//        generatingVideoText = videoSettings.generatingVideoText
//
//        let videoMargins = getAnimMargins(
//            backgroundWidth: videoSettings.backgroundWidth,
//            videoLayoutHeight: videoSettings.videoLayoutHeight,
//            mainLayoutWidth: videoSettings.mainLayoutWidth,
//            videoLayoutPaddingTop: videoSettings.videoLayoutPaddingTop
//        )
//
//        let videoScale = getVideoScale(
//            videoMargins: videoMargins,
//            backgroundHeight: videoSettings.backgroundHeight,
//            videoLayoutHeight: videoSettings.videoLayoutHeight
//        )
//
//        let videoTime = calculateVideoTime(
//            typewriterOn: videoSettings.typewriterOn,
//            typewriterTime: videoSettings.typewriterTime,
//            audioDuration: AppSettings.props.videoSettings.audioDuration
//        )
//
//        let ffmpegCommands = generateFFMpegCommands(
//            typewriterOn: videoSettings.typewriterOn,
//            outputPath: videoSettings.outputPath,
//            outputFilename: videoSettings.outputFilename,
//            videoAnim: videoSettings.videoAnim,
//            videoWithAudio: videoSettings.videoWithAudio,
//            videoScale: videoScale,
//            videoMargins: videoMargins,
//            videoTime: videoTime
//        )
//
//        return ffmpegCommands.joined(separator: " ")
//    }
//
//    private func calculateVideoTime(typewriterOn: Bool, typewriterTime: TimeInterval, audioDuration: TimeInterval) -> String {
//        if typewriterOn && typewriterTime > audioDuration {
//            return String(typewriterTime + AppSettings.props.videoSettings.typewriterTimeCompensation)
//        } else {
//            return String(audioDuration)
//        }
//    }
//
//    private func getAnimMargins(backgroundWidth: Int, videoLayoutHeight: Int, mainLayoutWidth: Int, videoLayoutPaddingTop: Int) -> [Int] {
//        let marginX = (mainLayoutWidth - backgroundWidth) / 2
//        let marginX720 = AppSettings.props.videoSettings.scaleX * marginX / mainLayoutWidth
//        let marginY1280 = AppSettings.props.videoSettings.scaleY * videoLayoutPaddingTop / videoLayoutHeight + 1
//        return [marginX720, marginY1280]
//    }
//
//    private func getVideoScale(videoMargins: [Int], backgroundHeight: Int, videoLayoutHeight: Int) -> [Int] {
//        let scaleX = AppSettings.props.videoSettings.scaleX - 2 * videoMargins[0] - 1
//        let scaleY1280 = AppSettings.props.videoSettings.scaleY * backgroundHeight / videoLayoutHeight
//        return [scaleX, scaleY1280]
//    }
//
//    private func generateFFMpegCommands(typewriterOn: Bool, outputPath: String, outputFilename: String, videoAnim: String?, videoWithAudio: Bool, videoScale: [Int], videoMargins: [Int], videoTime: String) -> [String] {
//        var commands: [String] = []
//        commands.append("-y")
//        commands.append("-r \(AppSettings.props.videoSettings.frameRate)")
//        if !videoWithAudio {
//            commands.append("-loop \(AppSettings.props.videoSettings.loop)")
//        }
//        commands.append("-i \(outputPath)/\(outputFilename)\(typewriterOn ? "_%04d" : "").jpg")
//        if let videoAnim = videoAnim {
//            commands.append("-i \(outputPath)/\(videoAnim).gif")
//        }
//        if videoWithAudio {
//            commands.append("-i \(outputPath)/\(outputFilename).mp3")
//            commands.append("-af \(AppSettings.props.videoSettings.audioFade)")
//            commands.append("-codec:a aac")
//        }
//        commands.append("-filter_complex \"\(String(format: AppSettings.props.videoSettings.filterComplex, videoScale[0], videoScale[1], videoMargins[0], videoMargins[1]))\"")
//        commands.append("-t 00:00:\(videoTime)")
//        commands.append("-codec:v \(AppSettings.props.videoSettings.videoCodec)")
//        commands.append("-preset \(AppSettings.props.videoSettings.preset)")
//        commands.append("-crf 24")
//        commands.append("\(outputPath)/\(outputFilename).mp4")
//        return commands
//    }
//
//    func recordVideo(commands: String) {
//        let ffmpegCommand = "ffmpeg \(commands)"
//        DispatchQueue.global().async {
//            let process = Process()
//            process.launchPath = "/usr/bin/env"
//            process.arguments = ["sh", "-c", ffmpegCommand]
//            let pipe = Pipe()
//            process.standardOutput = pipe
//            process.launch()
//            process.waitUntilExit()
//
//            DispatchQueue.main.async {
//                if process.terminationStatus == 0 {
//                    self.videoGenerationFinished()
//                } else {
//                    print("FFmpeg video generation failed with exit code \(process.terminationStatus)")
//                }
//            }
//        }
//    }
//
//    private func updateProgressDialog(timeInMilliseconds: Int64, videoTime: Int64, dialogMessage: String) {
//        let completePercentage = min(Int((timeInMilliseconds * 100) / videoTime), 100)
//        let strCompletePercentage = "\(completePercentage)%"
//        updateProgressDialog(message: "\(dialogMessage) (\(strCompletePercentage))")
//    }
//
//    private func updateProgressDialog(message: String) {
//        DispatchQueue.main.async {
//            self.progressMessage = message
//        }
//    }
//
//    private func videoGenerationFinished() {
//        DispatchQueue.main.async {
//            self.progressMessage = "Video generation finished"
//        }
//    }
//}
//
//struct VideoSettings {
//    var generatingVideoText: String
//    var backgroundWidth: Int
//    var backgroundHeight: Int
//    var videoLayoutHeight: Int
//    var mainLayoutWidth: Int
//    var videoLayoutPaddingTop: Int
//    var typewriterOn: Bool
//    var typewriterTime: TimeInterval
//    var outputPath: String
//    var outputFilename: String
//    var videoAnim: String?
//    var videoWithAudio: Bool
//}
//
//struct AppSettings {
//    struct props {
//        struct videoSettings {
//            static let frameRate = "30"
//            static let loop = "1"
//            static let ignoreLoop = "0"
//            static let audioFade = "afade=t=out:st=30:d=3"
//            static let scaleX = 720
//            static let scaleY = 1280
//            static let filterComplex = "[0]scale=%d:%d[ovrl0],[1]scale=%d:%d[ovrl1],[ovrl0][ovrl1]overlay"
//            static let videoCodec = "libx264"
//            static let preset = "fast"
//            static let audioDuration: TimeInterval = 60
//            static let typewriterTimeCompensation: TimeInterval = 2
//        }
//    }
//}
