@interface TUCallCenter
+(id)sharedInstance;
- (id)incomingCall;
- (void)answerCall:(id)arg1;
@end

@interface TUVideoProxyCallManager
- (void)_postVideoNotificationName:(id)arg1 forCall:(id)arg2 userInfo:(id)arg3;
@end


%hook TUCall
-(void)_handleStatusChange {
	%orig;

	id incomingCall = [[%c(TUCallCenter) sharedInstance] incomingCall];

	if(incomingCall) {
		//regular calls
		[[%c(TUCallCenter) sharedInstance] answerCall:incomingCall];
	}

}
%end

%hook TUVideoProxyCall
-(void)updateWithCall:(id)arg1 {
	%orig;
	//facetime
	[[%c(TUCallCenter) sharedInstance] answerCall:arg1];
}
%end