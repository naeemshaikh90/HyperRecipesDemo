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
import Quick
import Nimble
@testable import HyperRecipesDemo

class PostControllerSpec: QuickSpec {
  override func spec() {
    describe("PostController") {
      var controller: RecipesController!
      var apiMock: NetworkAPICalls!
      
      beforeEach {
        let testBundle = Bundle(for: type(of: self))
        let mockLoader = MockLoader(file: "Recipe", in: testBundle)
        let recipe = (mockLoader?.map(to: Recipe.self))!
        
        apiMock = NetworkAPICallsMock(recipes: [recipe])
        controller = Storyboard.Main.recipesControllerScene.viewController() as! RecipesController
        controller.apiManager = apiMock
        
        //Load view components
        let _ = controller.view
      }
      
      it("should have expected props setup") {
        controller.viewDidLoad()
        expect(controller.apiManager).toNot(beNil())
        expect(controller.collectionDatasource).toNot(beNil())
        expect(controller.collectionDelegate).toNot(beNil())
        expect(controller.recipes).toNot(beNil())
        expect(controller.collectionView).toNot(beNil())
      }
      
      it("should use mock response on fetchRecipes") {
        controller.viewDidLoad()
        let count = controller.collectionDatasource?.recipes.count ?? 0
        expect(count).toEventually(beGreaterThan(0))
      }
    }
  }
}

