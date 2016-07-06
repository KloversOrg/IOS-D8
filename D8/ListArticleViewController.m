//
//  ListArticleViewController.m
//  D8
//
//  Created by System Administrator on 6/28/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import "ListArticleViewController.h"
#import "LoginViewController.h"
#import "ListArticleThread.h"

#import "EditArticleViewController.h"

#import "AppDelegate.h"
#import "HJManagedImageV.h"
#import "DeleteArticleThread.h"

@interface ListArticleViewController ()

@end

@implementation ListArticleViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self._data = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    /*
     [preferences setObject:[jsonDict objectForKey:@"uid"] forKey:@"uid"];
     [preferences setObject:[jsonDict objectForKey:@"session_id"] forKey:@"session_id"];
     */
    
//    if ([preferences objectForKey:_id] == nil && [preferences objectForKey:_name] == nil)
//    {
//        //  Doesn't exist.
//        
//        NSLog(@"");
//        
//        UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        
//        LoginViewController *_viewC =[storybrd instantiateViewControllerWithIdentifier:@"LoginViewController"];
//        // UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];settingsViewController.title = @"Settings";
//        
//        UINavigationController* _navViewC = [[UINavigationController alloc] initWithRootViewController:_viewC];
//        
//        [self presentViewController:_navViewC animated:YES completion:nil];
//    }
//    else
//    {
        [self._table setHidden:YES];
        
        // Add UIActivityIndicatorView
        self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.spinner.frame = CGRectMake(0, 0, 24, 24);
        [self.spinner startAnimating];
        [self.view addSubview:self.spinner];
        
        //  Get current level
       //  NSString* vid = [preferences objectForKey:_id];
       //  NSString* vname = [preferences objectForKey:_name];
        
        ListArticleThread *listArticleThread = [[ListArticleThread alloc] init];
        [listArticleThread setCompletionHandler:^(NSString * str) {
            
            //        [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user[PF_USER_FULLNAME]]];
            //        [self dismissViewControllerAnimated:YES completion:nil];
            
            NSDictionary *jsonDict= [NSJSONSerialization JSONObjectWithData:str  options:kNilOptions error:nil];
            
            /*
             {"id":"Zye-y9A3mV5mEI4dmMrSXuJ1i82yA5ep_Ii9NRJuMrk","name":"SESSd7da75db715e9ec489582517601f380b"}
             */
            
            
//            // http://stackoverflow.com/questions/19206762/equivalent-to-shared-preferences-in-ios
//            NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
//            
//            // const NSInteger currentLevel = ...;
//            // [preferences setInteger:currentLevel forKey:currentLevelKey];
//            [preferences setObject:[jsonDict objectForKey:@"id"] forKey:@"id"];
//            [preferences setObject:[jsonDict objectForKey:@"name"] forKey:@"name"];
//            
//            //  Save to disk
//            const BOOL didSave = [preferences synchronize];
//            
//            if (didSave)
//            {
//                //  Couldn't save (I've never seen this happen in real world testing)
//                
//                UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                
//                ViewController *_viewC =[storybrd instantiateViewControllerWithIdentifier:@"ViewController"];
//                // UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];settingsViewController.title = @"Settings";
//                
//                UINavigationController* _navViewC = [[UINavigationController alloc] initWithRootViewController:_viewC];
//                
//                [self presentViewController:_navViewC animated:YES completion:nil];
//                
//                [self.hud hide:YES];
//                [self.hud removeFromSuperview];
//            }
            
            if ([jsonDict objectForKey:@"result"]) {
                NSLog(@"");
                
                if ([[jsonDict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                    self._data =  [jsonDict objectForKey:@"data"];
                    
                    [self._table reloadData];
                }
            }else{
                NSLog(@"%@", str);
            }
            
            [self._table setHidden:NO];
            
            [self.spinner stopAnimating];
            [self.spinner removeFromSuperview];
            
            NSLog(@"%@", str);
        }];
        [listArticleThread setErrorHandler:^(NSString * str) {
            NSLog(@"%@", str);

            [self.spinner stopAnimating];
            [self.spinner removeFromSuperview];
        }];
        
        [listArticleThread start];
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewDidLayoutSubviews{
    self.spinner.center = self.view.center;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self._data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    HJManagedImageV *imgV = (HJManagedImageV *)[cell viewWithTag:9];
    UILabel *_type = (UILabel *)[cell viewWithTag:10];
    UILabel *_name = (UILabel *)[cell viewWithTag:11];
    
    
    [imgV clear];
    [imgV showLoadingWheel];
    [imgV setUrl:[NSURL URLWithString:[[self._data objectAtIndex:indexPath.row] valueForKey:@"url_image"]]];
    [[(AppDelegate*)[[UIApplication sharedApplication] delegate] obj_Manager ] manage:imgV];
    
    [_type setText:[[self._data objectAtIndex:indexPath.row] valueForKey:@"type"]];
    [_name setText:[[self._data objectAtIndex:indexPath.row] valueForKey:@"title"]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // if (indexPath.section == 0 && indexPath.row == 0) {
        
    EditArticleViewController *editArticleViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditArticleViewController"];
    editArticleViewController._nid = [[self._data objectAtIndex:indexPath.row] valueForKey:@"nid"];
    editArticleViewController._title = [[self._data objectAtIndex:indexPath.row] valueForKey:@"title"];
    editArticleViewController._body = [[self._data objectAtIndex:indexPath.row] valueForKey:@"body"];
    editArticleViewController._url = [[self._data objectAtIndex:indexPath.row] valueForKey:@"url_image"];
    
    [self.navigationController pushViewController:editArticleViewController animated:YES];
    // }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        DeleteArticleThread *deleteArticleThread = [[DeleteArticleThread alloc] init];
        [deleteArticleThread setCompletionHandler:^(NSString * str) {
            NSDictionary *jsonDict= [NSJSONSerialization JSONObjectWithData:str  options:kNilOptions error:nil];
            
            NSMutableArray *loadDefects = [self._data mutableCopy];
            [loadDefects removeObjectAtIndex:indexPath.row];
            self._data = loadDefects;
            [self._table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        [deleteArticleThread setErrorHandler:^(NSString * str) {
            NSLog(@"%@", str);
            
//            [self.spinner stopAnimating];
//            [self.spinner removeFromSuperview];
        }];
        
        [deleteArticleThread start:[[self._data objectAtIndex:indexPath.row] valueForKey:@"nid"]];
    }];

    return @[deleteAction];
}

@end
