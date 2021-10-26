//
//  ArcticlePageViewController.swift
//  iosLab2
//
//  Created by Алексей on 21.10.2021.
//

import UIKit

class ArcticlePageViewController: UIPageViewController, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
     let index  = ((viewController as? OneArcticleController)?.index ?? 0) - 1
        return self.pageViewController(for: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index  = ((viewController as? OneArcticleController)?.index ?? 0) + 1
           return self.pageViewController(for: index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        loadArcs{
            self.ShowViewControllers()
            }
        }
        
    func ShowViewControllers() {
        DispatchQueue.main.async {
            if let vc = self.pageViewController(for: 0){
            self.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func refreshPageAction(_ sender: Any) {
        loadArcs{
            DispatchQueue.main.async {
                if let vc = self.pageViewController(for: 0){
                self.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
                }
            }
            }
    }
    
    func pageViewController( for index: Int) -> OneArcticleController?{
        if index<0 || index>=arcticles.count{
            return nil
        }
        let  vc = (storyboard?.instantiateViewController(withIdentifier: "oneArcticleSID") as! OneArcticleController)
        vc.arcticle =  arcticles[index]
        vc.index  = index
        return vc
    }
}
