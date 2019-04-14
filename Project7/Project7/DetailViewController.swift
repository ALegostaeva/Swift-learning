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

    var planet = "No information"
    var film = "No information"
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailCharacter = detailCharacter else { return }
        
        let urlPlanet = detailCharacter.homeworld
        let urlFilms = detailCharacter.films
        
        for urlFilm in urlFilms {
            takeValueOf(urlFilm)
        }
        takeValueOf(urlPlanet)
        
        
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
        <p> Species is <b>\(detailCharacter.species)</b></p>
        <p> Vehicles: <b>\(detailCharacter.vehicles)</b></p>
        <p> Starships: <b>\(detailCharacter.starships)</b></p>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)

    }
    
    func takeValueOf(_ url: String){
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                debugPrint(data)
                parse(json: data)
            } else {debugPrint("not data")}
        } else {debugPrint("not url")}
    }

    func parse(json: Data){
        let decoder = JSONDecoder()
        
        debugPrint("here parse")
        debugPrint(json)

        
        if let json = try? decoder.decode(Planet.self, from: json) {
            planet = String(json.name)
            debugPrint("here decode")
        } else if let json = try? decoder.decode(Film.self, from: json) {
            film.append("Episod \(json.episode_id): \"\(json.title)\" ")
            debugPrint("here parse film")
        }
    }

}
