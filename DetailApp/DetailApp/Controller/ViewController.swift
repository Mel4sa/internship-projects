import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var products: [MockProduct] = [
        MockProduct(title: "Swift", description: "Swift güçlü ve modern bir programlama dilidir.", image: UIImage(systemName: "swift") ?? UIImage()),
        MockProduct(title: "Xcode", description: "Xcode, Apple’ın resmi IDE’sidir.", image: UIImage(systemName: "hammer.fill") ?? UIImage()),
        MockProduct(title: "UIKit", description: "UIKit ile iOS arayüzleri oluşturabilirsiniz.", image: UIImage(systemName: "rectangle.3.offgrid.bubble.left") ?? UIImage()),
        MockProduct(title: "Python", description: "Python kolay öğrenilen, popüler bir programlama dilidir.", image: UIImage(systemName: "terminal.fill") ?? UIImage()),
        MockProduct(title: "JavaScript", description: "JavaScript web için vazgeçilmez bir dildir.", image: UIImage(systemName: "globe") ?? UIImage()),
        MockProduct(title: "Java", description: "Java, nesne yönelimli ve platform bağımsız bir dildir.", image: UIImage(systemName: "cup.and.saucer.fill") ?? UIImage()),

            MockProduct(title: "Kotlin", description: "Kotlin, Android geliştirme için modern bir dildir.", image: UIImage(systemName: "bolt.fill") ?? UIImage()),

            MockProduct(title: "C#", description: "C# .NET uygulamaları için kullanılan güçlü bir dildir.", image: UIImage(systemName: "c.circle") ?? UIImage()),

            MockProduct(title: "Go", description: "Go, Google tarafından geliştirilen verimli ve hızlı bir dildir.", image: UIImage(systemName: "hare.fill") ?? UIImage()),

            MockProduct(title: "Rust", description: "Rust, bellek güvenliğiyle öne çıkan sistem programlama dilidir.", image: UIImage(systemName: "shield.lefthalf.filled") ?? UIImage()),

            MockProduct(title: "TypeScript", description: "TypeScript, JavaScript’in tip güvenli halidir.", image: UIImage(systemName: "doc.text.fill") ?? UIImage()),

            MockProduct(title: "Ruby", description: "Ruby, özellikle web geliştirme için kullanılan dinamik bir dildir.", image: UIImage(systemName: "diamond.fill") ?? UIImage()),

            MockProduct(title: "PHP", description: "PHP, dinamik web siteleri için yaygın olarak kullanılır.", image: UIImage(systemName: "curlybraces") ?? UIImage())
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell

        let product = products[indexPath.row]
        cell.titleLabel.text = product.title
        cell.productImageView.image = product.image
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        performSegue(withIdentifier: "toSecondVC", sender: selectedProduct)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! SecondViewController
            if let selectedProduct = sender as? MockProduct {
                destinationVC.productTitle = selectedProduct.title
                destinationVC.productDescription = selectedProduct.description
            }
        }
    }
}
