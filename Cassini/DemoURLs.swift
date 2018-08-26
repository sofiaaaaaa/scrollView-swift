//
//  DemoURLs.swift
//  Cassini
//
//  Created by 임지후 on 2018. 8. 26..
//  Copyright © 2018년 임지후. All rights reserved.
//

import Foundation

struct DemoURLs
{
    static let standard = Bundle.main.url(forResource: "oval", withExtension: "jpg")
    //static let standard = URL(string: "https://3c1703fe8d.site.internapcdn.net/newman/gfx/news/hires/2015/howbigistheu.jpg")
    
    static var NASA: Dictionary<String, URL> = {
        let NASAURLStrings = [
            "Cassini" : "https://www.nasa.gov/sites/default/files/thumbnails/image/pia21889_enceladus_figa_color-a.png",
            "Earth" : "https://www.nasa.gov/sites/default/files/thumbnails/image/pia21896_vimsimpactsite_figb_annotated_0.jpg",
            "Saturn" : "https://www.nasa.gov/sites/default/files/thumbnails/image/pia14943-full.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for(key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
