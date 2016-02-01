//
//  Repo.h
//  rottenMangoes
//
//  Created by Li Pan on 2016-02-01.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject
//@property (nonatomic, strong) NSDate *dateReleased;
@property (nonatomic, strong) NSString *identification;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *mpaa_rating;
@property (nonatomic, strong) NSString *runtime;

@property (nonatomic, strong) NSData *thumbnailURL;
//@property (nonatomic, strong) NSString *thumbnailURL;

@property (nonatomic, strong) NSDictionary *ratings;

@property (nonatomic, strong) NSString *criticRating;
@property (nonatomic, strong) NSString *criticScore;
@property (nonatomic, strong) NSString *audienceRating;
@property (nonatomic, strong) NSString *autdienceScore;

@property (nonatomic, strong) NSString *synopsis;


@end
