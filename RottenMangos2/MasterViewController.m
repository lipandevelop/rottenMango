//
//  MasterViewController.m
//  RottenMangos2
//
//  Created by Li Pan on 2016-02-01.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Movie.h"
#import "MovieCell.h"

@interface MasterViewController ()

@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSDictionary *movieDictionary;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 60;
    
#pragma data
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=%@&page_limit=50", ROTTEN_TOMATO_APIKEY];
    NSURL *url= [NSURL URLWithString:urlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        //NSLog(@"code inside completion handler");
        if (!error) {
            NSError *jsonParsingError;
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
            if (!jsonParsingError) {
                //NSLog(@"%@", jsonData);
                
                NSMutableArray *movieDictionaryList = [[NSMutableArray alloc]init];
                for (NSDictionary *movieDictionary in jsonData[@"movies"]) {
                    Movie *movie = [[Movie alloc]init];
                    movie.title = movieDictionary[@"title"];
                    movie.synopsis = movieDictionary[@"synopsis"];
                    movie.year = movieDictionary[@"year"];
                    movie.mpaa_rating = movieDictionary[@"mpaa_rating"];
                    movie.runtime = movieDictionary[@"runtime"];
                    movie.identification = movieDictionary[@"id"];
                    
                    NSDictionary *postersDictionary = movieDictionary[@"posters"];
                    NSString *path= postersDictionary[@"thumbnail"];
                    //NSLog(@"%@",path);
                    movie.thumbnailURL = [NSData dataWithContentsOfURL: [NSURL URLWithString: path]];
                    
                    NSDictionary *ratingsDictionary = movieDictionary[@"ratings"];
                    movie.criticScore = ratingsDictionary[@"critics_score"];
                    movie.autdienceScore = ratingsDictionary[@"audience_score"];
                    movie.criticRating = ratingsDictionary[@"audience_rating"];
                    movie.audienceRating = ratingsDictionary[@"audience_rating"];

                    
                    NSDictionary *releaseDatesDictionary = movieDictionary[@"release_dates"];
                    movie.releasDates = releaseDatesDictionary[@"theater"];
                    
                    movie.reviewURL = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%@/reviews.json?apikey=%@", movie.identification, ROTTEN_TOMATO_APIKEY];
                    
                    [movieDictionaryList addObject:movie];
                }
                self.objects = movieDictionaryList;
                //NSLog(@"%lu", (unsigned long)self.objects.count);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //NSLog(@"inside Dispatch Handler");
                    [self.tableView reloadData];
                    
                });
            }
        }
        
        
    }];
    [dataTask resume];
    //NSLog(@"code below completion handler");
    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Movie *selectedMovie = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        controller.detailItem = selectedMovie;
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (MovieCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Movie *movie = self.objects[indexPath.row];
    cell.titleLabel.text = movie.title;
    cell.descriptionLabel.text = movie.synopsis;
    cell.thumbnailImage.image = [UIImage imageWithData: movie.thumbnailURL];
    cell.thumbnailImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.critScoreLabel.text = [NSString stringWithFormat:@"%@",movie.criticScore];
    cell.audiScoreLabel.text = [NSString stringWithFormat:@"%@",movie.autdienceScore];
    cell.critScoreLabel.backgroundColor = [UIColor colorWithHue:movie.criticScore.intValue/270.0 saturation:1.0 brightness:1.0 alpha:0.8];
    cell.audiScoreLabel.backgroundColor = [UIColor colorWithHue:movie.autdienceScore.intValue/270.0 saturation:1.0 brightness:1.0 alpha:0.8];
    //cell.thumbnailImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:movie.thumbnailURL]]];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
