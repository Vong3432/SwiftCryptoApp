//
//  CoinImageService.swift
//  SwiftCryptoApp
//
//  Created by Vong Nyuksoon on 21/09/2021.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private var coin: Coin
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private var coinImageName: String
    
    init(coin: Coin) {
        self.coin = coin
        self.coinImageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coinImageName, folderName: folderName) {
            image = savedImage
            print("Retried image from local file manager")
        } else {
            print("Downloading image")
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image)
        else { return }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                
                guard
                    let self = self,
                    let downloadedImage = returnedImage
                else { return }
                
                self.image = downloadedImage
                
                // since the request is a simple GET request, unlike some real-time request
                // hence, when it comes back at the first time, we cancel it.
                self.imageSubscription?.cancel()
                
                // save to local file manager
                self.fileManager.saveImage(image: downloadedImage, imageName: self.coinImageName, folderName: self.folderName)
            })
    }
}
