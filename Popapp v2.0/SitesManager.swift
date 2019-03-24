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


    func loadSites(position :Int? = nil)->[Site] {
        if position == 1 {
            return parques()
        }
    return retrieveSites() ?? []
}
    
    private func parques()->[Site] { return [
        Site(title: "Parque1",des:""),
        Site(title: "parque2",des:""),
        Site(title: "parque3",des:""),
        Site(title: "parque4",des:"")
        ] }

func addSite(_ site:Site){
     var siteg = site
    SQLAddSite(site: &siteg)
        sites.append(siteg)
    
    }
    
    
    //----------SQL
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
    
    func SQLAddSite(site:inout Site){
        guard  let db = getOpenDB() else { return}
        
        do{
            try db.executeUpdate("insert into site (title, desSite, cover) values (?, ?, ?)", values: [site.title, site.desSite, site.cover])
        }catch{
            
            print("failed: \(error.localizedDescription)")
        }
        db.close()
    }
}
