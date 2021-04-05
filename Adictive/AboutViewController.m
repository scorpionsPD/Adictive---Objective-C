//
//  AboutViewController.m
//  Adictive
//
//  Created by Pradeep Dahiya on 12/01/15.
//  Copyright (c) 2015 Pradeep Dahiya. All rights reserved.
//

#import "AboutViewController.h"
#import "Utility.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[Utility sharedInstance] setViewBackGroundImage:@"bgg" forView:self];
    
    self.webView.opaque =NO;
    self.webView.backgroundColor = [UIColor clearColor];
    NSURL *stringURL = [[NSBundle mainBundle] URLForResource:@"about_us" withExtension:@".rtf"];
    NSError *error;
    NSAttributedString *myAttributedText = [[NSAttributedString alloc] initWithFileURL:stringURL options:nil documentAttributes:nil error:&error];
    self.webView.attributedText = myAttributedText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)dismisss:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
