
import Foundation

struct TypeInfo: Decodable {
    var type: TypeModel
}

struct TypeModel: Decodable {
    var name: String
    var url: String
}
