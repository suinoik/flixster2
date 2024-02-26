//
//  MoviesViewController.swift
//  FlixsterPt2
//
//
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource {
    var movies: [Movie] = []

    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
                    
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=b621411b2b2398129df227fd70dffd71")!

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            if let error = error {
                print("Network error: \(error.localizedDescription)")
            }

            guard let data = data else {
                print("Data is nil")
                return
            }

            do {
            
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesResponse.self, from: data)
                let movies = response.results
                
                DispatchQueue.main.async {
                    self?.movies = movies
                    self?.TableView.reloadData()
                }
                
                print("✅ \(movies)")
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }

        task.resume()
        print(movies)
        
        TableView.dataSource = self
         
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let cell = sender as? UITableViewCell,
           let indexPath = TableView.indexPath(for: cell),
           let detailViewController = segue.destination as? DetailViewController {
            let movie = movies[indexPath.row]
            
            detailViewController.movie = movie
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
