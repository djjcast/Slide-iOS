//
//  GetURL.js
//  Slide Action
//
//  Created by Carlos Crane on 7/27/18.
//  Copyright © 2018 Haptic Apps. All rights reserved.
//

var GetURL = function() {};

GetURL.prototype = {
    
run: function(arguments) {
    arguments.completionFunction({ "currentUrl" : document.URL });
}
    
};

var ExtensionPreprocessingJS = new GetURL;
