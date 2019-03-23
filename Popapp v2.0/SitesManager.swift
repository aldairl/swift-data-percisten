import Foundation

//-----------------path for db--------------
private var appSupportDirectory:URL = {
    let url = FileManager().urls(for:.applicationSupportDirectory,in: .userDomainMask).first!
    if !FileManager().fileExists(atPath: url.path) {
        do {
            try FileManager().createDirectory(at: url,
                                              withIntermediateDirectories: false)
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    return url
}()

private var sitesFile:URL = {
    let filePath = appSupportDirectory.appendingPathComponent("favorites").appendingPathExtension("db")
    print(filePath)
    if !FileManager().fileExists(atPath: filePath.path) {
        if let bundleFilePath = Bundle.main.resourceURL?.appendingPathComponent("favorites").appendingPathExtension("db") {
            do {
                try FileManager().copyItem(at: bundleFilePath, to: filePath)
            } catch let error as NSError {
                //fingers crossed
                print("\(error.localizedDescription)")
            }
            } }
        return filePath
    }()

//class manager --------------------
class SiteManager{
    private lazy var sites:[Site] = self.loadSites()
    var siteCount:Int {return sites.count}
    func getSite(at index:Int)->Site {
        return sites[index]
}


private func loadSites()->[Site] {
    return retrieveSites() ?? []
}


func getOpenDB()->FMDatabase? {
    let db = FMDatabase(path: sitesFile.path)
    guard db.open() else {
        print("Unable to open database")
        return nil
    }
    return db
    
}

func retrieveSites() -> [Site]?{
    guard let db = getOpenDB() else{return nil}
    var sites:[Site]=[]
    
    do{
        let rs = try db.executeQuery("SELECT * FROM site", values:nil)
        
        while rs.next(){
            if let sitedb = Site(rs: rs){
                sites.append(sitedb)
            }
        }
    }catch {
        print("failed: \(error.localizedDescription)")
    }
    db.close()
    return sites
}
}
