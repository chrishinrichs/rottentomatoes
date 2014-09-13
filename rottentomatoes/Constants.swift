//
//  Constants.swift
//  rottentomatoes
//
//  Created by CHRISTOPHER HINRICHS on 9/11/14.
//  Copyright (c) 2014 CHRISTOPHER HINRICHS. All rights reserved.
//

import Foundation

let RT_API_KEY = "wdz62bwdgav3jzftyq3pqhuq"
let RT_BASE_URL = "http://api.rottentomatoes.com/api/public/v1.0/"
let RT_TOP_RENTALS = RT_BASE_URL + "lists/dvds/top_rentals.json?apikey=" + RT_API_KEY
let RT_BOX_OFFICE = RT_BASE_URL + "lists/movies/box_office.json?apikey=" + RT_API_KEY + "&limit=50&country=us"