//
//  REST.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 4/23/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

enum Operation {
    case Post
    case Put
    case Delete
    case Get
    case GetById([Int])
}

enum Either {
    case Status(StatusCode)
    case Object(AnyObject)
}

enum Remote {
    case User
    case Post
    case Wiki
    case Stat
}

enum StatusCode : Int {
    case Offline                      = 000
    case Continue                     = 100
    case SwitchingProtocols           = 101
    case Ok                           = 200
    case Created                      = 201
    case Accepted                     = 202
    case NonAuthoritativeInformation  = 203
    case NoContent                    = 204
    case ResetContent                 = 205
    case PartialContent               = 206
    case MultipleChoices              = 300
    case MovedPermanently             = 301
    case Found                        = 302
    case SeeOther                     = 303
    case NotModified                  = 304
    case UseProxy                     = 305
    case TemporaryRedirect            = 307
    case BadRequest                   = 400
    case Unauthorized                 = 401
    case PaymentRequired              = 402
    case Forbidden                    = 403
    case NotFound                     = 404
    case MethodNotAllowed             = 405
    case NotAcceptable                = 406
    case ProxyAuthenticationRequired  = 407
    case RequestTimeOut               = 408
    case Conflict                     = 409
    case Gone                         = 410
    case LengthRequired               = 411
    case PreconditionFailed           = 412
    case RequestEntityTooLarge        = 413
    case RequestURITooLarge           = 414
    case UnsupportedMediaType         = 415
    case RequestedRangeNotSatisfiable = 416
    case ExpectationFailed            = 417
    case InternalServerError          = 500
    case NotImplemented               = 501
    case BadGateway                   = 502
    case ServiceUnavailable           = 503
    case GatewayTimeOut               = 504
    case HTTPVersionNotSupported      = 505
    case NoNewPosts                   = 999
    
}