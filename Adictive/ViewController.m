//
//  ViewController.m
//  Adictive
//
//  Created by Pradeep Dahiya on 19/11/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import "ViewController.h"
#import "Utility.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden=YES;
   // self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBg"]];
    [[Utility sharedInstance] setViewBackGroundImage:@"mainBg" forView:self];
    
    
    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"Setting"
                                                       subtitle:nil
                                                          image:[UIImage imageNamed:@"setting"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             [self ShowSetting];
                                                         }];
    
    REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:@"Statistics"
                                                        subtitle:nil
                                                           image:[UIImage imageNamed:@"stats"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              NSLog(@"Item: %@", item);
                                                              [self showStats];
                                                          }];
    
    REMenuItem *profileItem = [[REMenuItem alloc] initWithTitle:@"About Addictive"
                                                          image:[UIImage imageNamed:@"about"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             [self showAbout];
                                                         }];
    
    self.menu = [[REMenu alloc] initWithItems:@[ exploreItem, activityItem, profileItem]];
    //[self.menu showFromNavigationController:self.navigationController];
}

-(void)ShowSetting{
    [self performSegueWithIdentifier:@"setting" sender:self];
}
-(void)showStats{
    [self performSegueWithIdentifier:@"stats" sender:self];
}
-(void)showAbout{
    [self performSegueWithIdentifier:@"about" sender:self];
}
-(IBAction)showHide:(id)sender{
    [self.menu showInView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
