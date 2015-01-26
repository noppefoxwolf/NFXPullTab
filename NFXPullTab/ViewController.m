//
//  ViewController.m
//  NFXPullTab
//
//  Created by Tomoya_Hirano on 2015/01/27.
//  Copyright (c) 2015年 Tomoya_Hirano. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel*lbl = [[UILabel alloc] initWithFrame:self.view.bounds];
    lbl.text = [NSString stringWithFormat:@"%d",self.index];
    lbl.backgroundColor = [UIColor colorWithHue:(float)self.index/5 saturation:1 brightness:1 alpha:1];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont systemFontOfSize:60];
    [self.view addSubview:lbl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
