import Foundation
import UIKit

internal struct key {
    static let title = "title"
    static let desSite = "desSite"
    
}

struct Site{
    static let defaultImage = UIImage(named: "siteDefault.png")!
    var title:String
    var desSite:String
    private var image:UIImage? = nil
    var cover:UIImage{
        get{
            return image ?? Site.defaultImage
        }
        
        set{
            image = newValue
        }
    }
    
    init(title:String, des:String, cover:UIImage? = nil) {
        self.title = title
        self.desSite = des
        self.image = cover
    }
    
    init?(rs:FMResultSet) {
        guard let title = rs.string(forColumn: key.title),
            let desSite = rs.string(forColumn: key.desSite)
            
            else {return nil }
        
        self.init(title:title, des:desSite)
    }
    
}

