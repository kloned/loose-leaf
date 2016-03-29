//
//  MMStackControllerView.m
//  LooseLeaf
//
//  Created by Adam Wulf on 3/4/16.
//  Copyright © 2016 Milestone Made, LLC. All rights reserved.
//

#import "MMStackControllerView.h"
#import "MMAllStacksManager.h"
#import "MMStackButtonView.h"
#import "MMTextButton.h"
#import "MMPlusButton.h"
#import "UIView+Debug.h"

@interface MMStackControllerView ()<MMStackButtonViewDelegate>

@end

@implementation MMStackControllerView

-(void) reloadStackButtons{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if(![[[MMAllStacksManager sharedInstance] stackIDs] count]){
        [[MMAllStacksManager sharedInstance] createStack];
    }
    
    CGRect screenBounds = [[[UIScreen mainScreen] fixedCoordinateSpace] bounds];
    CGFloat singleStackWidth = CGRectGetWidth(screenBounds) / 4;
    
    for (int i=0; i<[[[MMAllStacksManager sharedInstance] stackIDs] count]; i++) {
        NSString* stackUUID = [[[MMAllStacksManager sharedInstance] stackIDs] objectAtIndex:i];
        MMStackButtonView* stackButton = [[MMStackButtonView alloc] initWithFrame:CGRectMake(singleStackWidth * i, 0, singleStackWidth, CGRectGetHeight(self.bounds)) andStackUUID:stackUUID];
        
        [stackButton loadThumb];
        [stackButton setDelegate:self];
        
        [self addSubview:stackButton];
    }
    
    NSInteger i = [[[MMAllStacksManager sharedInstance] stackIDs] count];
    MMPlusButton* addStackButton = [[MMPlusButton alloc] initWithFrame:CGRectMake(singleStackWidth * i + 90, 40, 60, 60)];
    [addStackButton addTarget:self action:@selector(addStack:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:addStackButton];
    
    CGSize cs = CGSizeMake(i*singleStackWidth + singleStackWidth, 1);
    
    [self setContentSize:cs];
}

#pragma mark - Actions

-(void) addStack:(UIButton*)button{
    [self.stackDelegate addStack];
}

-(void) deleteStackAction:(UIButton*)sender{
    NSString* stackUUID = [[[MMAllStacksManager sharedInstance] stackIDs] objectAtIndex:sender.tag];
    [self.stackDelegate deleteStack:stackUUID];
}

#pragma mark - MMStackButtonViewDelegate

-(void) switchToStackAction:(NSString*)stackUUID{
    [[self stackDelegate] switchToStack:stackUUID];
}

-(void) didTapNameForStack:(NSString *)stackUUID{
    [[self stackDelegate] didTapNameForStack:stackUUID];
}

@end
