//
//  AppConstant.h
//  D8
//
//  Created by System Administrator on 6/29/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#ifndef AppConstant_h
#define AppConstant_h

/*
 [preferences setObject:[jsonDict objectForKey:@"uid"] forKey:@"uid"];
 [preferences setObject:[jsonDict objectForKey:@"session_id"] forKey:@"session_id"];
 */
#define     _isAnonymous            @"is_annonymous"    // เก้บ สถานะว่าเป้น user annonymous หรือไม่

#define		_UID                    @"uid"              // user id
#define		_SESSION_ID             @"session_id"		// session id
#define		_SESSION_NAME           @"session_name"		// session name
#define		_USER                   @"user"             // name, mail, image_url

#endif /* AppConstant_h */
