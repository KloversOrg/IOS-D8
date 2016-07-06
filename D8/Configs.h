//
//  Configs.h
//  Configs
//
//  Created by somkid simajarn on 9/10/2558 BE.
//  Copyright (c) 2558 bit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <CoreLocation/CoreLocation.h>


@interface Configs : NSObject

+ (Configs *)sharedInstance;

-(BOOL)isIPAD;

//-(CLLocationCoordinate2D) getLocation;

@property(nonatomic) NSString* API_URL;

/*
@property(nonatomic) NSString* SLIDE_LASTEST_URL, *LIST_BOOK_LASTEST_URL, *MESSAGE_TABALLNEWS_URL, *MESSAGE_TABNEWSSTEELINDUSTRY_URL, *MESSAGE_TABBUSINESSEWS_URL, *MESSAGE_TABPRESSRELEASES_URL, *STATISTICS_URL, *REPORTANDOTHER_URL, *SUPPORTINGSTEELLNDUSTRY_URL, *SEARCH_MERCHANTS_LIST_URL, *SIGNIN_URL, *SIGNOUT_URL;

@property(nonatomic) NSString* token, *client, *apikey, *model;
 
 sselect_receive_news
 
*/

@property(nonatomic)NSString* SINDEX_URL, *STYPE_REGISTER_URL, *SSELECT_RECEIVE_NEWS,*SREGISTER_RECEIVE_NEWS_URL, *REGISTER_ACTIVITY_URL, *REGISTER_ACTIVITY_JOIN_URL, *SEND_ECARD_ONLINE_URL, *SEND_ECARD_ONLINE_SEND_URL, *EVENTS_CALENDAR_URL, *SEND_ECARD_ONLINE_SELECT_INSIDERS_URL, *SEARCH_CULTURE_URL, *SEARCH_CULTURE_RESULTSEARCH_URL, *EVENT_SEARCH, *EVENT_SEARCH_RESULT, *COMPLAINT/*scomplaint*/, *COMPLAINT_INPUTEMAIL/*scomplaint_inputemail.php*/, *FOLLOW_COMPLAINT /*FollowComplaint*/, *SSEND_ECARD_OUTSER/* ssend_ecard_outsider.php */; // Search_Culture_ResultSearch


// SendEcardOnline_Select_InsidersThread SEND_ECARD_ONLINE_SELECT_INSIDERS_URL

@end
