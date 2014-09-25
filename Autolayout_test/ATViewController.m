//
//  ATViewController.m
//  Autolayout_test
//
//  Created by sarayev on 7/8/14.
//  Copyright (c) 2014 akvelon. All rights reserved.
//

#import "ATViewController.h"

@interface ATViewController ()
@property (strong, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) IBOutlet UIView *purpleView;
@property (strong, nonatomic) IBOutlet UIView *blueView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *greenViewTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *fromGreenToPurpleVerticalConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *purpleViewTopConstraint;

@property (strong, nonatomic) IBOutlet UIButton *button;

@end

@implementation ATViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
       
    [self setPurpleViewTopConstraint:[NSLayoutConstraint constraintWithItem:_purpleView
                                                                  attribute:[_greenViewTopConstraint firstAttribute]
                                                                  relatedBy:[_greenViewTopConstraint relation]
                                                                     toItem:[_greenViewTopConstraint secondItem]
                                                                  attribute:[_greenViewTopConstraint secondAttribute]
                                                                 multiplier:[_greenViewTopConstraint multiplier]
                                                                   constant:[_greenViewTopConstraint constant]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeGreenView
{
    [[self view] layoutIfNeeded];
    
    [UIView animateWithDuration:0.33f animations:^
    {
        [[self view] removeConstraint:_fromGreenToPurpleVerticalConstraint];
        
        [_greenView removeFromSuperview];
        
        [[self view] addConstraint:_purpleViewTopConstraint];
        
        [[self view] layoutIfNeeded];
    }];
}

- (void)addGreenView
{
    [[self view] layoutIfNeeded];
    
    [UIView animateWithDuration:0.33f animations:^
    {
        [[self view] removeConstraint:_purpleViewTopConstraint];
    
        [[self view] insertSubview:_greenView belowSubview:_purpleView];
    
        [[self view] addConstraint:_greenViewTopConstraint];
    
        [[self view] addConstraint:_fromGreenToPurpleVerticalConstraint];
        
        [[self view] layoutIfNeeded];
    }];
}

- (IBAction)buttonAction:(id)sender
{
    if ([_greenView superview] == nil)
    {
        [self addGreenView];
        
        [_button setTitle:@"remove green" forState:UIControlStateNormal];
    }
    else
    {
        [self removeGreenView];
        
        [_button setTitle:@"add green" forState:UIControlStateNormal];
    }
}

@end
