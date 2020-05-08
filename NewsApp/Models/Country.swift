//
//  Country.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/8/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

enum Country: String {
    case ae = "United Arab Emirates", ar = "Argentina", at = "Austria", au = "Australia",
    be = "Belgium", bg = "Bulgaria", br = "Brazil",
    ca = "Canada", ch = "Chile", cn = "China", co = "Colombia", cu = "Cuba", cz = "Czechia",
    de = "Denmark", eg = "Egypt", fr = "France",
    gb = "United Kingdom of Great Britain and Northern Ireland", gr = "Greece",
    hk = "HongKong", hu = "Hungary", id = "Indonesia", ie = "Ireland", il = "Israel", `in` = "India", it = "Italy",
    jp = "Japan", kr = "Korea", lt = "Lithuania", lv = "Latvia", ma = "Morocco", mx = "Mexico", my = "Malaysia",
    ng = "Nigeria", nl = "Netherlands", no = "Norway", nz = "New Zealand",
    ph = "Philippines", pl = "Poland", pt = "Portugal", ro = "Romania", rs = "Serbia", ru = "Russia Federation",
    sa = "Saudi Arabia", se = "Sweden", sg = "Singapore", si = "Slovenia", sk = "Slovakia",
    th = "Thailand", tr = "Turkey", tw = "Taiwan", ua = "Ukraine", us = "United States of America",
    ve = "Venezuela", za = "South Africa"
}

extension Country: CaseIterable { //to be able to use Category.allCases
}
