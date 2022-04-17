//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 17.04.22.
//

import Foundation
import UIKit

class LocalFileManager{
  
  static let shared = LocalFileManager()
  
  private init(){}
  
  func saveImage(folderName: String, imageName: String, image: UIImage){
    createDirectoryIfNeeded(folderName: folderName)
    
    guard let data = image.pngData() else { return }
    guard let url = getImageUrl(folderName: folderName, imageName: imageName) else { return }
    if FileManager.default.fileExists(atPath: url.path) { return }
    do{
      try data.write(to: url)
    }catch{
      print("Error writing data to :\(url)")
    }
  }
  
  func getImage(folderName: String, imageName: String) -> UIImage?{
    guard let url = getImageUrl(folderName: folderName, imageName: imageName), FileManager.default.fileExists(atPath: url.path) else { return nil }
    return UIImage(contentsOfFile: url.path)
  }
  
  func getFolderUrl(folderName: String) -> URL?{
    guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{ return nil }
    return url.appendingPathComponent(folderName)
  }
  
  func getImageUrl(folderName: String, imageName: String) -> URL?{
    guard let url = getFolderUrl(folderName: folderName) else { return nil }
    let imageUrl = url.appendingPathComponent(imageName + ".png")
    
    return imageUrl
  }
  
  func createDirectoryIfNeeded(folderName: String){
    guard var url = getFolderUrl(folderName: folderName) else { return }
    url = url.appendingPathComponent(folderName)
    if !FileManager.default.fileExists(atPath: url.path){
      do{
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
      }catch{
        print("Error creating folder at \(url)")
      }
      
    }
  }
  
}
