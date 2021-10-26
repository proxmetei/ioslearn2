//
//  OneArcticleController.swift
//  iosLab2
//
//  Created by Алексей on 20.10.2021.
//

import UIKit
import SafariServices

class OneArcticleController: UIViewController {

    var index = 0
    var arcticle: Arcticle!
    static var imageCache = NSCache<NSString, UIImage>()
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    private var image: UIImage?{
        didSet{
            DispatchQueue.main.async { 
                self.ImageView.image = self.image
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
            }
        }
    }
    @IBOutlet weak var labelDescription: UILabel!
    @IBAction func pushSafari(_ sender: Any) {
        if let url = URL(string: arcticle.url){
        let svc = SFSafariViewController(url: url )
        present(svc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
        labelTitle.text = arcticle.title
        labelDescription.text = arcticle.description
        DispatchQueue.global(qos: .userInteractive).async {
           
            if let url = URL(string: self.arcticle.image){
                let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
                if let cachedImage = OneArcticleController.imageCache.object(forKey: self.arcticle.image as NSString){
                    self.image = cachedImage
                }
                else{
                    let dataTask = URLSession.shared.dataTask(with: request){ data, response, error in
                     
                            if let img = UIImage(data: data!){
                                OneArcticleController.imageCache.setObject(img, forKey: self.arcticle.image as NSString)
                            self.image = img
                            }
                        
                    
               
                }
                    dataTask.resume()
                }
            }
        }
      
        // Do any additional setup after loading the view.
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
