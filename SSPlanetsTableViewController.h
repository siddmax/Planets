//
//  SSPlanetsTableViewController.h
//  Planets
//
//  Created by Saurav Sharma on 9/15/14.
//  Copyright (c) 2014 ZineOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSAddPlanetObjectViewController.h"

@interface SSPlanetsTableViewController : UITableViewController <SSAddPlanetObjectViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *planets;
@property (strong, nonatomic) NSMutableArray *addedSpaceObjects;

@end
