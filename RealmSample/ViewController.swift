import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        items = getAllItems()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }
    
    @IBAction func allTapped(_ sender: Any) {
        items = getAllItems()
        tableView.reloadData()
    }
    @IBAction func under20Tapped(_ sender: Any) {
        items = getUnderAge(age: 20)
        tableView.reloadData()
    }
    @IBAction func moreThan25Tapped(_ sender: Any) {
        items = getOverAge(age: 25)
        tableView.reloadData()
    }
    @IBAction func betweenTapped(_ sender: Any) {
        items = getAgeBetween(min: 10, max: 20)
        tableView.reloadData()
    }
    @IBAction func equalSuzukiTapped(_ sender: Any) {
        items = getNameEquals(name: "鈴木")
        tableView.reloadData()
    }
    @IBAction func startSuzuTapped(_ sender: Any) {
        items = getNameStartWith(name: "鈴")
        tableView.reloadData()
    }
    @IBAction func endFujiTapped(_ sender: Any) {
        items = getNameEndWith(name: "藤")
        tableView.reloadData()
    }
    
    @IBAction func adminTapped(_ sender: Any) {
        items = getIsAdmin(true)
        tableView.reloadData()
    }
    @IBAction func suzuki21Tapped(_ sender: Any) {
        items = getNameAndAge(name: "鈴木", age: 21)
        tableView.reloadData()
    }
    @IBAction func suzukiOr25(_ sender: Any) {
        items = getNameOrAge(name: "鈴木", age: 25)
        tableView.reloadData()
    }
    @IBAction func notEndWithFujiTapped(_ sender: Any) {
        items = getNotNameEndWith(name: "藤")
        tableView.reloadData()
    }
    
}

private extension ViewController {
    
    func getAllItems() -> [Person] {
        
        return Person.query(q: Person.Query.all)
    }
    
    func getNameEquals(name: String) -> [Person] {
        
        return Person.query(q: Person.Query.nameEqual(name))
    }
    
    func getNameStartWith(name: String) -> [Person] {
        
        return Person.query(q: Person.Query.nameStartWith(name))
    }

    func getNameEndWith(name: String) -> [Person] {
        
        return Person.query(q: Person.Query.nameEndWith(name))
    }
    
    func getOverAge(age: Int) -> [Person] {
        return Person.query(q: Person.Query.overAge(age))
    }
  
    func getUnderAge(age: Int) -> [Person] {
        return Person.query(q: Person.Query.underAge(age))
    }

    func getAgeBetween(min: Int, max: Int) -> [Person] {
        return Person.query(q: Person.Query.ageBetween(min, max))
    }
    
    func getIsAdmin(_ isAdmin: Bool) -> [Person] {
        return Person.query(q: Person.Query.admin(isAdmin))
    }
    
    func getNameAndAge(name: String, age: Int) -> [Person] {
        return Person.query(q: Person.Query.nameAndAge(name, age))
    }

    func getNameOrAge(name: String, age: Int) -> [Person] {
        return Person.query(q: Person.Query.nameOrAge(name, age))
    }
    
    func getNotNameEndWith(name: String) -> [Person] {
        return Person.query(q: Person.Query.notNameEndWith(name))
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "\(item.age)歳"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
}
