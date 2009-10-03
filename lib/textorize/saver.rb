module Textorize
  class Saver
    attr_reader :png
    
    def initialize(renderer)
      bitmap = renderer.bitmap
      @png = bitmap.representationUsingType(NSPNGFileType, properties: nil)
    end
    
    def write_to_file(file)
      @png.writeToFile(file, atomically: true)
    end

  end
end