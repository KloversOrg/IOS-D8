//
//  ListArticleViewController.h
//  D8
//
//  Created by System Administrator on 6/28/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListArticleViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *_table;

@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@property (nonatomic) NSMutableArray *_data;

@end
