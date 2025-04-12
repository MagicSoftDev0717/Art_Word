////
////  VideoService.swift
////  art_words_v1.0
////
////  Created by TopDev on 15/2/2025.
////
//
//import UIKit
//import AVFoundation
//
//public class ViewController: UIViewController {
//    var images: [UIImage] = []
//    var displayLink: CADisplayLink?
//    var recordingStartTime: CFTimeInterval = 0
//    
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//        // Your setup code here
//    }
//    
//    func startRecording() {
//        recordingStartTime = CACurrentMediaTime()
//        displayLink = CADisplayLink(target: self, selector: #selector(captureFrame))
//        displayLink?.add(to: .main, forMode: .default)
//    }
//    
//    func stopRecording() {
//        displayLink?.invalidate()
//        displayLink = nil
//
//        // Define the output URL
//        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("output.mov")
//
//        // Compile images into a video
//        createVideo(from: images, outputURL: outputURL, frameDuration: CMTime(value: 1, timescale: 30)) { success in
//            if success {
//                print("Video saved to: \(outputURL)")
//                // Optionally, save to Photos
//                UISaveVideoAtPathToSavedPhotosAlbum(outputURL.path, nil, nil, nil)
//            } else {
//                print("Failed to create video.")
//            }
//        }
//    }
//}
//
//public func createVideo(from images: [UIImage], outputURL: URL, frameDuration: CMTime, completion: @escaping (Bool) -> Void) {
//    guard let firstImage = images.first else {
//        completion(false)
//        return
//    }
//    let size = firstImage.size
//
//    // Create AVAssetWriter
//    do {
//        let writer = try AVAssetWriter(outputURL: outputURL, fileType: .mov)
//        let settings = [
//            AVVideoCodecKey: AVVideoCodecType.h264,
//            AVVideoWidthKey: size.width,
//            AVVideoHeightKey: size.height
//        ] as [String : Any]
//        let writerInput = AVAssetWriterInput(mediaType: .video, outputSettings: settings)
//        let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: writerInput, sourcePixelBufferAttributes: nil)
//        writer.add(writerInput)
//        writer.startWriting()
//        writer.startSession(atSourceTime: .zero)
//
//        // Append each image as a frame
//        var frameCount: Int64 = 0
//        for image in images {
//            while !writerInput.isReadyForMoreMediaData { }
//            if let buffer = pixelBuffer(from: image, size: size) {
//                let presentationTime = CMTimeMultiply(frameDuration, multiplier: Int32(frameCount))
//                adaptor.append(buffer, withPresentationTime: presentationTime)
//                frameCount += 1
//            } else {
//                completion(false)
//                return
//            }
//        }
//
//        // Finish writing
//        writerInput.markAsFinished()
//        writer.finishWriting {
//            completion(writer.status == .completed)
//        }
//    } catch {
//        print("Error creating video: \(error)")
//        completion(false)
//    }
//}
//
//public func pixelBuffer(from image: UIImage, size: CGSize) -> CVPixelBuffer? {
//    let options: [CFString: Any] = [
//        kCVPixelBufferCGImageCompatibilityKey: true,
//        kCVPixelBufferCGBitmapContextCompatibilityKey: true
//    ]
//    var pxbuffer: CVPixelBuffer?
//    let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(size.width), Int(size.height), kCVPixelFormatType_32ARGB, options as CFDictionary, &pxbuffer)
//    guard status == kCVReturnSuccess, let buffer = pxbuffer else { return nil }
//
//    CVPixelBufferLockBaseAddress(buffer, [])
//    defer { CVPixelBufferUnlockBaseAddress(buffer, []) }
//    guard let context = CGContext(
//        data: CVPixelBufferGetBaseAddress(buffer),
//        width: Int(size.width),
//        height: Int(size.height),
//        bitsPerComponent: 8,
//        bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
//        space: CGColorSpaceCreateDeviceRGB(),
//        bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
//    ) else { return nil }
//
//    guard let cgImage = image.cgImage else { return nil }
//    context.draw(cgImage, in: CGRect(origin: .zero, size: size))
//    return buffer
//}
//
//public func captureFrame() {
//    let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
//    let image = renderer.image { ctx in
//        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
//    }
//    images.append(image)
//}
