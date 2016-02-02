//
//  MovieCell.m
//  RottenMangos2
//
//  Created by Li Pan on 2016-02-01.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    // Initialization code
    self.translatesAutoresizingMaskIntoConstraints = YES;
    self.thumbnailImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 50, 50)];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 140, 20)];
    self.descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 25, 220, 22)];
    self.titleLabel.textColor = [UIColor whiteColor];

    self.descriptionLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    self.critScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(235, 0, 22, 22)];
    self.audiScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, 0, 22, 22)];
    
    [self.critScoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.audiScoreLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.contentView addSubview:self.thumbnailImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview:self.critScoreLabel];
    [self.contentView addSubview:self.audiScoreLabel];
    self.backgroundColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
