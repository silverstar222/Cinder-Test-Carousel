//
//  ViewController.swift
//  ReceipeDemo
//
//  Created by Andy Castro on 26/07/19.
//  Copyright © 2019 Acquaint. All rights reserved.
//

import UIKit
import SCPageControl
class HomeViewController: UIViewController {

    @IBOutlet weak var pageControlView: SCPageControlView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var ReceipeCollection: UICollectionView!
    @IBOutlet weak var ImgPerson: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var BtnSearch: UIButton!
    let flowLayout = CustomFlowlayout()
    var ReceipeData = [ReceipeModel]()
    var currentReceipePage = 0
    var screenWidth : CGFloat = UIScreen.main.bounds.size.width
    var screenHeight : CGFloat = UIScreen.main.bounds.size.height
    override func viewDidLoad() {
        super.viewDidLoad()
        ReceipeCollection.delegate = self
        ReceipeCollection.dataSource = self
        ReceipeCollection.collectionViewLayout = flowLayout
        ReceipeCollection.showsVerticalScrollIndicator = false
        ReceipeCollection.showsHorizontalScrollIndicator = false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.SetUpdata()
        let SelectedColor = UIColor(red: 217/255, green: 99/255, blue: 77/255, alpha: 1.0)
        pageControlView.scp_style = .SCNormal
        pageControlView.set_view(ReceipeData.count, current: 0, current_color:SelectedColor, disable_color:.white)
        DispatchQueue.main.async {
            self.ReceipeCollection.reloadData()
        }
    }
    
    func SetUpdata(){
        
        let Model1 = ReceipeModel.init("Brazilian Skirt Steak with Golden Garlic Butter", ReceipeImage: #imageLiteral(resourceName: "FirstImage"))
        self.ReceipeData.append(Model1)
        
        let Model2 = ReceipeModel.init("Chicken Cooked in Spiced Ground Coconut", ReceipeImage: #imageLiteral(resourceName: "ThirdImages"))
        
        self.ReceipeData.append(Model2)
        
        let Model3 = ReceipeModel.init("Coconut Shrimp with Mango Dipping Sauce", ReceipeImage: #imageLiteral(resourceName: "SecondImage"))
        self.ReceipeData.append(Model3)
        
        let Model4 = ReceipeModel.init("Spiced Meat Layered with Fragrant Rice", ReceipeImage: #imageLiteral(resourceName: "FourthImage"))
        self.ReceipeData.append(Model4)
    }
    
    override func viewDidLayoutSubviews() {
        
        self.ImgPerson.layer.cornerRadius = self.ImgPerson.frame.height / 2
        self.ImgPerson.layer.borderColor = UIColor.white.cgColor
        self.ImgPerson.layer.borderWidth = 5.0
        self.ImgPerson.clipsToBounds = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControlView.scroll_did(scrollView)
    }
    
    
}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.ReceipeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //self.pageControl.currentPage = indexPath.row
        //self.currentReceipePage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ReceipeCollection.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! HomeCollection
        let data = ReceipeData[indexPath.item]
        cell.imgReceipe.image = data.image
        cell.lblTitle.text = data.name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}

