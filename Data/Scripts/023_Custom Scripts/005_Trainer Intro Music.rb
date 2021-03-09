# ------------------------------------------------------------------------------
# Trainer Intro Themes as BGMs
# Script made by: FL, requested by DerxwnaKapsyla
# ------------------------------------------------------------------------------
# To use, simply follow the format listed below. If you want a Trainer Class
# to have an Intro theme, their class has to be defined in here with the
# associated track. 
#
# If the track has an apostraphe in it, it must have a "\" before the 
# apostraphe. For the last entry in the list, remember to not place a comma,
# as that is the end of the array.
#
# To use it in an event, the script for it is "TrainerIntro2(:[Trainer Class])"
# (because I was a silly head and didn't preface it with pb for consistency's
# sake :wacko:.
#
# All the commented out entries are for the Trainer Classes in Essentials
# normally, barring a few exceptions. Uncomment as necessary, or feel free to
# purge the entire list!
# ------------------------------------------------------------------------------

class Interpreter
  TRAINER_BGMS = {
    :FAIRY_1 => 'P-001. The Scenery of Living Dolls',
	:FAIRY_2 => 'P-001. The Scenery of Living Dolls',
	:FAIRY_G => 'P-001. The Scenery of Living Dolls',
	:FAIRY_Z => 'P-003. Year-Round Absorbed Curiosity',
	:YOUKAI_1 => 'P-002. Dancing Water Spray',
	:YOUKAI_2 => 'P-002. Dancing Water Spray',
	:SPIRIT => 'P-002. Dancing Water Spray',
    :YUUKA => 'P-004. Sleeping Terror'
  }
  # Play the trainer eye bgm according to the type defined in Interpreter::TRAINER_BGMS
  # @param type [Symbol] type of trainer (key in TRAINER_BGMS)
#  def trainer_eye_bgm(type, volume = 100, pitch = 100)
  def TrainerIntro2(type, volume = 100, pitch = 100)
    audio_file = TRAINER_BGMS[type]
    Audio.bgm_play("Audio/BGM/Intros/#{audio_file}", volume, pitch) if audio_file
  end
end