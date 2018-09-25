//
//  ImagesHomecookercell.swift
//  FoodServiceClient
//
//  Created by Index on 5/27/18.
//  Copyright © 2018 Index. All rights reserved.
//
import UIKit
import FSPagerView
import  AlamofireImage
import  Alamofire
import  Localize_Swift
class ImagesHomecookercell: UITableViewCell {
    var imagesString:[String]=[]
    var images:[UIImage]=[]
    var gradientView  = CAGradientLayer()
    
    
  
    @IBOutlet weak var PagerViewImages: FSPagerView! {
        didSet {
            self.PagerViewImages.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
       
        
        
        setpagecontrol()
        
    }
    
   
    
    
}

extension ImagesHomecookercell :FSPagerViewDataSource ,FSPagerViewDelegate {
    
    
    func updatedata(newimagesstringe :[String],price:String){
        
        self.imagesString = newimagesstringe
        self.PagerViewImages.reloadData()
        pageControl.numberOfPages = imagesString.count
        
    }
    // number of image in pagerview
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imagesString.count
    }
    // set image to evey cell
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let url = self.imagesString[index]
        
        cell.imageView?.af_setImage(withURL: URL(string:url)!)
        return cell
    }
    // tell pagecontrol to move to count of same cell
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.pageControl.currentPage = index
    }
    // tell pagecontrol to move to count of same cell
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
    //setup pageview and page control
    func  setpagecontrol(){
        // Initialization code
        PagerViewImages.dataSource = self
        PagerViewImages.delegate = self
        PagerViewImages.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        PagerViewImages.isInfinite = true
        PagerViewImages.transformer = FSPagerViewTransformer(type: .crossFading )
        pageControl.setStrokeColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
        pageControl.setStrokeColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        pageControl.setFillColor(.gray, for: .normal)
        pageControl.setFillColor(.white, for: .selected)
        
        pageControl.contentHorizontalAlignment = .center
        
        
        
        
}


}
