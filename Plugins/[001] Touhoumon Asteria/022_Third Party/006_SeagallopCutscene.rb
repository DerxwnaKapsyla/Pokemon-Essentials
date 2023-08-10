#===============================================================================
#===============================================================================
#===============================================================================
# Seagallop (boat "cutscene") • by Mr. Gela/theo#7722
# Updated to V21.1 by RealMugen
# With adjustments made by DerxwnaKapsyla
#-------------------------------------------------------------------------------
# USING THIS SCRIPT
#-------------------------------------------------------------------------------
#
# Call using 'seaGallop' as a script call in an event, etc.
#
#===============================================================================
#===============================================================================
#===============================================================================

if !PluginManager.installed?("Seagallop Cutscene")
  PluginManager.register({                                                 
    :name    => "Seagallop Cutscene",                                        
    :version => "1.0",                                                     
    :link    => "https://reliccastle.com/resources/389/",             
    :credits => "Mr. Gela, DerxwnaKapsyla, Realmugen"
  })
end

  # Calls the scene
  def seaGallop(mirror=false)
    pbFadeOutIn(99999){
      scene=Seagallop_Scene.new
      screen=Seagallop_Screen.new(scene)
      screen.pbStartScreen(mirror)
    }
  end
  
  # Wait utility
  def wait(frames)
    frames.times do
      Graphics.update
    end
  end
  
  # Actual scene
  class Seagallop_Scene
  
    def pbUpdate
      pbUpdateSpriteHash(@sprites)
      if @mirror==false # Not mirrored
        if @sprites["bg"]
          @sprites["bg"].ox-=1.5 # Move sea towards the right
        end
        if @sprites["wind"]
          @sprites["wind"].ox+=18 # Move wind towards the left
        end
      else # Mirrored
        if @sprites["bg"]
          @sprites["bg"].ox+=1.5 # Move sea towards the right
        end
        if @sprites["wind"]
          @sprites["wind"].ox-=18 # Move wind towards the left
        end
      end
    end
  
    def boatAnimation
      boat=@sprites["boat"]
      trail=@sprites["trail"]
	  pbSEPlay("Seagallop Ferry")
      if @mirror==false # Not mirrored
        for i in 1..120
          pbUpdate
          boat.x+=9   # move boat every frame
          if (i%2)==0 # move trail but only every two frames
                      # cause that's kind of what FRLG does
            trail.x+=9*2 
          end
          wait(1)
        end
      else # Mirrored
        for i in 1..130
          pbUpdate
          boat.x-=9   # move boat every frame
          if (i%2)==0 # move trail but only every two frames
                      # cause that's kind of what FRLG does
            trail.x-=9*2 
          end
          wait(1)
        end
      end
      pbEndScene
    end
    
    def pbStartScene(mirror)
      @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
      @viewport.z = 99999
      @sprites = {}
      @mirror=mirror
        # bg
        addBackgroundPlane(@sprites,"bg","Seagallop/waterBg",@viewport)
        @sprites["bg"].zoom_x=2
        @sprites["bg"].zoom_y=2
        
        # bg "overlay"
        addBackgroundPlane(@sprites,"wind","Seagallop/waterWind0",@viewport)
        @sprites["wind"].zoom_x=2
        @sprites["wind"].zoom_y=2
        
      if @mirror==false # Not mirrored  
        # boat
        @sprites["boat"] = IconSprite.new(0,0,@viewport)
        @sprites["boat"].setBitmap("Graphics/UI/Seagallop/waterBoat")
        @sprites["boat"].zoom_x=2
        @sprites["boat"].zoom_y=2
        @sprites["boat"].x=0-@sprites["boat"].bitmap.width*2
        @sprites["boat"].y=(Graphics.height-@sprites["boat"].bitmap.height)/2 
        @sprites["boat"].z+=1
        
        # graphic under the boat
        @sprites["trail"] = IconSprite.new(0,0,@viewport)
        @sprites["trail"].setBitmap("Graphics/UI/Seagallop/waterTrail")
        @sprites["trail"].zoom_x=2
        @sprites["trail"].zoom_y=2
        @sprites["trail"].x=@sprites["boat"].x-@sprites["trail"].bitmap.width*2+42*2
        @sprites["trail"].y=@sprites["boat"].y+15*2
        
      else # Mirrored
        # boat
        @sprites["boat"] = IconSprite.new(0,0,@viewport)
        @sprites["boat"].setBitmap("Graphics/UI/Seagallop/waterBoat")
        @sprites["boat"].zoom_x=2
        @sprites["boat"].zoom_y=2
        @sprites["boat"].x=Graphics.width+@sprites["boat"].bitmap.width-30
        @sprites["boat"].y=(Graphics.height-@sprites["boat"].bitmap.height)/2 
        @sprites["boat"].z+=1
        @sprites["boat"].mirror=true
        
        # graphic under the boat
        @sprites["trail"] = IconSprite.new(0,0,@viewport)
        @sprites["trail"].setBitmap("Graphics/UI/Seagallop/waterTrail")
        @sprites["trail"].zoom_x=2
        @sprites["trail"].zoom_y=2
        @sprites["trail"].x=@sprites["boat"].x+@sprites["boat"].bitmap.width-10
        @sprites["trail"].y=@sprites["boat"].y+15*2
        @sprites["trail"].mirror=true

      end
      


      pbFadeInAndShow(@sprites) { pbUpdate }
      boatAnimation
    end
    
    def pbEndScene
	  pbFadeOutAndHide(@sprites) { pbUpdate }
      pbDisposeSpriteHash(@sprites)
      @viewport.dispose
    end
  end
  
  class Seagallop_Screen
    def initialize(scene)
      @scene = scene
    end
  
    def pbStartScreen(mirror)
      @scene.pbStartScene(mirror)
    end
  end