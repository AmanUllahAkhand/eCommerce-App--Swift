
import Foundation

struct MyCategory: Codable {

  var 0  : String? = nil
  var 1  : String? = nil
  var 2  : String? = nil
  var 3  : String? = nil
  var 4  : String? = nil
  var 5  : String? = nil
  var 6  : String? = nil
  var 7  : String? = nil
  var 8  : String? = nil
  var 9  : String? = nil
  var 10 : String? = nil

  enum CodingKeys: String, CodingKey {

    case 0  = "0"
    case 1  = "1"
    case 2  = "2"
    case 3  = "3"
    case 4  = "4"
    case 5  = "5"
    case 6  = "6"
    case 7  = "7"
    case 8  = "8"
    case 9  = "9"
    case 10 = "10"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    0  = try values.decodeIfPresent(String.self , forKey: .0  )
    1  = try values.decodeIfPresent(String.self , forKey: .1  )
    2  = try values.decodeIfPresent(String.self , forKey: .2  )
    3  = try values.decodeIfPresent(String.self , forKey: .3  )
    4  = try values.decodeIfPresent(String.self , forKey: .4  )
    5  = try values.decodeIfPresent(String.self , forKey: .5  )
    6  = try values.decodeIfPresent(String.self , forKey: .6  )
    7  = try values.decodeIfPresent(String.self , forKey: .7  )
    8  = try values.decodeIfPresent(String.self , forKey: .8  )
    9  = try values.decodeIfPresent(String.self , forKey: .9  )
    10 = try values.decodeIfPresent(String.self , forKey: .10 )
 
  }

  init() {

  }

}