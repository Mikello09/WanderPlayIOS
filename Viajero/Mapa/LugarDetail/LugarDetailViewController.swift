//
//  LugarDetailViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 25/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class LugarDetailViewController: BaseViewController{
    
    var presenter: LugarDetailPresenter!
    
    var images: [CustomScrollView] = []
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollContainer: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var descripcion: UITextView!
    @IBOutlet var topBar: TopBarOnlyBack!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.getLugar()
        
    }
    
    func setUpBackground(lugar: Lugar){
        
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 3
        
        switch lugar.getTipoLugar() {
            case .bajo:
                //self.view.backgroundColor = Colors.verdeTransparente
                containerView.layer.borderColor = Colors.verde.cgColor
            case .medio:
                //self.view.backgroundColor = Colors.azulTransparente
                containerView.layer.borderColor = Colors.azul.cgColor
            case .alto:
                //self.view.backgroundColor = Colors.amarilloTransparente
                containerView.layer.borderColor = Colors.amarillo.cgColor
            case .muyAlto:
                //self.view.backgroundColor = Colors.naranjaTransparente
                containerView.layer.borderColor = Colors.naranja.cgColor
            case .patrimonio:
                //self.view.backgroundColor = Colors.rojoTransparente
                containerView.layer.borderColor = Colors.rojo.cgColor
        }
        
        containerView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.2)
        
        
    }
    
    func setUpView(lugar: Lugar){
        descripcion.text = lugar.descripcion
    }
    
    func setUpScrollView(lugar: Lugar){
        scrollView.delegate = self
        images = presenter.createImages(lugar: lugar)
        setupSlideScrollView()
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        switch lugar.getTipoLugar() {
            case .bajo:
                pageControl.currentPageIndicatorTintColor = Colors.verde
            case .medio:
                pageControl.currentPageIndicatorTintColor = Colors.azul
            case .alto:
                pageControl.currentPageIndicatorTintColor = Colors.amarillo
            case .muyAlto:
                pageControl.currentPageIndicatorTintColor = Colors.naranja
            case .patrimonio:
                pageControl.currentPageIndicatorTintColor = Colors.rojo
        }
        self.view.bringSubviewToFront(pageControl)
    }
    
    func setupSlideScrollView() {
        let screenWidth = UIScreen.main.bounds.width - 32
        scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: scrollContainer.frame.height)
        scrollView.contentSize = CGSize(width: screenWidth * CGFloat(images.count), height: scrollContainer.frame.height)
        scrollView.isPagingEnabled = true
        
        
        for i in 0 ..< images.count {
            images[i].frame = CGRect(x: screenWidth * CGFloat(i), y: 0, width: screenWidth, height: scrollContainer.frame.height)
            scrollView.addSubview(images[i])
        }
    }
}

extension LugarDetailViewController: LugarDetailProtocol{
    
    func lugarObtained(lugar: Lugar){
        topBar.setTitle(title: lugar.nombre ?? "")
        topBar.delegate = self
        
        setUpBackground(lugar: lugar)
        setUpScrollView(lugar: lugar)
        setUpView(lugar: lugar)
    }
    
    func errorInGettingLugar(){
        
    }
}

extension LugarDetailViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension LugarDetailViewController: TopBarOnlyBackProtocol{
    func atrasClicked() {
        self.dismiss(animated: false, completion: nil)
    }
}
