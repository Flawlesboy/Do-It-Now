//
//  SoundViewController.swift
//  Are you doing anything?
//
//  Created by Загид Гусейнов on 16.04.2019.
//  Copyright © 2019 Загид Гусейнов. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sounds: [Sound] = [Sound(name: "Молния", fileName: "Молния.mp3"), Sound(name: "Волшебная палочка", fileName: "Волшебная палочка.mp3"), Sound(name: "Гром", fileName: "Гром.mp3"), Sound(name: "Рог", fileName: "Рог.mp3"), Sound(name: "Дождь", fileName: "Дождь.mp3"), Sound(name: "Аккорд", fileName: "Аккорд.mp3"), Sound(name: "Бамбук", fileName: "Бамбук.mp3"), Sound(name: "Note", fileName: "Note.mp3")]
    
    
    
    weak var delegate: SoundDelegate!
    
    
    var selectedSound: Sound!
    var player: AVAudioPlayer?
    var lastSelection: NSIndexPath!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func cancelAction(_ sender: Any) {
        player?.stop()
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func saveAction(_ sender: Any) {
        delegate.didPick(sound: selectedSound)
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func playTone(with sound: Sound) {
        guard let soundName = sound.name else { return }
        let path = Bundle.main.path(forResource: "\(soundName)", ofType : "mp3")
        let url = URL(fileURLWithPath : path!)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            print ("note\(soundName)")
            player?.play()
        }
        catch {
            print (error)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return sounds.count
        }
        
        if section == 1 {
            let cell = "Не выбран"
            
            return 1
        }
        return 1
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = sounds[indexPath.row].name
            
        }
        
        if indexPath.section == 1 {
            cell.textLabel?.text = "Не выбран"
        }
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let sound = sounds[indexPath.row]
            self.selectedSound =  sound
            playTone(with: sound)
            
        }
        
        if indexPath.section == 1 {
            self.selectedSound = nil 
            player?.stop()
        }
        
        
        if self.lastSelection != nil {
            self.tableView.cellForRow(at: self.lastSelection as IndexPath)?.accessoryType = .none
        }
        
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        self.lastSelection = indexPath as NSIndexPath
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    

   
}
