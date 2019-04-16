//
//  DetailViewController.swift
//  Project7
//
//  Created by Александра Легостаева on 14/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailCharacter: Character?

//    there are always a value.
    var planet = ""
    var film = ""
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailCharacter = detailCharacter else { return }
        
        
        planet = takeValueOf(detailCharacter.homeworld)
        for url in detailCharacter.films {
            film += "\(takeValueOf(url));"
        }
        
        
        
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        <p> Name is <b>\(detailCharacter.name)</b></p>
        <p> Birth day is <b>\(detailCharacter.birth_year)</b></p>
        <p> Height is <b>\(detailCharacter.height)</b></p>
        <p> Mass is <b>\(detailCharacter.mass)</b></p>
        <p> Hair color is <b>\(detailCharacter.hair_color)</b></p>
        <p> Skin color is <b>\(detailCharacter.skin_color)</b></p>
        <p> Eye color is <b>\(detailCharacter.eye_color)</b></p>
        <p> Gender is <b>\(detailCharacter.gender)</b></p>
        <p> Homeworld is <b>\(planet)</b></p>
        <p> Films: <b>\(film)</b></p>

        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)

    }
    
// convert string to url and call parse func to get a value
    func takeValueOf(_ url: String) -> String{
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
//              call func parse
                return parse(json: data)
            } else {
                return "No Information"
            }
        } else {
            return "No information"
        }
    }
    
//    takes json information and unwrappes as a struct

    func parse(json: Data) -> String {
        let decoder = JSONDecoder()
        
        if let json = try? decoder.decode(Planet.self, from: json) {
//          parse planet
            return String(json.name)
        } else if let json = try? decoder.decode(Film.self, from: json) {
//          parse episode
            return "Episode \(json.episode_id): \(json.title)"
        } else {
            return "No information"
        }
    }

}
