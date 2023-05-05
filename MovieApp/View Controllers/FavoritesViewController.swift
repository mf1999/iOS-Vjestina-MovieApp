import UIKit

class FavouritesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){}
    
    private func styleViews(){
        view.backgroundColor = .white
    }
    
    private func defineLayoutForViews(){}
}
