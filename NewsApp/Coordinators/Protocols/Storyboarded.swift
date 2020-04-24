//
//  Storyboarded.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

//This protocol is to make VC easier to instantiate from storyboard
protocol Storyboarded {
    static func instantiate() -> Self //whatever conforms to this protocol will have instantiate method on the type itself, that when called will return the type
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self { //this allows us to create VC in a storyboard the same storyboard id as their class name (filename and class name must match)
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: id) as! Self //this is safe because the VC class must always match its storyboard Id
    }
}
