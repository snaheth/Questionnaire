//
//  QuestionTableViewCell.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "QuestionTableViewCell.h"

@implementation QuestionTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.questionPreviewLabel = [[UILabel alloc] init];
        self.questionPreviewLabel.textColor = [UIColor whiteColor];
        self.questionPreviewLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:16];
        self.questionPreviewLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addSubview:self.questionPreviewLabel];
        
        self.userTitleLabel = [[UILabel alloc] init];
        self.userTitleLabel.textColor = [UIColor whiteColor];
        self.userTitleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:14];
        self.userTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addSubview:self.userTitleLabel];
        
        self.commentsLabel = [[UILabel alloc] init];
        self.commentsLabel.textColor = [UIColor whiteColor];
        self.commentsLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:14];
        self.commentsLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addSubview:self.commentsLabel];
        
        // Constraints
        NSMutableArray *constraints = [[NSMutableArray alloc] init];
        NSDictionary *views = @{
                                @"questionPreviewLabel": self.questionPreviewLabel,
                                @"userTitleLabel": self.userTitleLabel,
                                @"commentsLabel": self.commentsLabel,
                                };
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[questionPreviewLabel]|" options:0 metrics:nil views:views]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[userTitleLabel]-[commentsLabel]-15-|" options:0 metrics:nil views:views]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[questionPreviewLabel(24)]-3-[userTitleLabel(18)]-|" options:0 metrics:nil views:views]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.commentsLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.userTitleLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [self.contentView addConstraints:constraints];
        
        // Height Constraint
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:58.0f];
        [constraint setPriority:999];
        [self.contentView addConstraint:constraint];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end