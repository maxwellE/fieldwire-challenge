//
//  FieldWireImageCollectionViewController.swift
//  FieldWireImageSearchChallenge
//
//  Created by Maxwell Elliott on 10/21/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"

class FieldWireImageCollectionViewController: UICollectionViewController, UISearchBarDelegate {
    weak var searchBar : UISearchBar?
    let searchBarHeight : CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(FieldWireChallengeImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        // Setup search bar
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        // This controller should not be the delegate of this
        searchBar.delegate = self
        self.collectionView?.addSubview(searchBar)
        self.collectionView?.addConstraint(NSLayoutConstraint(item: searchBar, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.collectionView, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        self.collectionView?.addConstraint(NSLayoutConstraint(item: searchBar, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.collectionView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.collectionView?.addConstraint(NSLayoutConstraint(item: searchBar, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.collectionView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.collectionView?.addConstraint(NSLayoutConstraint(item: searchBar, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: searchBarHeight))
        self.searchBar = searchBar
        
//        for page in [0,1,2,3,4,5] {
//            FieldWireImageRequestNetworkManager.fetchImagesFromImgurWithSearchString("dog", page: page)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let searchText = self.searchBar?.text {
            let entities = Image.MR_findAllWithPredicate(NSPredicate(format: "search_term MATCHES %@", searchText))
            if let imageData = entities[indexPath.row] as? Image {
                UIApplication.sharedApplication().openURL(NSURL(string: imageData.link!)!)
            }
        }
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let searchText = self.searchBar?.text {
           return Int(Image.MR_countOfEntitiesWithPredicate(NSPredicate(format: "search_term MATCHES %@", searchText)))
        }
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FieldWireChallengeImageCollectionViewCell
    
        // Configure the cell
        
        if let searchText = self.searchBar?.text {
            let entities = Image.MR_findAllWithPredicate(NSPredicate(format: "search_term MATCHES %@", searchText))
            if let imageData = entities[indexPath.row] as? Image {
                cell.setupImageCell(imageData)
            }
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    // MARK: Status bar logic
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: Search Bar Delegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            for page in (0...5) {
                FieldWireImageRequestNetworkManager.fetchImagesFromImgurWithSearchString(searchText, page: page, completionBlock: { [weak self] () -> Void in
                    self?.collectionView?.reloadData()
                })
            }
        }
    }

}
