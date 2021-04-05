//
//  RestrictedViewController.m
//  Adictive
//
//  Created by Pradeep Dahiya on 01/01/15.
//  Copyright (c) 2015 Pradeep Dahiya. All rights reserved.
//

#import "RestrictedViewController.h"
#import "Utility.h"

@interface RestrictedViewController ()

@end

@implementation RestrictedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg22.png"]];
    [[Utility sharedInstance] setViewBackGroundImage:@"bg22" forView:self];
    int coin=[[[NSUserDefaults standardUserDefaults] valueForKey:@"COINS"] intValue];
    int need=13000-coin;
    unlock.text=[NSString stringWithFormat:@"%d",need];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
