//
//  PostersViewController.swift
//  FlixsterPt2
//
//


import UIKit
import Nuke

class PostersViewController: UIViewController, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        let poster = posters[indexPath.item]
        let imageUrl =  URL(string: "https://image.tmdb.org/t/p/w185" + poster.poster_path)!
        Nuke.loadImage(with: imageUrl, into: cell.posterImageView)
        return cell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var posters: [Movie] = []
    
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
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(MoviesResponse.self, from: data)
                
                let posters = response.results
                
                print(posters)
                
                DispatchQueue.main.async {
                    self?.posters = posters
                    self?.collectionView.reloadData()
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
        
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        let numberOfColumns: CGFloat = 3
        
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns
        layout.itemSize = CGSize(width: width, height: width)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            if let cell = sender as? UICollectionViewCell,
               let indexPath = collectionView.indexPath(for: cell),
               let detailViewController = segue.destination as? DetailViewController {
               let movie = posters[indexPath.row]
                
                detailViewController.movie = movie

                }
        }
    
}




