//
//  SSPlanetsTableViewController.m
//  Planets
//
//  Created by Saurav Sharma on 9/15/14.
//  Copyright (c) 2014 ZineOne. All rights reserved.
//

#import "SSPlanetsTableViewController.h"
#import "AstronomicalData.h"
#import "SSObjectSpace.h"
#import "SSPlanetImageViewController.h"
#import "SSPlanetDataViewController.h"

@interface SSPlanetsTableViewController ()

@end

@implementation SSPlanetsTableViewController
#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects Array"

#pragma mark - Lazy Instantiation of Properties

- (NSMutableArray *)planets
{
    if (!_planets)
    {
        _planets = [[NSMutableArray alloc] init];
    }
    return _planets;
}

- (NSMutableArray *)addedSpaceObjects
{
    if (!_addedSpaceObjects) {
        _addedSpaceObjects = [[NSMutableArray alloc] init];
    }
    return _addedSpaceObjects;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets])
    {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        
        SSObjectSpace *planet = [[SSObjectSpace alloc] initWithData:planetData andImage:[UIImage imageNamed:imageName]];
        
        [self.planets addObject:planet];
    }
    
    NSArray *myPlanetsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY];
    for (NSDictionary *dictionary in myPlanetsAsPropertyLists)
    {
        SSObjectSpace *planetObject = [self planetObjectForDictionary:dictionary];
        [self.addedSpaceObjects addObject:planetObject];
    }
    
//    NSString *planet1 = @"Mercury";
//    NSString *planet2 = @"Venus";
//    NSString *planet3 = @"Earth";
//    NSString *planet4 = @"Mars";
//    NSString *planet5 = @"Jupiter";
//    NSString *planet6 = @"Saturn";
//    NSString *planet7 = @"Uranus";
//    NSString *planet8 = @"Neptune";
    
//    self.planets = [[NSMutableArray alloc] initWithObjects:planet1, planet2, planet3, planet4, planet5, planet6, planet7, planet8, nil];
    
//    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
//    NSString *firstColor = @"red";
//    [myDictionary setObject:firstColor forKey:@"firetruck color"];
//    [myDictionary setObject:@"blue" forKey:@"ocean color"];
//    NSLog(@"%@", myDictionary);
//    
//    NSString *blueString = [myDictionary objectForKey:@"ocean color"];
//    NSLog(@"%@", myDictionary);
    
//    NSNumber *myNumber = [NSNumber numberWithInt:5];
//    NSLog(@"%@", myNumber);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SSAddPlanetObjectViewController Delegate

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addPlanetObject:(SSObjectSpace *)planetObject
{
    [self.addedSpaceObjects addObject:planetObject];
    
    //will save to NSUserDefaults here
    NSMutableArray *planetObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    
    if (!planetObjectsAsPropertyLists)
        planetObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [planetObjectsAsPropertyLists addObject:[self planetObjectAsAPropertyList:planetObject]];
    [[NSUserDefaults standardUserDefaults] setObject:planetObjectsAsPropertyLists forKey:ADDED_SPACE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

- (NSDictionary *)planetObjectAsAPropertyList:(SSObjectSpace *)planetObject
{
    NSData *imageData = UIImagePNGRepresentation(planetObject.planetImage);
    
    NSDictionary *dictionary = @{PLANET_NAME : planetObject.name, PLANET_GRAVITY : @(planetObject.gravitationalForce), PLANET_DIAMETER : @(planetObject.diameter), PLANET_YEAR_LENGTH : @(planetObject.yearLength), PLANET_DAY_LENGTH : @(planetObject.dayLength), PLANET_NICKNAME : planetObject.nickname, PLANET_TEMPERATURE : @(planetObject.temp), PLANET_NUMBER_OF_MOONS : @(planetObject.numberOfMoons), PLANET_INTERESTING_FACT : planetObject.interestingFact, PLANET_IMAGE : imageData};
    
    return dictionary;
}

-(SSObjectSpace *)planetObjectForDictionary:(NSDictionary *)dictionary
{
    NSData *dataForImage = dictionary[PLANET_IMAGE];
    UIImage *planetObjectImage = [UIImage imageWithData:dataForImage];
    SSObjectSpace *planetObject = [[SSObjectSpace alloc] initWithData:dictionary andImage:planetObjectImage];
    return planetObject;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([self.addedSpaceObjects count])
    {
        return 2;
    }
        return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 1)
    {
        return [self.addedSpaceObjects count];
    }
        return [self.planets count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (indexPath.section == 1)
    {
        //Use new space object to customize cell
        SSObjectSpace *planet = self.addedSpaceObjects[indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.planetImage;
    }
    else
    {
        /* Access objects from planets array in SSObjectSpace. Use SSObjectSpace properties to
         update cell properties */
        SSObjectSpace *planet = [self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.planetImage;
    }
    
    /* Customize the appearance of TableViewCells*/
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    return cell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) return YES;
    else return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.addedSpaceObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newSavedSpaceObjectData = [[NSMutableArray alloc] init];
        for (SSObjectSpace *planetObject in self.addedSpaceObjects) {
            [newSavedSpaceObjectData addObject:[self planetObjectAsAPropertyList:planetObject]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newSavedSpaceObjectData forKey:ADDED_SPACE_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        if ([segue.destinationViewController isKindOfClass:[SSPlanetImageViewController class]])
        {
            SSPlanetImageViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            SSObjectSpace *selectedObject;
            
            if (path.section == 0)
            {
                selectedObject = self.planets[path.row];
            }
            else if (path.section == 1)
            {
                selectedObject = self.addedSpaceObjects[path.row];
            }
            
            nextViewController.spaceObject = selectedObject;
        }
    }
    
    if ([sender isKindOfClass:[NSIndexPath class]])
    {
        if ([segue.destinationViewController isKindOfClass:[SSPlanetDataViewController class]])
        {
            SSPlanetDataViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            SSObjectSpace *selectedObject;
            
            if (path.section == 0)
            {
                selectedObject = self.planets[path.row];
            }
            else if (path.section == 1)
            {
                selectedObject = self.addedSpaceObjects[path.row];
            }
            
            targetViewController.spaceObject = selectedObject;
        }
    }
    if ([segue.destinationViewController isKindOfClass: [SSAddPlanetObjectViewController class]])
    {
        SSAddPlanetObjectViewController *addPlanetObjectVC = segue.destinationViewController;
        addPlanetObjectVC.delegate = self;
    }
}


@end
