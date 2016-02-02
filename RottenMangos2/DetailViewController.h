//
//  DetailViewController.h
//  RottenMangos2
//
//  Created by Li Pan on 2016-02-01.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MovieReview.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) Movie *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *titleDetail;
@property (weak, nonatomic) IBOutlet UILabel *yearDetail;

@property (weak, nonatomic) IBOutlet UIImageView *imageDetail;
@property (weak, nonatomic) IBOutlet UILabel *runtimeDetail;
@property (weak, nonatomic) IBOutlet UILabel *mraaRatingDetail;

@property (weak, nonatomic) IBOutlet UILabel *crtRtDetail;
@property (weak, nonatomic) IBOutlet UILabel *crtScDetail;
@property (weak, nonatomic) IBOutlet UILabel *audRtDetail;
@property (weak, nonatomic) IBOutlet UILabel *audScDetail;

@property (weak, nonatomic) IBOutlet UILabel *synposisDetail;
@property (weak, nonatomic) IBOutlet UILabel *reviewDetail;



@end

