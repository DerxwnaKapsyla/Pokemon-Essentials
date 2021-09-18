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
    :DEVELOPER 		=> 'P-001. Demystify Feast',
	:HEXMANIAC 		=> 'P-002. Trainers\' Eyes Meet (Hex Maniac)',
    :AROMALADY 		=> 'P-007. Trainers\' Eyes Meet (Lass)',
    :BEAUTY 		=> 'P-003. Trainers\' Eyes Meet (Girl 1)',
#    :BIKER 		=> 'P-001. Demystify Feast',
    :BIRDKEEPER 	=> 'P-010. Trainers\' Eyes Meet (Cooltrainer)',
    :BUGCATCHER 	=> 'P-005. A Trainer Appears (Boy Version)',
    :BURGLAR 		=> 'P-004. A Trainer Appears (Bad Guy Version)',
    :CHANELLER 		=> 'P-002. Trainers\' Eyes Meet (Hex Maniac)',
#    :CUEBALL 		=> 'P-001. Demystify Feast',
    :ENGINEER 		=> 'P-006. Trainers\' Eyes Meet (Hiker)',
    :FISHERMAN 		=> 'P-006. Trainers\' Eyes Meet (Hiker)',
#    :GAMBLER 		=> 'P-001. Demystify Feast',
    :GENTLEMAN 		=> 'P-017. Trainers\' Eyes Meet (Gentleman)',
    :HIKER 			=> 'P-006. Trainers\' Eyes Meet (Hiker)',
#    :JUGGLER 		=> 'P-001. Demystify Feast',
    :LADY 			=> 'P-003. Trainers\' Eyes Meet (Girl 1)',
    :PAINTER 		=> 'P-016. Trainers\' Eyes Meet (Artist)',
#    :POKEMANIAC 	=> 'P-001. Demystify Feast',
#    :POKEMONBREEDER => 'P-001. Demystify Feast',
#    :PROFESSOR 	=> 'P-001. Demystify Feast',
#    :ROCKER 		=> 'P-001. Demystify Feast',
    :RUINMANIAC 	=> 'P-006. Trainers\' Eyes Meet (Hiker)',
#    :SAILOR 		=> 'P-001. Demystify Feast',
    :SCIENTIST 		=> 'P-008. Trainers\' Eyes Meet (Psychic)',
    :SUPERNERD 		=> 'P-008. Trainers\' Eyes Meet (Psychic)',
    :TAMER 			=> 'P-010. Trainers\' Eyes Meet (Cooltrainer)',
    :BLACKBELT 		=> 'P-018. Trainers\' Eyes Meet (Black Belt)',
    :CRUSHGIRL 		=> 'P-018. Trainers\' Eyes Meet (Black Belt)',
    :CAMPER 		=> 'P-005. A Trainer Appears (Boy Version)',
    :PICNICKER 		=> 'P-011. A Trainer Appears (Girl Version)',
    :COOLTRAINER_M 	=> 'P-010. Trainers\' Eyes Meet (Cooltrainer)',
    :COOLTRAINER_F 	=> 'P-010. Trainers\' Eyes Meet (Cooltrainer)',
    :YOUNGSTER 		=> 'P-009. Trainers\' Eyes Meet (Youngster)',
    :LASS 			=> 'P-007. Trainers\' Eyes Meet (Lass)',
#    :POKEMONRANGER_M => 'P-001. Demystify Feast',
#    :POKEMONRANGER_F => 'P-001. Demystify Feast',
    :PSYCHIC_M 		=> 'P-008. Trainers\' Eyes Meet (Psychic)',
    :PSYCHIC_F 		=> 'P-008. Trainers\' Eyes Meet (Psychic)',
#    :SWIMMER_M 	=> 'P-001. Demystify Feast',
    :SWIMMER_F 	=> 'P-011. A Trainer Appears (Girl Version).ogg',
#    :SWIMMER2_M 	=> 'P-001. Demystify Feast',
    :SWIMMER2_F 	=> 'P-011. A Trainer Appears (Girl Version).ogg',
#    :TUBER_M 		=> 'P-001. Demystify Feast',
#    :TUBER_F 		=> 'P-001. Demystify Feast',
#    :TUBER2_M 		=> 'P-001. Demystify Feast',
#    :TUBER2_F 		=> 'P-001. Demystify Feast',
#    :COOLCOUPLE 	=> 'P-001. Demystify Feast',
#    :CRUSHKIN 		=> 'P-001. Demystify Feast',
#    :SISANDBRO 	=> 'P-001. Demystify Feast',
#    :TWINS 		=> 'P-001. Demystify Feast',
#    :YOUNGCOUPLE 	=> 'P-001. Demystify Feast',
	:TEAMROCKET_M	=> 'P-014. Trainers\' Eyes Meet (Team Rocket)',
	:TEAMROCKET_F	=> 'P-014. Trainers\' Eyes Meet (Team Rocket)',
	:ROCKETBOSS		=> 'P-014. Trainers\' Eyes Meet (Team Rocket)',
	:WORKER 		=> 'P-006. Trainers\' Eyes Meet (Hiker)',
    :SCRenko 		=> 'P-012. Girls\' Sealing Club',
	:SCMary 		=> 'P-012. Girls\' Sealing Club',
	:RIVAL_Gold 	=> 'P-013. Encounter - Gold',
	:COLLECTOR 		=> 'P-015. Trainers\' Eyes Meet (Collector)'
  }
  # Play the trainer eye bgm according to the type defined in Interpreter::TRAINER_BGMS
  # @param type [Symbol] type of trainer (key in TRAINER_BGMS)
#  def trainer_eye_bgm(type, volume = 100, pitch = 100)
  def TrainerIntro2(type, volume = 100, pitch = 100)
    audio_file = TRAINER_BGMS[type]
    Audio.bgm_play("Audio/BGM/Intros/#{audio_file}", volume, pitch) if audio_file
  end
end