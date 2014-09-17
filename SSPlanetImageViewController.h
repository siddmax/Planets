//
//  SSPlanetImageViewController.h
//  Planets
//
//  Created by Saurav Sharma on 9/16/14.
//  Copyright (c) 2014 ZineOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSObjectSpace.h"

@interface SSPlanetImageViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) SSObjectSpace *spaceObject;

@end
