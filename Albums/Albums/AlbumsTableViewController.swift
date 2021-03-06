import UIKit

class AlbumsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var albumController: AlbumController!
    let reuseIdentifier = "AlbumTableCell"
    let cellSegue = "CellShowSegue"
    let barButtonSegue = "AddBarButtonShowSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController?.getAlbums(completion: { (error) in
            if error != nil {
                NSLog("Error fetching albums")
            }
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController?.albums.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let album = albumController?.albums[indexPath.row]
        
        cell.textLabel?.text = album?.name
        cell.detailTextLabel?.text = album?.artist
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == barButtonSegue {
            guard let destinationVC = segue.destination as? AlbumDetailTableViewController else { return }
            destinationVC.albumController = albumController
        } else if segue.identifier == cellSegue {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let album = albumController?.albums[indexPath.row],
                let destinationVC = segue.destination as? AlbumDetailTableViewController else { return }
            
            destinationVC.albumController = albumController
            destinationVC.album = album
        }
        
    }
}
