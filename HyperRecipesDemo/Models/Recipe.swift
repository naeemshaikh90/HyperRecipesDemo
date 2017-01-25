/**
 * Copyright © 2017-present Naeem Shaikh
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import ObjectMapper
import RealmSwift

class Recipe: Object {
  
  dynamic var createdAt: String = ""
  dynamic var descriptionField: String = ""
  dynamic var difficulty: Int = 0
  dynamic var favorite: Bool = false
  dynamic var id: Int = 0
  dynamic var instructions: String = ""
  dynamic var name: String = ""
  dynamic var updatedAt: String = ""
  dynamic var userId: Int = 0
  dynamic var timeSaved = Date()
  dynamic var photo: Photo!

  required convenience init(map: Map) {
    self.init()
  }
}

extension Recipe: Mappable {
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  func mapping(map: Map) {
    createdAt         <- map["created_at"]
    descriptionField  <- map["description"]
    difficulty        <- map["difficulty"]
    favorite          <- map["favorite"]
    id                <- map["id"]
    instructions      <- map["instructions"]
    name              <- map["name"]
    photo             <- map["photo"]
    updatedAt         <- map["updated_at"]
    userId            <- map["user_id"]
    timeSaved         <- map["timeSaved"]
  }
}
