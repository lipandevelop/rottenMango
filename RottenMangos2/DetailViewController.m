//
//  DetailViewController.m
//  RottenMangos2
//
//  Created by Li Pan on 2016-02-01.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void) loadData;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.titleDetail.text = self.detailItem.title;
        self.yearDetail.text = [NSString stringWithFormat:@"%@",self.detailItem.year];
        self.runtimeDetail.text = [NSString stringWithFormat:@"%@min",self.detailItem.runtime];
        self.mraaRatingDetail.text = [NSString stringWithFormat:@"Rated:%@",self.detailItem.mpaa_rating];
        self.crtRtDetail.text = [NSString stringWithFormat:@"Critics Rating:\n%@",self.detailItem.criticRating];
        self.crtScDetail.text = [NSString stringWithFormat:@"%@",self.detailItem.criticScore];
        self.crtScDetail.textColor = [UIColor colorWithHue:self.detailItem.autdienceScore.intValue/270.0 saturation:1.0 brightness:1.0 alpha:0.8];
        self.audRtDetail.text = [NSString stringWithFormat:@"Audience Rating:\n%@",self.detailItem.audienceRating];
        self.audScDetail.text = [NSString stringWithFormat:@"%@",self.detailItem.autdienceScore];
        self.audScDetail.textColor = [UIColor colorWithHue:self.detailItem.autdienceScore.intValue/270.0 saturation:1.0 brightness:1.0 alpha:0.8];
        self.synposisDetail.text = self.detailItem.synopsis;
        self.synposisDetail.alpha = 0.8;
        self.imageDetail.image = [UIImage imageWithData:self.detailItem.thumbnailURL];
        [self loadData];
        MovieReview *review = [[MovieReview alloc]init];
        self.reviewDetail.text = [NSString stringWithFormat:@"Critic:%@\nDate:%@\nFreshness:%@\nPublication:%@\nQuote:%@",review.critic, review.date, review.freshness, review.publication, review.quote];
        self.reviewDetail.alpha = 0.6;
        self.view.backgroundColor = [UIColor blackColor];
    }
}

- (void) loadData {
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url= [NSURL URLWithString:self.detailItem.reviewURL];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        //NSLog(@"Inside DetailView Completion Handler");
        if (!error) {
            NSError *jsonParsingErrorDetailView;
            NSDictionary *jsonDataDetailView = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingErrorDetailView];
            
            if (!jsonParsingErrorDetailView) {
                //NSLog(@"%@", jsonDataDetailView);
                
                //NSMutableArray *reviewsArray = [[NSMutableArray alloc]init];
                for (NSDictionary *reviewDictionary in jsonDataDetailView[@"reviews"]) {
                    MovieReview *review = [[MovieReview alloc]init];
                    review.critic = reviewDictionary[@"critic"];
                    review.date = [NSString stringWithFormat:@"%@", reviewDictionary[@"date"]];
                    review.freshness = reviewDictionary[@"freshness"];
                    review.publication = reviewDictionary[@"publication"];
                    review.quote = reviewDictionary[@"quote"];
                    
                    //MovieReview *review = [[MovieReview alloc]init];
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.reviewDetail.text = [NSString stringWithFormat:@"Critic:%@\nDate:%@\nFreshness:%@\nPublication:%@\nQuote:%@",review.critic, review.date, review.freshness, review.publication, review.quote];
                        
                    });
                }
                
            }
        }
    }];
    [dataTask resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
