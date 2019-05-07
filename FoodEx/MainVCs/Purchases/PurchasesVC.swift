//
//  Payment.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/26/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import UPCarouselFlowLayout

class PurchasesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var programsParent: UIStackView!
    var programDefaultHeight: CGFloat = 0
    @IBOutlet weak var programsParentHeightConstraint: NSLayoutConstraint!
    
    fileprivate var promos = [Promo]()
    
    private var programsViews: [ProgramView] = []
    
    fileprivate var currentPage: Int = 0 {
        didSet {
            let promo = self.promos[self.currentPage]
        }
    }
    
    fileprivate var pageSize: CGSize {
        print(self.collectionView.collectionViewLayout.self)
        
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    fileprivate var orientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: PromoCard.kCONTENT_XIB_NAME, bundle: nil), forCellWithReuseIdentifier: PromoCard.kCONTENT_XIB_NAME)
        
        programDefaultHeight = programsParentHeightConstraint.constant
        
        self.setupLayout()
        self.promos = self.createItems()
        
        self.currentPage = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        fillProgramsData()
    }
    
    fileprivate func setupLayout() {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
    }
    
    fileprivate func createItems() -> [Promo] {
        let promos = [
            Promo(image: UIImage(named: "promo_0"), title: "+100 UAH for each dropped kilogram", date: "13 Oct", link: "https://foodexhub.com.ua/promo/kilogram"),
            Promo(image: UIImage(named: "promo_1"), title: "VIP card", date: "13 Oct", link: "https://foodexhub.com.ua/promo/club"),
            Promo(image: UIImage(named: "promo_2"), title: "2 programs to one address - discount", date: "13 Oct", link: "https://foodexhub.com.ua/promo/address"),
            Promo(image: UIImage(named: "promo_3"), title: "+150 UAH for each friend's order", date: "13 Oct", link: "https://foodexhub.com.ua/promo/friends"),
            Promo(image: UIImage(named: "promo_4"), title: "Order 3 salads + 1 is a gift", date: "13 Oct", link: "https://foodexhub.com.ua/promo/salat_v_podarok"),
            Promo(image: UIImage(named: "promo_5"), title: "Become a FoodEx partner", date: "13 Oct", link: "https://foodexhub.com.ua/promo/partner")
        ]
        return promos
    }
    
    // MARK: - Card Collection Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoCard.identifier, for: indexPath) as! PromoCard
        let cell : PromoCard = collectionView.dequeueReusableCell(withReuseIdentifier: PromoCard.kCONTENT_XIB_NAME, for: indexPath) as! PromoCard
        
        let promo = promos[(indexPath as NSIndexPath).row]
        cell.initPromo(promo: promo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let promo = promos[(indexPath as NSIndexPath).row]
        UIApplication.shared.openURL(NSURL(string: promo.link)! as URL)
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    
    
    func fillProgramsData() {
        var programs: [Program] = []
        programs.append(Program(name: "Express Program of Loosing Weight",
                                 shortDescription: "To get the result in the shortest term.",
                                 image: UIImage(named: "program_1")!,
                                 link: "https://foodexhub.com.ua/kiev/express-pohudeniye-dlya-muzhchin"))
        programs.append(Program(name: "Smooth Loosing Weight",
                                 shortDescription: "For comfortable loosing weight",
                                 image: UIImage(named: "program_2")!,
                                 link: "https://foodexhub.com.ua/kiev/plavnoe-pohudeniye-dlya-muzhchin"))
        programs.append(Program(name: "Sports Menu",
                                 shortDescription: "For those with active life style and intensive gym trainings",
                                 image: UIImage(named: "program_3")!,
                                 link: "https://foodexhub.com.ua/kiev/sportivnoe-pitaniye-dlya-muzhchin"))
        programs.append(Program(name: "Sport-PRO",
                                 shortDescription: "For those with active life style, hard trainings and sports",
                                 image: UIImage(named: "program_4")!,
                                 link: "https://foodexhub.com.ua/kiev/sport-pro"))
        programs.append(Program(name: "Balanced Eating",
                                 shortDescription: "To maintain good physical form and stick to healthy eating",
                                 image: UIImage(named: "program_5")!,
                                 link: "https://foodexhub.com.ua/kiev/sbalansirovannoye-pitaniye-dlya-muzhchin"))
        programs.append(Program(name: "Meat-free Menu",
                                 shortDescription: "The ration is saturated with vegetable food including seafood",
                                 image: UIImage(named: "program_6")!,
                                 link: "https://foodexhub.com.ua/kiev/pitaniye-bez-myasa-dlya-muzhchin"))
        programs.append(Program(name: "Vegetarian Menu",
                                 shortDescription: "Balanced eating for vegetarians",
                                 image: UIImage(named: "program_7")!,
                                 link: "https://foodexhub.com.ua/kiev/postnoe-menu-dlya-muzhchin"))
        programs.append(Program(name: "Individual Menu",
                                 shortDescription: "Developed specially for YOU by doctor-dietician and the Chef",
                                 image: UIImage(named: "program_8")!,
                                 link: "https://foodexhub.com.ua/kiev/individualnoe-pitaniye-dlya-muzhchin"))
        programs.append(Program(name: "Smart Lunch",
                                 shortDescription: "Healthy food in your office",
                                 image: UIImage(named: "program_9")!,
                                 link: "https://foodexhub.com.ua/kiev/smart-pitaniye-dlya-muzhchin"))
        programs.append(Program(name: "2 weeks with Discipline",
                                 shortDescription: "Impressive loose of weight during 14 days (right eating + trainings)",
                                 image: UIImage(named: "program_10")!,
                                 link: "https://foodexhub.com.ua/kiev/express-korrektsiya-figuri-dlya-muzhchin"))
        programs.append(Program(name: "Diet No 5",
                                 shortDescription: "Well-balanced program according to the diet “Table No 5”",
                                 image: UIImage(named: "program_11")!,
                                 link: "https://foodexhub.com.ua/kiev/stol-5-pitaniye-dlya-muzhchin"))
        programs.append(Program(name: "Diabetes Mellitus",
                                 shortDescription: "Well-balanced program according to the diet “Table No 9”",
                                 image: UIImage(named: "program_12")!,
                                 link: "https://foodexhub.com.ua/kiev/pitaniye-pri-diabete-dlya-muzhchin"))
        programs.append(Program(name: "Gluten-free Menu",
                                 shortDescription: "For those with medical prescriptions or personal desire to stick to gluten-free diet",
                                 image: UIImage(named: "program_13")!,
                                 link: "https://foodexhub.com.ua/kiev/gluten-free--dlya-muzhchin"))
        programs.append(Program(name: "Lactose Free",
                                 shortDescription: "Lactose-free ration for people with a lactose intolerance",
                                 image: UIImage(named: "program_14")!,
                                 link: "https://foodexhub.com.ua/kiev/lactose-free-dlya-muzhchin"))
        programs.append(Program(name: "For pregnant women and nursing mothers",
                                 shortDescription: "Well-balanced eating during pregnancy and breast feeding",
                                 image: UIImage(named: "program_15")!,
                                 link: "https://foodexhub.com.ua/kiev/pitaniye-dlya-beremennykh"))
        programs.append(Program(name: "Kids’ Menu “Smart Kids”",
                                 shortDescription: "For business parents who care about full-scale healthy eating of a child",
                                 image: UIImage(named: "program_16")!,
                                 link: "https://foodexhub.com.ua/kiev/detskoe-menu"))
        programs.append(Program(name: "Gift certificate",
                                 shortDescription: "Gift certificate FoodEx for your friends",
                                 image: UIImage(named: "program_17")!,
                                 link: "https://foodexhub.com.ua/kiev/zdorovoe-pitaniye-podarochnyy-sertificat"))
        programs.append(Program(name: "theBODYology",
                                 shortDescription: "Online weight loss program for women in the menu on the dietitian + video training",
                                 image: UIImage(named: "program_18")!,
                                 link: "https://foodexhub.com.ua/kiev/thebodyology-online"))
        
        
        for var program in programs {
            let programView = ProgramView(program: program)
            programsParent.addArrangedSubview(programView)
            programsViews.append(programView)
        }
        
        programsParentHeightConstraint.constant = programDefaultHeight + (programsViews[0].height + programsParent.spacing) * CGFloat(programsViews.count)
    }
}
