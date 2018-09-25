//
//  Detailesproducte.swift
//  FoodServiceClient
//
//  Created by Index on 5/29/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import FSPagerView
class Detailesproducte: UIViewController {
    var datadetailes : getproductdata!
    var carddictionary:[String:[Int]]!
    var gestureRecognizer :UITapGestureRecognizer!
    var GetallHomeCookerplaces = GetallProdacteRepo()
    var countitytext:String!
    var partycooker:PartyCookerData!
    var ShowMora = false
    
    @IBOutlet weak var tableViewproductedetailes: UITableView!
    @IBOutlet weak var TabletopConstrain: NSLayoutConstraint!
    
    
    var imagesString:[String]=[]
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var PagerViewImages: FSPagerView! {
        didSet {
            self.PagerViewImages.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setup()
        // Do any additional setup after loading the view.
    }

   func setup(){
    self.navigationController?.navigationBar.tintColor = .white
    setupNavigationBar()
//    self.navigationItem.backBarButtonItem?.title = "Back".localized()
    
    if let name = datadetailes.name {
        self.title = name
    }
    tableViewproductedetailes.delegate=self
    tableViewproductedetailes.dataSource=self
    tableViewproductedetailes.separatorInset=UIEdgeInsetsMake(0, 0, 0,80);
    TabletopConstrain.constant = self.view.layer.frame.height*22/100
//    tableViewproductedetailes.backgroundView?.dropShadow(color: #colorLiteral(red: 0.8705936074, green: 0.8707399964, blue: 0.8705742955, alpha: 1), opacity: 0.5, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
    tableViewproductedetailes.backgroundView?.layer.cornerRadius = 8
    
    
    tableViewproductedetailes.backgroundView?.layer.shadowColor = UIColor.black.cgColor
    tableViewproductedetailes.backgroundView?.layer.shadowOpacity = 1
    tableViewproductedetailes.backgroundView?.layer.shadowOffset = CGSize.zero
    tableViewproductedetailes.backgroundView?.layer.shadowRadius = 10
    tableViewproductedetailes.backgroundView?.layer.shadowPath = UIBezierPath(rect: (tableViewproductedetailes.backgroundView?.bounds)!).cgPath
    tableViewproductedetailes.backgroundView?.layer.shouldRasterize = true
    
    
    SetPagerViewImage()
    PagerViewImages.reloadData()
    NameLabel.text = datadetailes.name
    
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        tableViewproductedetailes.backgroundView?.dropShadow(color: #colorLiteral(red: 0.8705936074, green: 0.8707399964, blue: 0.8705742955, alpha: 1), opacity: 0.5, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
//        tableViewproductedetailes.backgroundView?.layer.cornerRadius = 4
    }
 

    
    func updatedata(datadetailes :getproductdata){
        
        self.datadetailes = datadetailes
        for image in self.datadetailes.imgs {
            imagesString.append(image)
        }
        
        
    }
    
    
    
    
    
}





extension Detailesproducte :UITableViewDelegate ,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 1
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            let cell : DetailesProductInfoCell = tableViewproductedetailes.dequeueReusableCell(withIdentifier: "DetailesProductInfoCell", for: indexPath) as! DetailesProductInfoCell
            cell.Pricevalue.text = String("\(datadetailes.price!) \("Riyal".localize())")
            cell.ingrediantsvalue.text = datadetailes.ingredients
            cell.PreprationValue.text = datadetailes.cookingPreparation
            cell.reservationValue.text = datadetailes.minPeriodToOrder
            cell.RateValue.settings.fillMode = .precise
            cell.RateValue.rating = datadetailes.rating
            cell.RateValue.text = String(datadetailes.rating)
            return cell
    
        
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height*60/100
      }
    
   
    
    
    
    
    
    
    
    
    
}




extension Detailesproducte :FSPagerViewDataSource ,FSPagerViewDelegate {
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
        PagerViewImages.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        PagerViewImages.isInfinite = true
        PagerViewImages.transformer = FSPagerViewTransformer(type: .crossFading )
        pageControl.setStrokeColor(#colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1), for: .selected)
        pageControl.setStrokeColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        pageControl.setFillColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        pageControl.setFillColor(#colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1), for: .selected)
        
        pageControl.contentHorizontalAlignment = .center
        
        
        
        
    }
    
    
   func SetPagerViewImage(){
    PagerViewImages.dataSource = self
    PagerViewImages.delegate = self
    pageControl.numberOfPages = imagesString.count
    setpagecontrol()
    }
    
    
    
    
    
    
    
    
    
    
    
}


