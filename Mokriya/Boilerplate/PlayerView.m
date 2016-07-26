//
//  PlayerView.m
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "PlayerView.h"
#import "Chameleon.h"

@implementation PlayerView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self =[super initWithFrame:frame];
    if(self) {
        
        [self setBackgroundColor:[UIColor flatSandColor]];
        
        int nameHeight = (frame.size.height * .4) - kSmallPadding;

        
        self.name = [[UILabel alloc]initWithFrame: CGRectMake(0, kSmallPadding, frame.size.width, nameHeight)];
        [self.name setTextAlignment:NSTextAlignmentCenter];
        [self.name setFont:[UIFont boldSystemFontOfSize:20]];
        [self addSubview:self.name];
        
        CAShapeLayer *line = [CAShapeLayer layer];
        UIBezierPath *linePath=[UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(self.name.frame.origin.x,self.name.frame.origin.y + self.name.frame.size.height)];
        [linePath addLineToPoint:CGPointMake(self.name.frame.origin.x + self.name.frame.size.width,self.name.frame.origin.y +self.name.frame.size.height)];
        line.lineWidth = 2.0;
        line.path=linePath.CGPath;
        line.fillColor = [UIColor flatBlackColor].CGColor;
        line.strokeColor = [UIColor flatBlackColor].CGColor;
        [[self layer] addSublayer:line];
        
        self.rating = [[UILabel alloc]initWithFrame: CGRectMake(0, self.name.frame.origin.y + self.name.frame.size.height + kMediumPadding, frame.size.width/2, 40)];
        [self.rating setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.rating];
        
        self.selected = [[UISwitch alloc]initWithFrame: CGRectMake(frame.size.width - 60, self.name.frame.origin.y + self.name.frame.size.height + kSmallPadding + kMediumPadding, frame.size.width/2, 30)];
        [self.selected addTarget:self action:@selector(actionSwitch:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.selected];
        
        [[self layer] setCornerRadius:10.0f];
    }
    
    return self;
}


-(void) actionSwitch:(UISwitch *)switchPressed {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchStatusChanged" object:switchPressed];
}
@end
