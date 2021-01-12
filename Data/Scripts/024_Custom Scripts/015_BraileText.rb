class BrailleWindow < SpriteWindow_Base

attr_reader :text
attr_accessor :charsPerRow
attr_accessor :dotSize
attr_accessor :dotSpacing
attr_accessor :charSpacing
attr_accessor :rowSpacing
attr_accessor :backgroundColor
attr_accessor :darkColor
attr_accessor :lightColor
attr_accessor :borderWidth
attr_accessor :borderHeight

PATTERNS = [1, 3, 9, 25, 17, 11, 27, 19, 10, 26, 5, 7, 13, 29, 21, 15, 31, 23,
  14, 30, 37, 51, 58, 57, 73, 53]

def initialize(text=nil)
  super(0,0,0,0)
  @text = text
  @charsPerRow = 13
  @dotSize = 6
  @dotSpacing = 6
  @charSpacing = 14
  @rowSpacing = 14
  @backgroundColor = Color.new(255, 255, 255)
  @darkColor = Color.new(16, 16, 16)
  @lightColor = Color.new(208, 208, 200)
  @borderWidth = 16
  @borderHeight = 16
  @charWidth = 0
  @fullDotSize = 0
  @rowHeight = 0
  pbDrawBraille if text
end

def pbDrawBraille(text=nil)
  @text = text if text
  count = 0
  pbRefreshContents
  self.contents.fill_rect(self.contents.rect, @backgroundColor)
  @text.upcase.each_byte{|c|
    if c >= 65 && c < 91
      pattern = PATTERNS[c - 65]
    elsif c.chr == "."
      pattern = 50
    elsif c.chr == ","
      pattern = 2
    else
      pattern = 0
    end
    for i in 0...6
      self.contents.fill_rect(
        (count % @charsPerRow) * @charWidth + (i / 3) * @fullDotSize + @borderWidth,
        (i % 3) * @fullDotSize + (count / @charsPerRow) * @rowHeight + @borderHeight,
        @dotSize, @dotSize, pattern & (1 << i) > 0 ? @darkColor : @lightColor)
    end
    count += 1
  }
end

def pbRefreshContents
  @charWidth = 2 * @dotSize + @dotSpacing + @charSpacing
  @fullDotSize = @dotSize + @dotSpacing
  @rowHeight = @dotSize * 3 + @dotSpacing * 2 + @rowSpacing
  numChars = [@charsPerRow, @text.length].min
  self.contents.dispose if self.contents
  self.contents = Bitmap.new(numChars * @charWidth - @charSpacing + @borderWidth * 2,
    @rowHeight * ((@text.length - 1) / @charsPerRow + 1) - @rowSpacing + @borderHeight * 2)
  self.width = self.contents.width + 32
  self.height = self.contents.height + 32
end

def pbCenter
  self.x = (Graphics.width - self.width) / 2
  self.y = (Graphics.height - self.height) / 2
end

end

def pbBrailleMessage(text)
  window=BrailleWindow.new(text)
  window.pbCenter
  pbPlayDecisionSE
  loop do
    Graphics.update
    Input.update
    window.update
    pbUpdateSceneMap
    break if Input.trigger?(Input::C) || Input.trigger?(Input::B)
  end
  window.dispose
  Input.update
end