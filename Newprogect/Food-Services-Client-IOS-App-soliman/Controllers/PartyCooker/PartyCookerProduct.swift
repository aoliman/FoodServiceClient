//
//  PartyCookerProduct.swift
//  FoodService
//
//  Created by index-ios on 4/9/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import Toast_Swift
import Material
class PartyCookerProduct: UIViewController {
    var listofproducte : [getproductdata] = []
    var ispartycooker=false
    var loaddata=0
    var isNewDataLoading=false
    var type = 0
    var userId = 3
    
    var CoastForPerson:Float=0.0
    var limit = 10
    var page = 1
    var pageCount = 2
    var totalCount = 0
    var ChooseItems :[Int]=[]
    var Getallproducterepo = GetallProdacteRepo()
    var CatogaryType :String!
    @IBOutlet weak var BtnNext: RaisedButton!
    
    @IBOutlet weak var TablePartycooker: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
         myLoader.hideCustomLoader()
        BtnNext.setTitle("Next".localized(), for: .normal)
        self.navigationController?.navigationBar.tintColor = .white
        TablePartycooker.delegate=self
        TablePartycooker.dataSource=self
        //collection view bounds
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - (UIScreen.main.bounds.width*5/100), height: UIScreen.main.bounds.height*22/100)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.headerReferenceSize = CGSize(width: 0, height: 5)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        TablePartycooker.collectionViewLayout = layout
        print(UserDefaults.standard.integer(forKey: PartyCookerId))
        CatogaryType = UserDefaults.standard.string(forKey: Profiletype)
        LoadProductOfSpeceficPartyCooker(page: page, limit: limit, userId: UserDefaults.standard.integer(forKey: PartyCookerId), type: CatogaryType)
        
        
        
        
    }
    
    
    
    @IBAction func NextBtnAction(_ sender: Any) {
        if ChooseItems == []{
       UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please choose Item")
        }else{
            if(CatogaryType  == "home-cookers" || CatogaryType  == "food-cars" || CatogaryType  == "restaurant-owners"){
                var Items :[getproductdata] = []
                var imagesString:[String] = []
                for id in ChooseItems {
                    for item  in listofproducte {
                        if(id == item.id){
                          Items.append(item)
                          imagesString.append(item.imgs[0])
                        }
                    }
                    
                }
                
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc :AddorderHomeCooker = storyboard.instantiateViewController(withIdentifier: "AddorderHomeCooker") as! AddorderHomeCooker
                vc.updatedata(productesdata:Items , ChooseItemsids :ChooseItems , imagesString:imagesString ,type:CatogaryType)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                performSegue(withIdentifier: "PartyCookercompleteorder", sender: ChooseItems )

            }
        }
        
    }
    
  
    
    
    

  

}
extension PartyCookerProduct :UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listofproducte.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ProductCollectionCell = TablePartycooker.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
        cell.layer.cornerRadius=10
        cell.Eateimage.af_setImage(withURL: URL(string:listofproducte[indexPath.row].imgs[0] )! )
        cell.NameOrderTxt.text=listofproducte[indexPath.row].name
        cell.Price.text="\(listofproducte[indexPath.row].price!) \("Riyal".localize() )"
        cell.checkbox.tag=listofproducte[indexPath.row].id
        cell.delegate=self
        
        
        
        
        switch listofproducte[indexPath.row].rating {
            
        case 0.5 ... 1 :
            
            cell.RateImage.image = #imageLiteral(resourceName: "very_angry_face-2")
        case 1.1 ... 2.0 :
            cell.RateImage.image = #imageLiteral(resourceName: "angry_face")
        case 2.1 ... 3.0:
            cell.RateImage.image = #imageLiteral(resourceName: "notbad_face")
     
        case 3.1 ... 4.0 :
            cell.RateImage.image = #imageLiteral(resourceName: "happy_face")
            
        case 4.1 ... 5.0:
            cell.RateImage.image = #imageLiteral(resourceName: "Emoji (1)")
            
            
        default : break
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //send to producte details
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : Detailesproducte = storyboard.instantiateViewController(withIdentifier: "Detailesproducte") as! Detailesproducte
        vc.updatedata(datadetailes:listofproducte[indexPath.row] as! getproductdata )
        vc.datadetailes=listofproducte[indexPath.row] as! getproductdata
        
        
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == TablePartycooker {
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height)-10 >= scrollView.contentSize.height)
            {
                if !isNewDataLoading{
                    
                    
                    LoadProductOfSpeceficPartyCooker(page: page, limit: limit, userId: UserDefaults.standard.integer(forKey: PartyCookerId), type: CatogaryType)
                    
                    
                    
                    isNewDataLoading = true
                    
                    
                }
                isNewDataLoading=false
            }
        }
       
        
        
    }
    
    
    
    
    
    func LoadProductOfSpeceficPartyCooker(page :Int ,limit :Int ,userId :Int ,type:String ){
        
        if(page>pageCount){
            return
        }else{
            myLoader.showCustomLoaderview(uiview: self.view)
            Getallproducterepo.GetSpecificHomeCookerProduct(page:page , limit: limit, userId: userId, type:type ) { (SuccessResponse) in
                if(SuccessResponse != nil){
                    //Success Get All producte
                    let data=SuccessResponse.data
                    if data != nil {
                        for onedata in data!  {
                            self.listofproducte.append(onedata)
                            // print(onedata)
                            
                        }
                        // print(self.listofproducte)
                        //                            self.ProductCollectioView.reloadData()
                    }
                    print(self.listofproducte)
                    self.page=page+1
                    self.pageCount = SuccessResponse.pageCount
                    print("page counte \(self.pageCount)  page \(self.page)"  )
                    print(self.listofproducte.count)
                    self.TablePartycooker.reloadData()
                    myLoader.hideCustomLoader()
                }
            }
        }
        
        
        
    }
    
    
    
    
    
}
extension PartyCookerProduct : Checkitem {
    func CheckitemId(id: Int) {
       
        var add = true
        if ChooseItems != [] {
            for item in 1...ChooseItems.count{
                if ChooseItems[item-1]  == id {
                    ChooseItems.remove(at: item-1)
                    add = false
                    break
                }
            }
            if add{
                ChooseItems.append(id)
            }
        }else{
           ChooseItems.append(id)
        }
        
       print(ChooseItems)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PartyCookercompleteorder" {
            let vc : CompletePartyCoockerOrder = segue.destination as! CompletePartyCoockerOrder
          CoastForPerson=0
            for id in ChooseItems{
                for item in listofproducte{
                    if item.id == id {
                     CoastForPerson=Float(CoastForPerson)+Float(item.price)+Float(item.serviceFees)
                        print("price = \(CoastForPerson)")
                        
                    }
                }
            }
            vc.Setupinfo(chooseitem: ChooseItems , priceforperson : CoastForPerson, Name: listofproducte[0].owner.name)
        }
        
        if (segue.identifier == "ProducteDetailesfrompartycooker") {
            let destination = segue.destination as! ProducteDetails
            if(sender != nil){
                destination.datadetailes=sender as! getproductdata}
            
        }
    }
    
    
    
    
}
    
    
    
    
    
    
    
    

