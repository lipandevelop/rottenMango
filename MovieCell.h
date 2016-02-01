//
//  MovieCell.h
//  RottenMangos2
//
//  Created by Li Pan on 2016-02-01.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (nonatomic, strong) UIImageView *thumbnailImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end
