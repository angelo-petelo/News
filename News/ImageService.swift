//
//  ImageService.swift
//  News
//
//  Created by Nicholas Angelo Petelo on 8/24/21.
//

import Foundation
import UIKit

class ImageService {
    
    var urlStringSet: Set<String> = Set<String>()
    var imageDict: [String: UIImage] = [:]
    
    public func getImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        if urlStringSet.contains(urlString) {
            completion(imageDict[urlString])
        } else {
            urlStringSet.insert(urlString)
            downloadImage(urlString: urlString) {[weak self] image in
                guard let self = self else { return }
                self.imageDict[urlString] = image
                completion(image)
            }
        }
    }
    
    private func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(nil)
            } else if let data = data {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return }
                completion(image)
            }
        }.resume()
    }
}
