//
//  PlayerView.h
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerView : UIView

@property (nonatomic,retain) UILabel *name;
@property (nonatomic,retain) UILabel *rating;
@property (nonatomic,retain) UISwitch *selected;

-(instancetype) initWithFrame:(CGRect)frame;

@end
