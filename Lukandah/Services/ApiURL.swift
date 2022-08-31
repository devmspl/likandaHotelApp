//
//  ApiURL.swift
//  Lukandah
//
//  Created by Macbook Air (ios) on 14/06/22.
//

import Foundation

public var baseUrl = "http://93.188.167.68:8006/api/"

public struct Api {
    public static var Login = baseUrl + "users/login"
    public static var Signup = baseUrl + "users/create"
    public static var Getprofile = baseUrl + "users/profile/"
    public static var Gethotel = baseUrl + "hotels/getHotels/"
    public static var Gethotelbyid = baseUrl + "hotels/getHotelById/"
    public static var Usersupdate = baseUrl + "users/update/"
    public static var Getuserprofile = baseUrl + "users/profile/"
    public static var ResetPassword = baseUrl + "users/resetPassword/"
    public static var SearchHotels = baseUrl + "hotels/search?name="
    public static var RatingReviews = baseUrl + "hotels/ratingReview"
    public static var Hotelsbyfilter = baseUrl + "hotels/byFilter?"
    public static var UserLogout = baseUrl + "users/logout"
    public static var UserOTP = baseUrl + "users/otp?email="
    public static var Otpverify = baseUrl + "users/otpVerify"
    public static var Forgotpassword = baseUrl + "users/forgotPassword"
}
 
