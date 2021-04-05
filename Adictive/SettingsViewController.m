//
//  SettingsViewController.m
//  Adictive
//
//  Created by Pradeep Dahiya on 12/01/15.
//  Copyright (c) 2015 Pradeep Dahiya. All rights reserved.
//

#import "SettingsViewController.h"
#import "Utility.h"
#import "TBCircularSlider.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[Utility sharedInstance] setViewBackGroundImage:@"bgg" forView:self];
    
    //Create the Circular Slider
    lebleText.text=@"LOW:countdown of level 1 (TAP) starts with 30 sec and will decrease by 1 sec after each cleared stage\n Anyone can easilly reach at last stage ";
    [self loadSegment];
}
-(void)loadSegment{
    // items to be used for each segment (same as UISegmentControl) for all instances
    NSArray *titles = [NSArray arrayWithObjects:[@"low" uppercaseString], [@"med" uppercaseString], [@"high" uppercaseString], nil];
    NSArray *icons = [NSArray arrayWithObjects:[UIImage imageNamed:@"low.png"], [UIImage imageNamed:@"med.png"], [UIImage imageNamed:@"high.png"], nil];
    
    URBSegmentedControl *verticalControl = [[URBSegmentedControl alloc] initWithTitles:titles icons:icons];
    verticalControl.frame = CGRectMake(10,  20.0, 70, 250);
    verticalControl.layoutOrientation = URBSegmentedControlOrientationVertical;
    verticalControl.segmentViewLayout = URBSegmentViewLayoutVertical;
    [self.view addSubview:verticalControl];
    
    // UIKit method of handling value changes
    //[verticalControl addTarget:self action:@selector(handleSelection:) forControlEvents:UIControlEventValueChanged];
    [verticalControl setControlEventBlock:^(NSInteger index, URBSegmentedControl *segmentedControl) {
        NSLog(@"URBSegmentedControl: control block - index=%li", (long)index);
        [self handleSelection:index];
    }];
   // [verticalControl setSelectedSegmentIndex:[NSNumber numberWithInt:[[NSUserDefaults standardUserDefaults] integerForKey:@"DIFICULTY"]]];
}

- (void)handleSelection:(long)index {
    NSString *textString;
    switch (index) {
        case 0:
            textString=@"LOW:countdown of level 1 (TAP) starts with 30 sec and will decrease by 1 sec after each cleared stage\n Anyone can easilly reach at last stage ";
            break;
          case 1:
            textString=@"MEDIUM:countdown of level 1 (TAP) starts with 30 sec and will decrease by 1 upto 8th stage and then decrease by 2 sec after each cleared stage \n Who has a good concentration and can move hands quiclly can reach at last stage ";
            break;
        case 2:
            textString=@"HIGH:countdown of level 1 (TAP) starts with 20 sec and will decrease by 1 sec after each cleared stage \n Hard to clear this level almost not possible but good efforts will help you to win";
            break;
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"DIFICULTY"];
    lebleText.text=textString;
    NSLog(@"URBSegmentedControl: value changed");
}

-(void)newValue:(TBCircularSlider*)slider{
    //TBCircularSlider *slider = (TBCircularSlider*)sender;
    NSLog(@"Slider Value %d",(slider.angle*100)/360);
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
