//
//  MTubeVideoViewController.swift
//  modoTube
//
//  Created by Guillaume on 21/07/2017.
//  Copyright © 2017 mobizel. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import SwiftyJSON
import RealmSwift

class MTubeVideoViewController: UIViewController {
    
    // MARK: - Global
    
    // MARK: - Privates
    fileprivate var saveName: String?
    fileprivate var numberOfVideo = 25
    fileprivate var listVideo: Results<Video>?
    static fileprivate let reuseIdentifier = "reuseIdentifierVideoTableViewCell"
    
    // MARK: - IBOutlet
    @IBOutlet weak fileprivate var tvVideo: UITableView!
    @IBOutlet weak fileprivate var buttonSend: UIButton!
    @IBOutlet weak fileprivate var labelPresentation: UILabel!
    @IBOutlet weak fileprivate var tfSearch: UITextField!
    @IBOutlet weak fileprivate var sfNumberOfPagePerView: UISegmentedControl!
    
    // MARK: - Application Lifecyle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RealmHelper.remove(type: Video.self)
        RealmHelper.remove(type: Length.self)

        setup()
        prepareData()
        prepareTableView()
    }
}

// MARK: - MTubeVideoViewController
extension MTubeVideoViewController {
    
    // MARK: - Configurations
    fileprivate func setup() {
        self.title = tr(.mTubeVideoViewControllerTitle)
        self.tfSearch.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        self.tfSearch.placeholder = tr(.mtvViewControllerTfSearchPlaceholder)
        self.labelPresentation.text = tr(.mtvViewControllerLabelPresentationText)
        self.buttonSend.setTitle(tr(.mtvViewControllerSendButtonName), for: .normal)        
        self.buttonSend.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .touchDown)
        self.tfSearch.clearButtonMode = .whileEditing
        
    }
    
    fileprivate func prepareData() {
        self.listVideo = RealmHelper.objects(type: Video.self)
//        logger.verbose(listVideo ?? "list empty")
    }
    
    // MARK: - Privates Functions
    func fetchVideoInformation(searchString: String, responseHandler: ((Bool) -> Void)? = nil) {
        Helper.canAccessInternet { hasInternet in
            if hasInternet {
                HUD.flash(.labeledProgress(title: tr(.mtvViewControllerHUDRequestTitle), subtitle: tr(.mtvViewControllerHUDRequestSubtitle)))
                
                let parameters: Parameters = [
                    "key": YoutubeAPI.Keys.secret,
                    "part": "snippet",
                    "maxResults": self.getValueFromSegment(),
                    "type": "",
                    "q": searchString
                ]
                
                Alamofire.request(YoutubeAPI.baseURL + YoutubeAPI.search, method: .get, parameters: parameters)
                    .validate(statusCode: 200..<300)
                    //            .responseJSON { response in
                    //                if response.response?.statusCode == 200 {
                    //                    if let serverData = response.result.value {
                    //                        let json = JSON(serverData)
                    //                        logger.verbose(json)
                    //                    }
                    //                }
                    //            }
                    .responseArray(keyPath: "items") { (response: DataResponse<[Video]>) in
                        RealmHelper.remove(type: Video.self)
                        RealmHelper.remove(type: Length.self)
                        
                        let videoArray = response.result.value
                        if let newArrayOfVideo = videoArray {
                            for video in newArrayOfVideo {
                                //                        logger.info(video)
                                video.addToRealm()
                            }
                            HUD.hide()
                            responseHandler?(true)
                        } else {
                            responseHandler?(false)
                        }
                        HUD.hide()
                }
            } else {
                let alertReminder = UIAlertController(title: "No internet connection",
                                                      message: "Check your internet connection",
                                                      preferredStyle: .alert)
                
                // Action close
                alertReminder.addAction(UIAlertAction(title: tr(.commonClose).capitalizingFirstLetter(), style: .destructive, handler: nil))
                
                // Show alert
                self.present(alertReminder, animated: true, completion: nil)
            }
        }
    }
    
    func fetchlengthVideo() {
        
        if let list = self.listVideo {
            for video in list {
                let newlength: Length = Length()
                newlength.fetchVideoLengthInformation(videoId: video.identifier)
            }
            logger.verbose("done")
            self.tvVideo.reloadData()
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension MTubeVideoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = tfSearch.text, !text.isEmpty {
            self.fetchVideoInformation(searchString: text, responseHandler: { (status) in
                if status {
                    self.tvVideo.reloadData()
                    self.fetchlengthVideo()
                }
            })
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        RealmHelper.remove(type: Video.self)
        self.tvVideo.reloadData()
        return true
    }
    
    func getValueFromSegment() -> String {
        let segment = sfNumberOfPagePerView.selectedSegmentIndex
        if let value = sfNumberOfPagePerView.titleForSegment(at: segment) {
            return value
        }
        return "25"
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MTubeVideoViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView Setup
    fileprivate func prepareTableView() {
        self.tvVideo.delegate = self
        self.tvVideo.dataSource = self
        self.tvVideo.tableHeaderView = nil
        self.tvVideo.estimatedRowHeight = 105
        self.tvVideo.tableFooterView = UIView()
        self.tvVideo.rowHeight = UITableViewAutomaticDimension
        
        // register nib
        self.tvVideo.registerNib(nibName: "MTubeTableViewCell",
                                 reuseIdentifier: MTubeVideoViewController.reuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVideo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MTubeVideoViewController.reuseIdentifier, for: indexPath) as? MTubeTableViewCell,
            let list = listVideo {
            cell.applyVideo(list[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = .zero
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell: UITableViewCell = tableView.cellForRow(at: indexPath) {
            if cell is MTubeTableViewCell {
                if let currentVideo = listVideo?[indexPath.row] {
                    logger.verbose(currentVideo)
                    var openURL: String
                    if currentVideo.isPlaylist {
                        openURL = YoutubeAPI.Url.playlist + currentVideo.identifier
                    } else if currentVideo.isChannel {
                        openURL = YoutubeAPI.Url.channel + currentVideo.identifier
                    } else {
                        openURL = YoutubeAPI.Url.video + currentVideo.identifier
                    }
                    let newURL: URL? = URL(string: openURL)
                    self.loadWebPage(newURL)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
