//
//  Configs.m
//  lottery
//
//  Created by somkid simajarn on 8/14/2558 BE.
//  Copyright (c) 2558 bit. All rights reserved.
//

#import "Configs.h"
#import <sys/utsname.h>



//#define IDIOM
//#define IPAD     UIUserInterfaceIdiomPad

@implementation Configs

+ (Configs *)sharedInstance
{
    static Configs *sharedInstance;
    
    @synchronized(self)
    {
        if (!sharedInstance)
            sharedInstance = [[Configs alloc] init];
        
        return sharedInstance;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        // sindex.php
        self.API_URL = @"http://203.150.224.249/ewtadmin_mculture/ewt/ilove/mservices";
        
        // self.API_URL = @"http://localhost/mservices";
        
        self.SINDEX_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/sindex.php"];
        self.STYPE_REGISTER_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/stype_register.php"];
        
        self.SSELECT_RECEIVE_NEWS =[NSString stringWithFormat:@"%@%@", self.API_URL, @"/sselect_receive_news.php"];
        self.SREGISTER_RECEIVE_NEWS_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/sregister_receive_news.php"];
        self.REGISTER_ACTIVITY_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/slist_all_activity.php"];
        self.REGISTER_ACTIVITY_JOIN_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/sregister_activity.php"];
        self.SEND_ECARD_ONLINE_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/sselect_ecard.php"];
        self.SEND_ECARD_ONLINE_SEND_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/ssend_ecard.php"];
        self.EVENTS_CALENDAR_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/scalendar_activity.php"];
        self.SEND_ECARD_ONLINE_SELECT_INSIDERS_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/sdepartment_ecard.php"];
        self.SEARCH_CULTURE_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/ssearch_culture.php"];
        self.SEARCH_CULTURE_RESULTSEARCH_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/ssearch_culture_resultsearch.php"];
        
        
        self.EVENT_SEARCH= [NSString stringWithFormat:@"%@%@", self.API_URL, @"/sevent_search.php"];
        self.EVENT_SEARCH_RESULT = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/sevent_search_result.php"];
        
        
        /* แจ้งเรื่องร้องเรียน #1 */
        self.COMPLAINT = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/scomplaint.php"];
        
        /* แจ้งเรื่องร้องเรียน #2 */ // UploadImage/Upload_Image.php
        self.COMPLAINT_INPUTEMAIL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/scomplaint_inputemail.php"];
        self.FOLLOW_COMPLAINT = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/sfollow_complaint.php"];
        
        
        //
        self.SSEND_ECARD_OUTSER = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/ssend_ecard_outsider.php"];
        
        
        /*
        self.token = @"7805e8c3-01ce-426c-a8d7-eba12b666392";
        self.client = @"device_id";
        self.apikey = @"7F5A5050-A9BC-4833-8628-E723C84C3A19";
        self.model = [self modelDevice];
        
        // หน้าหลัก
        self.SLIDE_LASTEST_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/news.aspx/lastest"];// slide show
        self.LIST_BOOK_LASTEST_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/journals.aspx/lastest"]; // list book
        
        // หน้าหลัก->ค้นหารายชื่อผู้ประกอบการ
        self.SEARCH_MERCHANTS_LIST_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/directory.aspx/searchform"];
        
        // ข่าวสาร
        self.MESSAGE_TABALLNEWS_URL =[NSString stringWithFormat:@"%@%@", self.API_URL, @"/news.aspx"];
        self.MESSAGE_TABNEWSSTEELINDUSTRY_URL =[NSString stringWithFormat:@"%@%@", self.API_URL, @"/news.aspx/industry"];
        self.MESSAGE_TABBUSINESSEWS_URL =[NSString stringWithFormat:@"%@%@", self.API_URL, @"/news.aspx/business"];
        self.MESSAGE_TABPRESSRELEASES_URL =[NSString stringWithFormat:@"%@%@", self.API_URL, @"/news.aspx/pr"];
        
        // ข้อมูลสถิติ
        self.STATISTICS_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/statistics.aspx"];
        
        // วารสารและรายงานอืนๆ
        self.REPORTANDOTHER_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/journals.aspx"];
        
        // ข้อมูลสนับสนุนอุตสาหกรรมเหล็ก
        self.SUPPORTINGSTEELLNDUSTRY_URL = [NSString stringWithFormat:@"%@%@", self.API_URL, @"/supportinfo.aspx"];
        
        
        // signin
        self.SIGNIN_URL =[NSString stringWithFormat:@"%@%@", self.API_URL, @"/authen.aspx/signin"];
        
        // signout  public static final String SIGNOUT_URL = API_URL + "/authen.aspx/signout";
        self.SIGNOUT_URL =[NSString stringWithFormat:@"%@%@", self.API_URL, @"/authen.aspx/signout"];
        */
        
    
    }
    return self;
}

/*
 -(void)method {
 
 }
 */

-(NSString*) modelDevice
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

-(BOOL)isIPAD
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        /* do something specifically for iPad. */
        
        return TRUE;
    } else {
        /* do something specifically for iPhone or iPod touch. */
        
        return FALSE;
    }
}

//-(CLLocationCoordinate2D) getLocation{
//    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    [locationManager startUpdatingLocation];
//    CLLocation *location = [locationManager location];
//    CLLocationCoordinate2D coordinate = [location coordinate];
//    
//    return coordinate;
//}

@end
