//
//  MTubeTableViewCell.swift
//  modoTube
//
//  Created by Guillaume on 24/07/2017.
//  Copyright © 2017 mobizel. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MTubeTableViewCell: UITableViewCell {
    
    // MARK: Global
    
    // MARK: Privates
    @IBOutlet weak fileprivate var miniatureVideo: UIImageView!
    @IBOutlet weak fileprivate var nameVideo: UILabel!
    @IBOutlet weak fileprivate var lengthVideo: UILabel!
    
    // MARK: IBOutlet
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
}

// MARK: - MTubeTableViewCell
extension MTubeTableViewCell {
    
    // MARK: - Configurations
    fileprivate func setup() {
        self.miniatureVideo.contentMode = .scaleAspectFit
    }
    
    // MARK: - Privates Functions
    func getVideoLenght(_ video: Video) -> String? {
        if let videoDuration = RealmHelper.objects(type: Length.self)?.filter(NSPredicate(format: "identifier = %@", video.identifier)).first {
            return videoDuration.duration
        }
        return nil
    }
    
    // MARK: - Public Functions
    func applyVideo(_ newVideo: Video) {
        if let urlString = newVideo.imageURL, let url = URL(string: urlString) {
            // Picture
            DataRequest.addAcceptableImageContentTypes(["binary/octet-stream"])
            self.miniatureVideo.af_setImage(withURL: url, imageTransition: .crossDissolve(0.2), completion: { (response) in
                if let newImage = response.result.value {
                    self.miniatureVideo.image = newImage
                }
            })
            if let name = newVideo.title {
                self.nameVideo.text = name
            }
            if newVideo.isChannel || newVideo.isPlaylist {
                lengthVideo.text = ""
            } else {
                if let duration = getVideoLenght(newVideo) {
//                    logger.verbose(newVideo)
                    lengthVideo.text = duration
                }
            }
        }
    }
}
