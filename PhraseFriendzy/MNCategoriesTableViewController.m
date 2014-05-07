//
//  MNCategoriesTableViewController.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNCategoriesTableViewController.h"
#import "MNDataObject.h"
#import "MNCategoriesTableViewCell.h"

@interface MNCategoriesTableViewController ()

@end

@implementation MNCategoriesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Download the files for the first time
    if([[[MNDataObject sharedDataObject] filePaths] count] == 0)
    {
        [self downloadWordFiles];
    }
}

- (void)downloadWordFiles
{
    NSString *stringURL = @"http://makenub.com/phrasefriendzy/wordfiles";
    
    // Get the list of files
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Downloading Started");
        NSURL  *url = [NSURL URLWithString:stringURL];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        NSString *urlDataAsString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        
        NSLog(@"urlDataAsString:%@", urlDataAsString);
        
        // Parse the apache file links
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<a\\s[\\s\\S]*?href\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?" options:NSRegularExpressionCaseInsensitive error:&error];
        [regex enumerateMatchesInString:urlDataAsString options:0 range:NSMakeRange(0, [urlDataAsString length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSString *src = [urlDataAsString substringWithRange:[result rangeAtIndex:2]];
            NSLog(@"src: %@", src);
            // If it's a file link and not an 'up directory' link, donwload it
            if([src characterAtIndex:0] != '/')
            {
                NSString *fileStringURL = [NSString stringWithFormat:@"%@/%@", stringURL, src];
                [self downloadFileFromURL:fileStringURL];
            }
        }];
        
        // Update the table view
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)downloadFileFromURL:(NSString *)stringURL
{
    // Download the file in a seperate thread.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Downloading Started");
        NSURL  *url = [NSURL URLWithString:stringURL];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if(urlData)
        {
            // Get the documents directory
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            // Make the words directory if necessary
            NSString *wordsDirectory = [NSString stringWithFormat:@"%@/words", documentsDirectory];
            if(![[NSFileManager defaultManager] fileExistsAtPath:wordsDirectory])
            {
                [[NSFileManager defaultManager] createDirectoryAtPath:wordsDirectory withIntermediateDirectories:NO attributes:nil error:nil];
            }
            
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", wordsDirectory, [stringURL lastPathComponent]];
            
            // Save the file on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [urlData writeToFile:filePath atomically:YES];
                NSLog(@"%@ Saved!", [stringURL lastPathComponent]);
                [self.tableView reloadData];
            });
        }
    });
}

- (IBAction)refreshCategories:(id)sender
{
    [self downloadWordFiles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    [[MNDataObject sharedDataObject] updateFilePaths];
    
    return [[[MNDataObject sharedDataObject] filePaths] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MNCategoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCategoryCell" forIndexPath:indexPath];
    cell.myTextLabel.text = [[[[[MNDataObject sharedDataObject] filePaths] objectAtIndex:indexPath.row] stringByDeletingPathExtension] stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    cell.myDetailTextLabel.text = [NSString stringWithFormat:@"%lu Words", [[[[MNDataObject sharedDataObject] wordCountsPerFile] objectAtIndex:indexPath.row] integerValue]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[MNDataObject sharedDataObject] setCategory:[[[MNDataObject sharedDataObject] filePaths] objectAtIndex:indexPath.row]];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.\
}
 */

@end
