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


import Quick
import Nimble
@testable import HyperRecipesDemo

struct NetworkAPICallsMock: NetworkAPICalls {
  let recipes: [HyperRecipesDemo.Recipe]
  
  func recipes(completion: @escaping ([Recipe]?) -> Void) {
    completion(recipes)
  }
}

class RecipesDatasourceSpec: QuickSpec {
  override func spec() {
    describe("RecipesDatasource") {
      var controller: RecipesController!
      var recipe: HyperRecipesDemo.Recipe!
      
      beforeEach {
        let testBundle = Bundle(for: type(of: self))
        let mockLoader = MockLoader(file: "Recipe", in: testBundle)
        recipe = (mockLoader?.map(to: Recipe.self))
        
        let apiMock = NetworkAPICallsMock(recipes: [recipe])
        controller = Storyboard.Main.recipesControllerScene.viewController() as! RecipesController
        controller.apiManager = apiMock
        
        let _ = controller.view
      }
      
      it("should have a valid datasource") {
        expect(controller.collectionDatasource).toNot(beNil())
      }
      
      it("should have a cell of expected type") {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = controller.collectionDatasource!.collectionView(controller.collectionView, cellForItemAt: indexPath)
        expect(cell.isKind(of: RecipeCell.self)).to(beTruthy())
      }
      
      it("should have a configured cell") {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = controller.collectionDatasource!.collectionView(controller.collectionView, cellForItemAt: indexPath) as! RecipeCell
        let name = cell.titleLabel.text!
        expect(name).to(equal(recipe.name))
      }
      
      it("should have the right numberOfItemsInSection") {
        let count = controller.collectionDatasource!.collectionView(controller.collectionView, numberOfItemsInSection: 0)
        expect(count).to(beGreaterThan(0))
      }
    }
  }
}
