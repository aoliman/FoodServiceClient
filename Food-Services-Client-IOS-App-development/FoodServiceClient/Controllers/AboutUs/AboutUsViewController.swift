//
//  AboutUsViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 1/1/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import SnapKit
private let sectionHeader = "sectionHeader"
private let aboutCellIdentifier = "aboutCellIdentifier"

class AboutUsViewController: UIViewController {

    var collectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    
    var sections = ["who we are", "terms and conditions", "privacy policy"]
    
    var sectionSelected: [Int] = [0,1,2]
    
    var indexPaths: [IndexPath] = [[0,0],[1,0],[2,0]]

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
//            UIColor.init(red: 241/255, green: 241/255, blue: 244/255, alpha: 1)
        self.collectionView.register(SettingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader , withReuseIdentifier: sectionHeader)
        collectionView.register(AboutCollectionCell.self, forCellWithReuseIdentifier: aboutCellIdentifier)

        setupView()
        setupNavigationBar()
        
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            make in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(self.view.snp.top).offset(20)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   

}
extension AboutUsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeader, for: indexPath) as! SettingCollectionReusableView
        
       
        if indexPath.section == 0 {

            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(tapDetected))
            headerView.tag = 0
            headerView.addGestureRecognizer(tapGestureRecognizer)
        } else if indexPath.section == 1 {
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(tapDetected))
            headerView.tag = 1
            headerView.addGestureRecognizer(tapGestureRecognizer)
        } else if indexPath.section == 2 {
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(tapDetected))
            headerView.tag = 2
            headerView.addGestureRecognizer(tapGestureRecognizer)
        }
        headerView.backgroundColor = #colorLiteral(red: 0.02245714143, green: 0.7358890176, blue: 0.8365200162, alpha: 1)
        headerView.label.addIconLabel("fa-angle-up", .white, headerView.iconLabel)
        headerView.label.textColor = .white
        headerView.label.setAlignment()
        
        if indexPath.section == 0 {
            headerView.label.text = sections[indexPath.section].localized()
        } else if indexPath.section == 1 {
            headerView.label.text = sections[indexPath.section].localized()
        } else  if indexPath.section == 2 {
            headerView.label.text = sections[indexPath.section].localized()
        }

        return headerView
    }

    @objc func tapDetected(_ tapGestureRecognizer: UITapGestureRecognizer) {
        
        let item = tapGestureRecognizer.view!.tag
        let headerView = tapGestureRecognizer.view! as! SettingCollectionReusableView
        
        if let index = sectionSelected.index(of: item) {
            sectionSelected.remove(at: index)
            indexPaths.remove(at: index)
            headerView.backgroundColor = #colorLiteral(red: 0.9146607518, green: 0.9096613526, blue: 0.9139177203, alpha: 1)
            headerView.label.textColor = .black
            headerView.label.addIconLabel("fa-angle-down", .black, headerView.iconLabel)
        } else {
            
            headerView.backgroundColor = #colorLiteral(red: 0.02245714143, green: 0.7358890176, blue: 0.8365200162, alpha: 1)
            headerView.label.addIconLabel("fa-angle-up", .white, headerView.iconLabel)
            headerView.label.textColor = .white
            sectionSelected.append(item)
            indexPaths.append([item,0])
        }
        
        self.collectionView.reloadItems(at: indexPaths)
        print(sectionSelected, indexPaths)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let  width  = Double(UIScreen.main.bounds.width)
        if UIDevice.current.model == "iPad" {
            return CGSize(width: width - 15, height: 60)

        } else {
            return CGSize(width: width - 15, height: 40)

        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
    
        return UIEdgeInsetsMake(10, 10, 0, 10)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if sectionSelected.contains(indexPath.section) {
            
            let  width  = Double(UIScreen.main.bounds.width) - 20
            return CGSize.init(width: width, height: Double(sections[indexPath.section].height(withConstrainedWidth: CGFloat(width), font: .appFontBold(ofSize: 20))) + 20 )
            
        } else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: aboutCellIdentifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(sections[indexPath.section])
        let cell = cell as? AboutCollectionCell
        cell?.label.text = " " + " " + sections[indexPath.section]
        cell?.label.textColor = .black
        

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
    
}
