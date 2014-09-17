//
//  SSObjectSpace.h
//  Planets
//
//  Created by Saurav Sharma on 9/16/14.
//  Copyright (c) 2014 ZineOne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSObjectSpace : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) float gravitationalForce;
@property (nonatomic) float diameter;
@property (nonatomic) float yearLength;
@property (nonatomic) float dayLength;
@property (nonatomic) float temp;
@property (nonatomic) int numberOfMoons;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *interestingFact;

@property (strong, nonatomic) UIImage *planetImage;

-(id)initWithData: (NSDictionary *)data andImage:(UIImage *)image;

@end
