//
//  FileManager.swift
//  Orlo
//
//  Created by omer on 3.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

class FileManager: NSObject {

    
    class func getJSON(withJSONFileName fileName: String) -> AnyObject {
        
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        {
            
            if let jsonData =  NSData(contentsOfFile:path)
            {
                let jsonResult = try! NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
                return jsonResult
            }

        }
        return 0
    }
    
}
