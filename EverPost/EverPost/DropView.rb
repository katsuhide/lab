#
#  DropView.rb
#  EverPost
#
#  Created by AirMyac on 5/23/13.
#  Copyright 2013 com.katzlifehack. All rights reserved.
#
# encoding: utf-8

require 'AppDelegate'

class DropView < NSBox

    def initWithFrame(rect)
        if super
            self.registerForDraggedTypes([NSColorPboardType, NSFilenamesPboardType])
            self.setTitle("")
            return self
        end
    end
    
    def draggingEntered(sender)
        sourceDragMask = sender.draggingSourceOperationMask
        pboard = sender.draggingPasteboard
   
        if pboard.types.containsObject(NSColorPboardType)
            if sourceDragMask && NSDragOperationGeneric
                return NSDragOperationGeneric
            end 
        end  

        if pboard.types.containsObject(NSFilenamesPboardType)
            if sourceDragMask && NSDragOperationLink
                return NSDragOperationLink
            elsif sourceDragMask && NSDragOperationCopy
                return NSDragOperationCopy
            end
        end

        return NSDragOperationNone 
    end

    
    def performDragOperation(sender)
        AppDelegate::clear_attached_files()
        sourceDragMask = sender.draggingSourceOperationMask
        pboard = sender.draggingPasteboard
   
        if pboard.types.containsObject(NSFilenamesPboardType)
            files = pboard.propertyListForType(NSFilenamesPboardType)
            AppDelegate::set_attached_files(files)
        end

        return true
    end

end

