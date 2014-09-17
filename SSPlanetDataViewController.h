//
//  SSPlanetDataViewController.h
//  Planets
//
//  Created by Saurav Sharma on 9/16/14.
//  Copyright (c) 2014 ZineOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSObjectSpace.h"

@interface SSPlanetDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SSObjectSpace *spaceObject;

@end
