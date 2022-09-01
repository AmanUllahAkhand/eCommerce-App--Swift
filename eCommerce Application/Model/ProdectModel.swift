
import Foundation

struct ProdectModel: Codable {

  var id          : Int?    = nil
  var title       : String? = nil
  var price       : Double? = nil
  var description : String? = nil
  var category    : String? = nil
  var image       : String? = nil
  var rating      : Rating? = Rating()

  enum CodingKeys: String, CodingKey {

    case id          = "id"
    case title       = "title"
    case price       = "price"
    case description = "description"
    case category    = "category"
    case image       = "image"
    case rating      = "rating"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id          = try values.decodeIfPresent(Int.self    , forKey: .id          )
    title       = try values.decodeIfPresent(String.self , forKey: .title       )
    price       = try values.decodeIfPresent(Double.self , forKey: .price       )
    description = try values.decodeIfPresent(String.self , forKey: .description )
    category    = try values.decodeIfPresent(String.self , forKey: .category    )
    image       = try values.decodeIfPresent(String.self , forKey: .image       )
    rating      = try values.decodeIfPresent(Rating.self , forKey: .rating      )
 
  }

  init() {

  }

}
