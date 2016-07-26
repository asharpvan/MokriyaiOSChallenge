//
//  PaginatedView.h
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerView.h"
#import "MatchViewController.h"

@interface PaginatedView : UIView <UIScrollViewDelegate,MatchViewControllerDelegate>


@property (nonatomic,retain) UIScrollView *horizontalScroller;
@property (nonatomic,retain) UIPageControl *pageControl;

-(instancetype) initWithFrame:(CGRect)frame andArray:(NSMutableArray *)arrayOfPlayers andPagesToCreate:(NSInteger)totalPages;

-(void) refreshWithArray:(NSArray *)array;

@end
