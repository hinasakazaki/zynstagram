//
//  PhotosViewController.swift
//  zynstagram
//
//  Created by Kenneth Pu on 9/16/15.
//  Copyright © 2015 Kenneth Pu. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var photos: NSArray = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var clientId = "204bd34cc49140aeaaa1ea7cbfe46b5f"
        var secret = "87621af6b5d249c8a9007a69dff622eb"

        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        var request = NSURLRequest(URL: url)

        self.tableView.rowHeight = 320
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if let d = data {
                let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(d, options: [])
                self.photos = responseDictionary["data"] as! NSArray
                self.tableView.reloadData()
            } else {
                if let e = error {
                    NSLog("Error: \(e)")
                }
            }
        }
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.zynga.zynstagramPrototypeCell", forIndexPath: indexPath) as! PhotosTableViewCell
        
        let photo = self.photos[indexPath.row] as? NSDictionary
        let urlString = photo?.valueForKeyPath("images.low_resolution.url") as? NSString
        let url = NSURL(string: urlString as! String)!
        cell.zymageView.setImageWithURL(url)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! PhotoDetailsViewController
        var indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)
        
        vc.photo = self.photos[indexPath!.row] as? NSDictionary
    }
}
