//
//  UIImageView+Nuke.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Nuke

extension UIImageView {

    func setImageByNuke(with imageUrl: URL?) {

        guard let imageUrl = imageUrl else {
            print("imageUrl is nil.")
            return
        }

        let imageRequest = ImageRequest(url: imageUrl)
        if let cachedResponse = DataLoader.sharedUrlCache.cachedResponse(for: imageRequest.urlRequest) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }

        ImagePipeline.shared.loadImage(with: imageUrl, completion: { [weak self] imageResponse, error in

            if let error = error {
                print("image download error: \(error.localizedDescription)")
                return
            }

            guard let image = imageResponse?.image else {
                print("imageResponse is nil.")
                return
            }

            self?.image = image
        })
    }
}
