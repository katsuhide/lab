#
#  DropView2.rb
#  DropView2
#
#  Created by AirMyac on 5/23/13.
#  Copyright 2013 com.katzlifehack. All rights reserved.
#

class DropView2 < NSView

    def initWithFrame(rect)
        if super
            # self.registerForDraggedTypes([NSFilenamesPboardType])
            self.registerForDraggedTypes([NSColorPboardType, NSFilenamesPboardType])
            return self
        end
    end
    
    
    def draggingEntered(sender)
        puts "dragging entered"

        sourceDragMask = sender.draggingSourceOperationMask
        pboard = sender.draggingPasteboard
   
        if pboard.types.containsObject(NSColorPboardType)
            puts "color type true"
            if sourceDragMask && NSDragOperationGeneric
                puts "dragmask true"
                return NSDragOperationGeneric
            else
                puts "dragmask false"
            end 
        else
            puts "color type false"
        end  

        if pboard.types.containsObject(NSFilenamesPboardType)
            puts "file type true"
            if sourceDragMask && NSDragOperationLink
                puts "drag ope link"
                return NSDragOperationLink
            elsif sourceDragMask && NSDragOperationCopy
                puts "drag ope copy"
                return NSDragOperationCopy
            else
                puts "drag ope false"
            end
        else
            puts "file type false"
        end

        return NSDragOperationNone 
    end

    
    def performDragOperation(sender)
        puts "perform drag operation"

        sourceDragMask = sender.draggingSourceOperationMask
        pboard = sender.draggingPasteboard
   
        if pboard.types.containsObject(NSFilenamesPboardType)
            puts "file type true"
            files = pboard.propertyListForType(NSFilenamesPboardType)
            puts files
        else
            puts "file type false"
        end
        return true
    end

end
