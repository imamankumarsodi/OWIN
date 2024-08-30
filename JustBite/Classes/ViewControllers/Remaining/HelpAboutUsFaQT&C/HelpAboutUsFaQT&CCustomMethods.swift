
//
//  HelpAboutUsFaQT&CCustomMethods.swift
//  JustBite
//
//  Created by Aman on 11/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import WebKit

extension HelpAboutUsFaQT_CVC:WKNavigationDelegate{
    
    //TODO: Initial Setup
    
    internal func initialSetup(){
        webView_Setup()
        //   update()
    }
    
    //TODO: Update UI
    
    fileprivate func update(){
        hideKeyboardWhenTappedAround()
        lblContent.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 18)
        lblContent.textColor = AppColor.textColor
        lblContent.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\nIt was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
    }
    
    //TODO: Navigation setup
    
    internal func navigationSetup(){
        
        super.hideNavigationBar(false)
        super.transparentNavigation()
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        if comingFrom == "AboutUs"{
            super.setupNavigationBarTitle("About Us", leftBarButtonsType: [.menu], rightBarButtonsType: [])
        }
        else if comingFrom == "FAQ"{
            super.setupNavigationBarTitle("FAQ's", leftBarButtonsType: [.menu], rightBarButtonsType: [])
        }
        else if comingFrom == "Help"{
            super.setupNavigationBarTitle("Help", leftBarButtonsType: [.menu], rightBarButtonsType: [])
        }else if comingFrom == "Stories"{
            super.setupNavigationBarTitle("Customer Stories", leftBarButtonsType: [.menu], rightBarButtonsType: [])
        }
        else{
            super.setupNavigationBarTitle("Terms & Conditions", leftBarButtonsType: [.menu], rightBarButtonsType: [])
        }
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: HelpAboutUsFaQT_CVC.className)
    }
    
    
    
    func webView_Setup() {
        
        if comingFrom == "AboutUs"{
            
            print(weblinks)
            guard  let url = URL(string: weblinks) else{
                return
            }
            print(url)
            let requestObj = URLRequest(url: url)
            
            
            webView = WKWebView(frame: self.view.frame)
            webView.navigationDelegate = self
            webView.load(requestObj)
            self.view.addSubview(webView)
            self.view.sendSubviewToBack(webView)
        }
        else if comingFrom == "Terms"{
            print(weblinks)
            guard  let url = URL(string: weblinks) else{
                return
            }
            print(url)
            let requestObj = URLRequest(url: url)
            
            webView = WKWebView(frame: self.view.frame)
            webView.navigationDelegate = self
            webView.load(requestObj)
            self.view.addSubview(webView)
            self.view.sendSubviewToBack(webView)
        }
        else if comingFrom == "FAQ"{
            let url = URL(string: weblinks)
            let requestObj = URLRequest(url: url!)
            webView = WKWebView(frame: self.view.frame)
            webView.navigationDelegate = self
            webView.load(requestObj)
            self.view.addSubview(webView)
            self.view.sendSubviewToBack(webView)
        }
        else{
            let url = URL(string: weblinks)
            let requestObj = URLRequest(url: url!)
            
            webView = WKWebView(frame: self.view.frame)
            webView.navigationDelegate = self
            webView.load(requestObj)
            self.view.addSubview(webView)
            self.view.sendSubviewToBack(webView)
        }
    }
    
    
    //MARK:- WKNavigationDelegate
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
        macroObj.showLoader(view: view)
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        self.macroObj.hideLoader(view: self.view)
        //  CustomMethods.shared.hideLoader(view: self.view, nav:(self.navigationController?.navigationBar)!)
    }
    
}
