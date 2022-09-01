
import Foundation

struct Rating: Codable {

  var rate  : Double? = nil
  var count : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case rate  = "rate"
    case count = "count"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    rate  = try values.decodeIfPresent(Double.self , forKey: .rate  )
    count = try values.decodeIfPresent(Int.self    , forKey: .count )
 
  }

  init() {

  }

}