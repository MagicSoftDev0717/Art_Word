//
//  ImageService.swift
//  art_words_v1.0
//
//  Created by TopDev on 11/2/2025.
//
import UIKit
import Photos

// Function to capture a specific UIView
public func captureView(_ view: UIView) -> UIImage? {
    // Begin image context with the view's bounds and scale
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
    defer { UIGraphicsEndImageContext() }
    
    // Render the view's layer into the current context
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    view.layer.render(in: context)
    
    // Retrieve the generated image
    return UIGraphicsGetImageFromCurrentImageContext()
}

// Function to save the captured image to Photos
public func saveViewToPhotos(_ view: UIView) {
    if let capturedImage = captureView(view) {
        UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil)
    } else {
        print("Failed to capture the view.")
    }
}





