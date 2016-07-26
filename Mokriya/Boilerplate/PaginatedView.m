//
//  PaginatedView.m
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "PaginatedView.h"
#import "PlayerListView.h"
#import "PlayerView.h"
#import "PlayerModel.h"
#import "Chameleon.h"

@implementation PaginatedView {
    
    UIView *topView;
    UIView *bottomView;
//    NSMutableArray *arrayOfPlayersRecieved;
    NSInteger totalPages;
}

@synthesize horizontalScroller,pageControl;

-(instancetype) initWithFrame:(CGRect)frame andArray :(NSMutableArray *)arrayOfPlayers andPagesToCreate:(NSInteger)totalPagesRecieved {
    
    self =[super initWithFrame:frame];
    if(self) {
        
        topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - kBottomViewHeight)];
//        [topView setBackgroundColor:[UIColor greenColor]];
        [self addSubview:topView];
        
        bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - kBottomViewHeight, self.frame.size.width, kBottomViewHeight)];
//        [bottomView setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:bottomView];
        
        // PAGE CONTROL
        pageControl = [[UIPageControl alloc]initWithFrame:bottomView.bounds];
        [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        [pageControl setCurrentPageIndicatorTintColor:[UIColor darkGrayColor]];
        [pageControl setNumberOfPages:totalPagesRecieved];
        [bottomView addSubview:pageControl];
        
        //Middle View Subviews
        horizontalScroller = [[UIScrollView alloc] initWithFrame:topView.frame];
//        [horizontalScroller setBackgroundColor:[UIColor orangeColor]];
        [horizontalScroller setPagingEnabled:TRUE];
        [horizontalScroller setShowsHorizontalScrollIndicator:FALSE];
        [horizontalScroller setDelegate:self];
        [self addSubview:horizontalScroller];
        
//        arrayOfPlayersRecieved = arrayOfPlayers;
        totalPages = totalPagesRecieved;
        
        [self createPaginatedPages: arrayOfPlayers];
    }
    
    return self;
}

-(void) createPaginatedPages:(NSMutableArray *) initialList {
    
    for (int i = 0; i < totalPages; i ++) {
        
        CGRect frame;
        frame.origin.x = horizontalScroller.frame.size.width * i + kMediumPadding;
        frame.origin.y = kMediumPadding;
        frame.size = CGSizeMake(horizontalScroller.frame.size.width - (kMediumPadding *2), horizontalScroller.frame.size.height - (kMediumPadding * 2));
        
        PlayerListView *viewToAdd = [[PlayerListView alloc]initWithFrame:frame];
        
        [viewToAdd setBackgroundColor:[UIColor flatSandColorDark]];
        [[viewToAdd layer] setCornerRadius:10.0f];
        [[viewToAdd layer] setShadowColor:[UIColor blackColor].CGColor];
        [[viewToAdd layer] setShadowOpacity:0.8];
        [[viewToAdd layer] setShadowRadius:3.0];
        [[viewToAdd layer] setShadowOffset:CGSizeMake(2.0, 2.0)];
        [viewToAdd setClipsToBounds:TRUE];
        
        [horizontalScroller addSubview:viewToAdd];

    }
    
    [horizontalScroller setContentOffset:CGPointMake(horizontalScroller.frame.size.width * [pageControl currentPage], 0)];
    horizontalScroller.contentSize =  CGSizeMake(horizontalScroller.frame.size.width * totalPages, horizontalScroller.frame.size.height);
     [self refreshWithArray:initialList];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = horizontalScroller.frame.size.width;
    float fractionalPage = horizontalScroller.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
}

-(void)dealloc {
    
    NSLog(@"dealloc");
}



-(void) refreshWithArray:(NSArray *)array {
    
//    [arrayOfPlayersRecieved removeAllObjects];
//    [arrayOfPlayersRecieved addObjectsFromArray:array];
    
    NSLog(@"array :(%d)",[array count]);
    NSLog(@"number of subviews :%@",[horizontalScroller subviews]);
    
    [[horizontalScroller subviews] enumerateObjectsUsingBlock:^(PlayerListView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if([obj isKindOfClass:[PlayerListView class]]){
            [[[obj player1] name]setText:[(PlayerModel *)[array objectAtIndex:(idx*4)]playerName]];
            [[[obj player1] rating] setText:[NSString stringWithFormat:@"Rating : %@",[(PlayerModel *)[array objectAtIndex:(idx*4)]playerRating]]];
            [[[obj player1] selected] setTag:(idx*4)];
            
            [[[obj player2] name]setText:[(PlayerModel *)[array objectAtIndex:(idx*4)+1]playerName]];
            [[[obj player2] rating] setText:[NSString stringWithFormat:@"Rating : %@",[(PlayerModel *)[array objectAtIndex:(idx*4)+1]playerRating]]];
            [[[obj player2] selected] setTag:((idx*4)+1)];
            
            [[[obj player3] name]setText:[(PlayerModel *)[array objectAtIndex:(idx*4)+2]playerName]];
            [[[obj player3] rating] setText:[NSString stringWithFormat:@"Rating : %@",[(PlayerModel *)[array objectAtIndex:(idx*4)+2]playerRating]]];
            [[[obj player3] selected] setTag:((idx*4)+2)];
            
            [[[obj player4] name]setText:[(PlayerModel *)[array objectAtIndex:(idx*4)+3]playerName]];
            [[[obj player4] rating] setText:[NSString stringWithFormat:@"Rating : %@",[(PlayerModel *)[array objectAtIndex:(idx*4)+3]playerRating]]];
            [[[obj player4] selected] setTag:((idx*4)+3)];
   
        }
    }];
    
}

@end
