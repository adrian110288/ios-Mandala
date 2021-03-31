//
//  MoodListTableViewController.swift
//  Mandala
//
//  Created by Adrian Lesniak on 04/03/2021.
//

import UIKit

class MoodListTableViewController: UITableViewController {
    
    var moodEntries: [MoodEntry] = []

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moodEntries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        let moodEntry = moodEntries[indexPath.row]
        
        cell.imageView?.image = moodEntry.mood.image
        cell.textLabel?.text = "I was \(moodEntry.mood.name)"
        
        let dateString = DateFormatter.localizedString(from: moodEntry.timestamp, dateStyle: .medium, timeStyle: .short)
        cell.detailTextLabel?.text = "on \(dateString)"
        
        return cell
    }

}

extension MoodListTableViewController: MoodsConfigurable {
    func add(_ mood: MoodEntry) {
        moodEntries.insert(mood, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}
