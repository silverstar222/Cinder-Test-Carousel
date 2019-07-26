//
//  SCPageControl_normal.swift
//  Pods
//
//  Created by Myoung on 2017. 4. 27..
//
//

import UIKit

class SCP_SCNormal: UIView {

    var numberOfPage: Int = 0, currentOfPage: Int = 0
    var f_start_point: CGFloat = 0.0, f_start: CGFloat = 0.0
    
    var screenWidth : CGFloat = UIScreen.main.bounds.size.width
    var screenHeight : CGFloat = UIScreen.main.bounds.size.height
    
    var currentColor = UIColor.red
    var disableColor: UIColor?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // ## view init method ##
    func set_view(_ page: Int, current: Int, current_color: UIColor, disable_color: UIColor?) {
        
        numberOfPage = page
        currentOfPage = current
        currentColor = current_color
        disableColor = disable_color
        
        let f_all_width: CGFloat = CGFloat((numberOfPage-1)*20 + 25)
        
        guard f_all_width < self.frame.size.width else {
            print("frame.Width over Number Of Page")
            return
        }
        
        var f_width: CGFloat = 10.0, f_height: CGFloat = 10.0
        var f_x: CGFloat = (self.frame.size.width-f_all_width)/2.0, f_y: CGFloat = (self.frame.size.height-f_height)/2.0
        
        f_start_point = f_x
        
        for i in 0 ..< numberOfPage {
            let img_page = UIImageView()
            
            if i == currentOfPage {
                f_width = 25.0
                //img_page.alpha = 1.0
                img_page.backgroundColor = currentColor
                
            } else {
                f_width = 10.0
                //img_page.alpha = 0.4
                if disableColor != nil {
                    img_page.backgroundColor = disableColor
                } else {
                    img_page.backgroundColor = currentColor
                }                
            }            
            
            img_page.frame = CGRect(x: f_x, y: f_y, width: f_width, height: f_height)
            img_page.layer.cornerRadius = img_page.frame.size.height/2.0
            img_page.tag = i+10
            self.addSubview(img_page)
            
            f_x += f_width + 10
        }        
    }
    
    // ## Call the move page in scrollView ##
    func scroll_did(_ scrollView: UIScrollView) {
        
        let f_page = scrollView.contentOffset.x / scrollView.frame.size.width
//        print("Flapha value:\(f_page.frame.width)")
        let tag_value = get_imgView_tag(f_page)+10
        let f_next_start: CGFloat = (CGFloat(tag_value-10) * scrollView.frame.size.width)
        
        let f_move: CGFloat = (15*(f_start-scrollView.contentOffset.x)/scrollView.frame.size.width)
        let f_alpha: CGFloat = (0.6*(scrollView.contentOffset.x-f_next_start)/scrollView.frame.size.width)
        
        
        
        if f_page == 0.0 {
            if let iv_page: UIImageView = self.viewWithTag(10) as? UIImageView, disableColor != nil { //0.3.1 Add disable color
                iv_page.backgroundColor = currentColor
            }            
        }
        
        if let iv_page: UIImageView = self.viewWithTag(tag_value) as? UIImageView,
            tag_value >= 10 && tag_value+1 < 10+numberOfPage {
            
            iv_page.frame = CGRect(x: f_start_point+((CGFloat(tag_value)-10)*20),
                                   y: iv_page.frame.origin.y,
                                   width: 25+(f_move+((CGFloat(tag_value)-10)*15)),
                                   height: iv_page.frame.size.height)
            //iv_page.alpha = 1-f_alpha
            /*print("Flapha value:\(iv_page.frame.width)")
            let iv_per = (iv_page.frame.width-10)/(25)
            let ColorValueR = (1-iv_per)*2.12
            let ColorValueG = (1-iv_per)*0.97
            let ColorValueB = (1-iv_per)*0.75
            print("iv_per value:\((1-iv_per)*2.12)")
            let color1 = UIColor(red: 217*ColorValueR/255.0, green: 217*ColorValueG/255.0, blue: 217*ColorValueB/255.0, alpha: 1.00)
            let color2 = UIColor(red: 217*(ColorValueR+1)/255.0, green: 217*(ColorValueG+1)/255.0, blue: 217*(ColorValueB+1)/255.0, alpha: 1.00)
            iv_page.backgroundColor = color1*/
           
            if 1-f_alpha < 0.42 && disableColor != nil { //0.3.1 Add disable color
                iv_page.backgroundColor = disableColor
            }
            
            if let iv_page_next: UIImageView = self.viewWithTag(tag_value+1) as? UIImageView {
                let f_page_next_x: CGFloat = ((f_start_point+35)+((CGFloat(tag_value)-10)*20))
                iv_page_next.frame = CGRect(x: f_page_next_x+(f_move+((CGFloat(tag_value)-10)*15)),
                                            y: iv_page_next.frame.origin.y,
                                            width: 10-(f_move+((CGFloat(tag_value)-10)*15)),
                                            height: iv_page_next.frame.size.height)
                //iv_page_next.alpha = 0.4+f_alpha
                /*iv_page_next.backgroundColor = color2
                print("Nlapha value:\(iv_page_next.frame.width)")*/
                if disableColor != nil { //0.3.1 Add disable color
                    if 0.98 < f_alpha+0.4  {
                        iv_page_next.backgroundColor = currentColor
                    } else {
                        iv_page_next.backgroundColor = disableColor
                    }                    
                }
            }
        }
    }
    
    // ## return ImageView tag number ##
    func get_imgView_tag(_ f_page: CGFloat) -> Int {
        let f_temp = f_page - 0.02
        return Int(f_temp)
    }
    
    // ## Call the moment in rotate Device ##
    func set_rotateDevice(_ frame: CGRect) {
        self.frame = frame
        let f_all_width: CGFloat = CGFloat((numberOfPage-1)*20 + 25)
        var f_x: CGFloat = (self.frame.size.width-f_all_width)/2.0
        
        f_start_point = f_x
        
        for subview in self.subviews {
            if subview.isKind(of: UIImageView.classForCoder()) {
                subview.frame.origin.x = f_x
                f_x += subview.frame.size.width + 10
            }
        }
    }
}

extension UIColor {
    func interpolateRGBColorTo(_ end:UIColor,fraction: CGFloat) -> UIColor? {
        let f = min(max(0, fraction), 1)
        
        guard let c1 = self.cgColor.components,
            let c2 = end.cgColor.components else { return nil }
        
        let r: CGFloat = CGFloat(c1[0] + (c2[0] - c1[0]) * f)
        let g: CGFloat = CGFloat(c1[1] + (c2[1] - c1[1]) * f)
        let b: CGFloat = CGFloat(c1[2] + (c2[2] - c1[2]) * f)
        let a: CGFloat = CGFloat(c1[3] + (c2[3] - c1[3]) * f)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
