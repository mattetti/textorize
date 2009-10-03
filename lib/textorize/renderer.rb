framework 'cocoa'

module Textorize
  class Renderer

    def initialize(window, string, options)
      @text_view = NSTextView.alloc.initWithFrame([0,0,0,0])

      set_attr_and_text options, string
      window.contentView = @text_view
      @text_view.sizeToFit
      
      window.display
      window.orderFrontRegardless
    end
    
    def bitmap
      @text_view.lockFocus
      bitmap = NSBitmapImageRep.alloc.initWithFocusedViewRect(@text_view.bounds)
      @text_view.unlockFocus
      bitmap
    end
    
    private 
      
      def set_attr_and_text(options, string)
        @text_view.setHorizontallyResizable(true)
        @text_view.useAllLigatures(nil)
        
        para = NSMutableParagraphStyle.alloc.init
        para.setLineSpacing(options[:lineheight])
        
        attribs = NSMutableDictionary.alloc.init
        attribs.setObject(NSFont.fontWithName(options[:font], size: options[:size]), forKey: NSFontAttributeName)
        attribs.setObject(options[:kerning], forKey: NSKernAttributeName)
        attribs.setObject(para, forKey: NSParagraphStyleAttributeName)
        attribs.setObject(0, forKey: NSBaselineOffsetAttributeName)
        attribs.setObject(options[:obliqueness], forKey: NSObliquenessAttributeName)
        
        @text_view.setTypingAttributes(attribs)
        @text_view.lowerBaseline(nil)
        
        @text_view.string = string
        
        color = (options[:color] || '0,0,0').split(',')
        background = (options[:background] || '1,1,1').split(',')
        
        @text_view.setTextColor(NSColor.colorWithDeviceRed(color[0], green: color[1], blue: color[2], alpha:1))
        @text_view.backgroundColor = NSColor.colorWithDeviceRed(background[0], green: background[1], blue: background[2], alpha:1)
      end
    
  end

end
