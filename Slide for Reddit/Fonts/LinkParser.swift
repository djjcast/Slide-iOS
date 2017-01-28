//
//  LinkParser.swift
//  Slide for Reddit
//
//  Created by Carlos Crane on 1/28/17.
//  Copyright © 2017 Haptic Apps. All rights reserved.
//

import UIKit

class LinkParser {
    public static func parse(_ attributedString: NSAttributedString) -> NSMutableAttributedString {
        let string = NSMutableAttributedString.init(attributedString: attributedString)
        if(string.length > 0){
            string.enumerateAttributes(in: NSRange.init(location: 0, length: string.length), options: .longestEffectiveRangeNotRequired, using: { (attrs, range, pointer) in
                for attr in attrs {
                    if let url = attr.value as? URL {
                        if(SettingValues.enlargeLinks){
                            string.addAttribute(NSFontAttributeName, value: FontGenerator.boldFontOfSize(size: 18, submission: false), range: range)
                        }
                        
                        if(SettingValues.showLinkContentType){
                            let type = ContentType.getContentType(baseUrl: url)
                            
                            let typeString = NSMutableAttributedString.init(string: "", attributes: [:])
                            switch(type) {
                            case .ALBUM:
                                typeString.mutableString.setString("(Album)")
                                break
                            case .EXTERNAL, .LINK, .EMBEDDED, .NONE:
                                if(url.absoluteString != string.mutableString.substring(with: range)){
                                    typeString.mutableString.setString("(\(url.host!))")
                                }
                                break
                            case .DEVIANTART, .IMAGE, .TUMBLR, .XKCD:
                                typeString.mutableString.setString("(Image)")
                                break
                            case .GIF:
                                typeString.mutableString.setString("(GIF)")
                                break
                            case .IMGUR:
                                typeString.mutableString.setString("(Imgur)")
                                break
                            case .VIDEO, .STREAMABLE, .VID_ME:
                                typeString.mutableString.setString("(Video)")
                                break
                            case .REDDIT:
                                typeString.mutableString.setString("(Reddit link)")
                                break
                            default:
                                if(url.absoluteString != string.mutableString.substring(with: range)){
                                    typeString.mutableString.setString("(\(url.host!))")
                                }
                                break
                            }
                            string.insert(typeString, at: range.location + range.length)
                            string.addAttributes([NSFontAttributeName: FontGenerator.boldFontOfSize(size: 12, submission: false), NSForegroundColorAttributeName: ColorUtil.fontColor], range: NSRange.init(location: range.location + range.length, length: typeString.length))
                        }
                        break
                    }
                }
                
            })
        }
        return string
    }
}
