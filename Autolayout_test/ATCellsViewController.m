//
//  ATCellsViewController.m
//  Autolayout_test
//
//  Created by sarayev on 7/9/14.
//  Copyright (c) 2014 akvelon. All rights reserved.
//

#import "ATCellsViewController.h"
#import "ATTableViewCell.h"

@interface ATCellsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *table;
@property (nonatomic, strong) NSArray *contentTextes;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) ATTableViewCell *prototypeCell;

@end

@implementation ATCellsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self preloadDataSource];
    
    [self setPrototypeCell:[_table dequeueReusableCellWithIdentifier:@"Cell"]];
}

- (void)preloadDataSource
{
    NSInteger numberOfItems = 10;
    
    if (_titles == nil)
    {
        [self setTitles:[[NSMutableArray alloc] init]];
    }
//
//    if (_contentTextes == nil)
//    {
//        [self setContentTextes:[[NSArray alloc] init]];
//    }
//    
    for (int i = 0; i < numberOfItems; i++)
    {
        NSString *title = [NSString stringWithFormat:@"Sentence %d",i + 1];
        
        [_titles addObject:title];
    }
    
    [self setContentTextes:@[@"I have posted a few times on handling dynamic type including the need to increase the height of table view rows as the font size grows.",
                             @"However the assumption was that all cells in the table view had the same height.",
                             @"In this post I am going to do a detailed walk through of setting up a table view cell with auto layout that has a variable row height.",
                             @"Before going any further I should give credit to this great article by Amy Worrall on using auto layout to calculate table cell height.",
                             @"The light-bulb moment was the trick of keeping a prototype cell to layout a cell with the content and obtain the correct size from within the tableView:heightForRowAtIndexPath: method.",
                             @"As source data from my table view I have taken the first fifteen chapters of “The Adventures of Huckleberry Finn” from Project Gutenberg and imported it into a plist file (one sentence per item).",
                             @"This gives close to 2000 lines of text of varying length.",
                             @"The aim is to show each sentence in a single table view cell with a label showing the line number.",
                             @"The row height of each cell is set for the required number of lines of text. The effect is more obvious using the extra large accessibility text settings:",
                             @"The starting point is the Xcode single view application template modified to have a table view controller embedded in a navigation controller as follows:",]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ATTableViewCell *tableCell = (ATTableViewCell *)cell;
    
    [[tableCell titleLabel] setText:_titles[indexPath.row]];
    [[tableCell aTextLabel] setText:_contentTextes[indexPath.row]];
    
//    [tableCell layoutIfNeeded];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    ATTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self configureCell:_prototypeCell forRowAtIndexPath:indexPath];
    
    [_prototypeCell layoutIfNeeded];
    
    CGSize prototypeCellSize = [[_prototypeCell contentView] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return prototypeCellSize.height + 1;
}

@end
