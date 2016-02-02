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
        self.runtimeDetail.text = [NSString stringWithFormat:@"%@",self.detailItem.runtime];
        self.mraaRatingDetail.text = self.detailItem.mpaa_rating;
        self.crtRtDetail.text = self.detailItem.criticRating;
        self.crtScDetail.text = [NSString stringWithFormat:@"%@",self.detailItem.criticScore];
        self.audRtDetail.text = self.detailItem.audienceRating;
        self.audScDetail.text = [NSString stringWithFormat:@"%@",self.detailItem.autdienceScore];
        self.synposisDetail.text = self.detailItem.synopsis;
        self.imageDetail.image = [UIImage imageWithData:self.detailItem.thumbnailURL];
        [self loadData];
        MovieReview *review = [[MovieReview alloc]init];
        self.reviewDetail.text = [NSString stringWithFormat:@"Critic:%@\nDate:%@\nFreshness:%@\nPublication:%@\nQuote:%@",review.critic, review.date, review.freshness, review.publication, review.quote];

        

}


    
}

- (void) loadData {
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url= [NSURL URLWithString:self.detailItem.reviewURL];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        NSLog(@"Inside DetailView Completion Handler");
        if (!error) {
            NSError *jsonParsingErrorDetailView;
            NSArray *jsonDataDetailView = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingErrorDetailView];
            if (!jsonParsingErrorDetailView) {
                NSLog(@"%@", jsonDataDetailView);
                
                //NSMutableArray *reviewsArray = [[NSMutableArray alloc]init];
                for (NSDictionary *reviewDictionary in jsonDataDetailView) {
                    MovieReview *review = [[MovieReview alloc]init];
                    review.critic = reviewDictionary[@"critic"];
                    review.date = [NSString stringWithFormat:@"%@", reviewDictionary[@"date"]];
                    review.freshness = reviewDictionary[@"freshness"];
                    review.publication = reviewDictionary[@"publication"];
                    review.quote = reviewDictionary[@"quote"];
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
