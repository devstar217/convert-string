import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var languageSelector: UISegmentedControl!

    var arrSentences = [""]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        inputTextView.layer.borderWidth = 1.0
        inputTextView.layer.borderColor = UIColor.gray.cgColor

        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)

        tableview.dataSource = self
        tableview.delegate = self
    }


    @IBAction func onConvert(_ sender: Any) {

        arrSentences.removeAll()

        let input = inputTextView.text ?? ""

        let keyword1 = languageSelector.selectedSegmentIndex == 0 ? "and" : "Si"
        let keyword2 = languageSelector.selectedSegmentIndex == 0 ? "if" : "Y"

        let arr1 = input.components(separatedBy: keyword1)
        arr1.forEach { sentence in
            if (!sentence.contains(keyword2)) {
                arrSentences.append(sentence.trimmingCharacters(in: .whitespacesAndNewlines))
            } else {
                let arr2 = sentence.components(separatedBy: keyword2)
                arr2.forEach { s in
                    arrSentences.append(s.trimmingCharacters(in: .whitespacesAndNewlines))
                }
            }
        }

        tableview.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSentences.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrSentences[indexPath.row]

        return cell
    }

}
