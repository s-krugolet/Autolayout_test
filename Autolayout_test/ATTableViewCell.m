//
//  ATTableViewCell.m
//  Autolayout_test
//
//  Created by sarayev on 7/9/14.
//  Copyright (c) 2014 akvelon. All rights reserved.
//

#import "ATTableViewCell.h"

@implementation ATTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
