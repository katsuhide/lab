#
#  AppDelegate.rb
#  MacRubyTest
#
#  Created by AirMyac on 5/20/13.
#  Copyright 2013 com.katzlifehack. All rights reserved.
#

class AppDelegate
    attr_accessor :window
    attr_accessor :textField # アウトレット
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
    end
    
    
    def startTimer(sender)
        # タイマー開始
        if @timer.nil?
            @time = 0.0
            
            @timer = NSTimer
            .scheduledTimerWithTimeInterval(0.1, 
                                        target: self,
                                        selector: "timerHandler:",
                                        userInfo: nil,
                                        repeats: true)
        
        end
    end

    def test(sender)
        textField.setStringValue("1000")
    end        

    def stopTimer(sender)
        # タイマー停止
        if @timer
            @timer.invalidate
            @timer = nil
        end
    end

    def timerHandler(obj)
        # 一定間隔ごとに処理する内容
        @time += 0.1
        string = sprintf("%.1f", @time)        
        textField.setStringValue(string)
    end
    
end

