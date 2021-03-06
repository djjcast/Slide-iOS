//
//  ReadLaterViewController.swift
//  Slide for Reddit
//
//  Created by Carlos Crane on 9/29/18.
//  Copyright © 2018 Haptic Apps. All rights reserved.
//

import reddift
import RLBAlertsPickers
import UIKit

class ReadLaterViewController: ContentListingViewController {
    
    var sub = ""
    init(subreddit: String) {
        super.init(dataSource: ReadLaterContributionLoader(sub: subreddit))
        baseData.delegate = self
        self.title = "Read Later" + (subreddit == "all" ? "" : " r/" + subreddit)
        setBarColors(color: ColorUtil.getColorForSub(sub: subreddit))
        sub = subreddit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let doneall = UIButton.init(type: .custom)
        doneall.setImage(UIImage.init(named: "doneall")?.navIcon(), for: UIControlState.normal)
        doneall.addTarget(self, action: #selector(self.doneAll), for: UIControlEvents.touchUpInside)
        doneall.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25)
        let doneallB = UIBarButtonItem.init(customView: doneall)
        
        self.navigationItem.rightBarButtonItem = doneallB
    }
    
    func doneAll(){
        let alert = UIAlertController(title: "Really mark all as read?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            for item in self.baseData.content {
                ReadLater.removeReadLater(id: item.getIdentifier())
            }
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
