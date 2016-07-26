//
//  ViewController.h
//  Boilerplate
//
//  Created by agatsa on 4/1/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoStatusBarViewController.h"
#import "MatchViewController.h"



@interface ViewController : NoStatusBarViewController <MatchViewControllerDelegate>

-(instancetype)init;

@end

