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

import UIKit
import RealmSwift
import SVProgressHUD


protocol RecipesDelegate {
  func didSelectRecipe(at index: IndexPath)
}

class RecipesController: UIViewController {
  
  var apiManager: NetworkAPICalls = NetworkAPIManager()
  var recipes: [Recipe] = []
  
  var refreshControl = UIRefreshControl()
  var dateFormatter = DateFormatter()
  var lastUpdate = Date()
  
  var collectionDatasource: RecipesDatasource?
  var collectionDelegate:   RecipesCollectionDelegate?
  
  @IBOutlet weak var collectionView: UICollectionView!
}

extension RecipesController {
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchSavePosts()
    if recipes.isEmpty {
      fetchRecipes()
    }
  }
}

extension RecipesController {
  func fetchRecipes() {
    if CommonUtility.isConnected() {
      SVProgressHUD.show()
      apiManager.recipes() { recipes in
        SVProgressHUD.dismiss()
        if let recipes = recipes {
          self.setupCollectionView(with: recipes)
        }
      }
    } else {
      CommonUtility.showNotConnected()
    }
  }
  
  func fetchSavePosts() {
    do {
      let realm = try Realm()
      let offlineRecipes = realm.objects(Recipe.self)
      for offlineRecipe in offlineRecipes {
        recipes.append(offlineRecipe)
      }
      
      if !recipes.isEmpty {
        self.setupCollectionView(with: recipes)
      }
    } catch let error as NSError {
      CommonUtility.showError(error)
    }
  }
}

extension RecipesController {
  func setupCollectionView(with recipes: [Recipe]) {
    collectionDelegate = RecipesCollectionDelegate(self)
    collectionDatasource = RecipesDatasource(recipes: recipes,
                                             collectionView: self.collectionView,
                                             delegate: collectionDelegate!)
  }
}

extension RecipesController: RecipesDelegate {
  func didSelectRecipe(at index: IndexPath) {
    
  }
}
