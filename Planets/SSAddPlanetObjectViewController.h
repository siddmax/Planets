//
//  SSAddPlanetObjectViewController.h
//  Planets
//
//  Created by Saurav Sharma on 9/16/14.
//  Copyright (c) 2014 ZineOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSObjectSpace.h"

@protocol SSAddPlanetObjectViewControllerDelegate <NSObject>

@required

-(void)addPlanetObject:(SSObjectSpace *) planetObject;
-(void)didCancel;

@end

@interface SSAddPlanetObjectViewController : UIViewController

@property (weak, nonatomic) id <SSAddPlanetObjectViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;
@property (strong, nonatomic) IBOutlet UITextField *temperatureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextField;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactTextField;

- (IBAction)addButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;


@end
