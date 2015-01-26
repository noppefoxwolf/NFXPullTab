//
//  NFXPullTabViewController.h
//  NFXPullTab
//
//  Created by Tomoya_Hirano on 2015/01/27.
//  Copyright (c) 2015年 Tomoya_Hirano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFXPullTabViewController : UIViewController
-(void)setViewControllers:(NSArray*)controllers;
-(void)setSelectedIndex:(int)index;
@end
