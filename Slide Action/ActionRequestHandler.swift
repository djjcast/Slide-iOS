//
//  ActionRequestHandler.swift
//  Slide Action
//
//  Created by Carlos Crane on 7/27/18.
//  Copyright © 2018 Haptic Apps. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionRequestHandler: NSObject, NSExtensionRequestHandling {

    var extensionContext: NSExtensionContext?
    
    @objc func openURL(_ url: URL) {
        return
    }

    func beginRequest(with context: NSExtensionContext) {
        // Do not call super in an Action extension with no user interface
        let extensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        let itemProvider = extensionItem.attachments?.first as! NSItemProvider
        
        let propertyList = String(kUTTypePropertyList)
        if itemProvider.hasItemConformingToTypeIdentifier(propertyList) {
            itemProvider.loadItem(forTypeIdentifier: propertyList, options: nil, completionHandler: { (item, error) -> Void in
                let dictionary = item as! NSDictionary
                OperationQueue.main.addOperation {
                    let results = dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
                    let urlString = results["currentUrl"] as? String
                    var responder: UIResponder? = self as UIResponder
                    let selector = #selector(self.openURL(_:))
                    while responder != nil {
                        if responder!.responds(to: selector) && responder != self {
                            responder!.perform(selector, with: URL(string: "slide://\(urlString!)")!)
                            return
                        }
                        responder = responder?.next
                    }
                }
            })
        } else {
        }
        self.extensionContext = nil
    }
}
