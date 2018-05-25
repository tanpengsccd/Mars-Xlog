#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AuthTask.h"
#import "C2AiTask.h"
#import "C2GSendTask.h"
#import "C2KfTask.h"
#import "DistributionTask.h"
#import "LogoutTask.h"
#import "PullHistoryTask.h"
#import "SceneEndTask.h"
#import "SyncTask.h"
#import "app_callback.h"
#import "CGITask.h"
#import "NetworkStatus.h"
#import "stn_callback.h"
#import "GZCSLogHelper.h"
#import "GZCSLongLink.h"
#import "longlink_packer.h"
#import "shortlink_packer.h"
#import "stnproto_logic.h"
#import "Auth.pbobjc.h"
#import "C2Ai.pbobjc.h"
#import "C2Gsend.pbobjc.h"
#import "C2Kf.pbobjc.h"
#import "Clienttype.pbobjc.h"
#import "Distribute.pbobjc.h"
#import "Domaintype.pbobjc.h"
#import "History.pbobjc.h"
#import "Kickout.pbobjc.h"
#import "Logout.pbobjc.h"
#import "Messagecmd.pbobjc.h"
#import "Messagetype.pbobjc.h"
#import "Notify.pbobjc.h"
#import "Sceneend.pbobjc.h"
#import "Sync.pbobjc.h"

FOUNDATION_EXPORT double MarSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char MarSDKVersionString[];
