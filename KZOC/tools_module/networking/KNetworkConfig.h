//
//  KNetworkConfig.h
//  TimeInternational
//
//  Created by KZ on 2021/8/1.
//

#ifndef KNetworkConfig_h
#define KNetworkConfig_h

#if DEBUG
#define Base_Domain_Name @"http://sjgj.a40.com.cn/"
#define Base_Image_URL @"http://sjgj.a40.com.cn"
#define Request_timeoutInterval      12
#define UploadImage_timeoutInterval  20
#define UploadVoice_timeoutInterval  202

#else
#define Base_Domain_Name @"http://sjgj.a40.com.cn/"
#define Base_Image_URL @"http://sjgj.a40.com.cn"
#define Request_timeoutInterval      15
#define UploadImage_timeoutInterval  15
#define UploadVoice_timeoutInterval  15

#endif

#endif /* KNetworkConfig_h */
