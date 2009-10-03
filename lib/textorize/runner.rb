module Textorize
  class Runner
    
    def initialize(string, output, options)
      app = NSApplication.sharedApplication
      
      delegate = RunnerApplication.alloc.init
      delegate.options = options
      delegate.string = string
      delegate.output = output
      
      app.delegate = delegate
      app.run
    end
    
  end

  class RunnerApplication
    attr_accessor :options
    attr_accessor :string
    attr_accessor :output

    def initialize
      @window = NSWindow.alloc.initWithContentRect([-2000, -2000, 2000, 2000], styleMask: NSBorderlessWindowMask, backing: 2, defer: 0)
    end
    
    def applicationDidFinishLaunching(notification)
      renderer = Renderer.new(@window, @string, @options)
      Saver.new(renderer).write_to_file(@output)
      NSApplication.sharedApplication.terminate(nil)
    end
    
  end

end
