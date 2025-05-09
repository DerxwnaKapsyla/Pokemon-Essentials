def textbook(book)
  pbFadeOutIn {
    scene = Textbook_Scene.new
    screen = TextbookScreen.new(scene)
    screen.pbStartTextbookScreen(book)
    yield if block_given?
  }
end


class TextbookScreen
  def initialize(scene)
    @scene = scene
  end

  def pbStartTextbookScreen(book)
    @scene.pbStartTextbookScene(book)
    ret = @scene.pbTextbookScene
    @scene.pbEndScene
    return ret
  end

end


#books
GensouKyouEdict = [
"The Gensou Kyou Edict: Info","At dusk's rise, we, the members of this council, have come to a decision regarding the series of incidents between Humans, Youkai, and Pokémon caught between them. In three months time, an area of land will be quarantined off with the Hakurei Shrine at its center that shall be the new home of Youkai and the Humans who wish to coexist with them. Said idea was proposed by the Youkai Sage of Boundaries, Yukari Yakumo, who claims that her and her kin have grown tired of fighting,",
"The Gensou Kyou Edict: Info","and would like a place where they can reside in peace and isolation. The local shrine maiden, Meira Hakurei, has seconded the notion, volunteering herself to be the one to enter this quarantined land to serve as the one to upkeep the barrier, while her sister, Seira Hakurei, will make the precautions to ensure it stays stable outside of the barrier. This plan shall henceforth be known as the \"Gensou Kyou edict\".",
"The Gensou Kyou Edict: Info","We, the undersigned, hereby agree to the following terms and conditions of this edict.",
"The Gensou Kyou Edict: Terms","Condition 1: All Youkai must vacate to the quarantined area before the end of the third month. Those who don't will be exterminated.\nCondition 2: All Humans who wish to join the Youkai must vacate to the quarantined area before the end of the third month.\nCondition 3: All Pokémon and Humans with Pokémon are forbidden from entering and residing in the quarantined area.",
"The Gensou Kyou Edict: Terms","Condition 4: All Youkai caught leaving the quarantined area after it has been sealed off will be exterminated on sight.\nCondition 5: All Humans caught leaving the quarantined area after it has been sealed off will be exiled from the nearby villages.",
"The Gensou Kyou Edict: Signed","Meira Hakurei, Shrine Maiden of Hakurei Shrine\nYukari Yakumo, Youkai Sage and representative of Youkai\nKuro Enju, Chief of E. Village and representative of Humans.\nShinako, Ascendant Espeon and Representative of Pokémon"
]

HistoryOfGensokyo = [
"History of Gensokyo","Before the creation of the Great Hakurei Barrier in the year of 1885 in the outside world, Gensokyo existed as an area of land within the Mortar Mountain Range of the Johto Region. At the time of its creation, Seira and Meira Hakurei were the twin maintainers of the Hakurei Shrine, which oversaw the balance between Humans and Youkai of the Outside World. During this era, the Johto Region was experiencing a turbulent period.",

"History of Gensokyo","Internally they were exploring more of their land and establishing new settlements and roads between them. Externally, however, they were embroiled in a border conflict with the neighboring Kanto Region. Tensions eventually boiled over, culminating in a full-scale war between the two countries. This incident would become known as the Great Tohjo War. The war ended in a stalemate, with both sides agreeing to never infringe upon one another again.",

"History of Gensokyo","Peace did not return to Johto, however, as not long after the war ended, a Youkai Insurrection occurred, resulting in an event known as the Razing of Brass Tower. This caused the already tense situation between Humans and Youkai to get worse. This incident, as well as the fact that Humans were becoming less afraid of Youkai and less dependent on Gods and Divinity as a whole thanks to the rise of more reliable and advanced technology, the Sages of Gensokyo",

"History of Gensokyo","and the Hakurei Shrine set out to draft a plan to separate Youkai from Humans: The Gensokyo Edict. When the barrier was erected, Youkai and those sympathetic to Youkai were the only ones allowed into the new realm. The barrier has stood firm for over a hundred years now thanks to the diligence of the Hakurei Shrine Maiden and the Sages of Gensokyo.",
]

HakureiClanHistory = [
"History of the Hakurei Clan","The Hakurei Shrine has existed for several hundred years and has served as the maintainer of balance between Humans and Youkai since its inception. Initially a regular shrine, the marriage between a priest of one shrine and priestess of another shrine gave birth to the joint shrine which would later become known as the Hakurei Shrine. Under the protection of the God of the Hakurei Clan, [REDACTED], those born with the blood of the Hakurei running through them were",

"History of the Hakurei Clan","blessed with the ability to \"separate from reality\", which they often used as a way to arbitrate incidents between Humans and Youkai. Later down the line, they were the only ones who could effectively control the Divine Relic of the Hakurei Clan, the Hakurei Yin-Yang Orb. Spiritual power tends to flow the strongest in the women of the Hakurei Clan, but there have been known cases where males have been blessed with strong spiritual presence. ",

"History of the Hakurei Clan","Those who marry into the Hakurei Clan adopt the surname of Hakurei, as do all children born within the clan. While most of the Hakurei Shrine Priests and Priestesses lived relatively obscure existences, there were several of them that are well known throughout Gensokyo's history. A short list of them are as follows:",

"History of the Hakurei Clan","Meira and Seira Hakurei, the twin shrine maidens that served during the creation of the Great Hakurei Barrier. In order to create the Barrier, the Hakurei Shrine needed to be maintained on both sides of the barrier, which resulted in Meira and Seira separating to serve as each the Shrine Maiden of their respective realm's shrine. These two are regarded as the most spiritually powerful Hakurei Shrine Maidens in all of the clan's existence.",

"History of the Hakurei Clan","Ayame Hakurei, the only known Hakurei Shrine Maiden to settle incidents with their physical prowess as opposed to their spiritual power. Known as one of the most dangerous Hakurei Shrine Maidens to encounter if you were a Youkai. There are rumors that she once went toe-to-toe with a Shadow-walker Youkai and won handily, but Ayame has never confirmed these rumors. She would later go on to give birth to Reimu Hakurei.",

"History of the Hakurei Clan","Reimu Hakurei, the current Hakurei Shrine Maiden, and the creator of the Spell Card Rule which Gensokyo uses to settle incidents. While very laid back, Reimu's intuition is second to none when it comes to resolving incidents. During her era, Youkai have been spotted more frequently at the Hakurei Shrine, leading people to believe she has become a Shrine Maiden for Youkai. Despite that, Reimu remains dedicated to maintaining the peace between Humans and Youkai, ",

"History of the Hakurei Clan","as well as the peace within Gensokyo.",

"History of the Hakurei Clan","As a result of its power, there have been many plays by rival factions and hostile parties to obtain the Hakurei Clan's power. Though these incidents have died down in recent years after the establishment of the Spell Card Rule, they have not stopped in their entirety. Of note is repeated attempts by the Vengeful Spirit Magician, Mima, to try and best the Hakurei Shrine. She has been at this for several hundred years. It is theorized that, at this point, she does ",

"History of the Hakurei Clan","it because she has nothing better to do and finds enjoyment in tormenting the current Hakurei Shrine Maiden.\n\nDespite the formation of other shrines and temples within Gensokyo, such as Moriya Shrine and Myouren Temple, the Hakurei Shrine is still the active maintainer of Gensokyo's balance and the stability of the Great Hakurei Barrier."
]

IncidentHistory = [
"History of Gensokyo's Incidents","Gensokyo has played host to several incidents across the many centuries. This document serves as a comprehensive list of the most well known incidents and events in modern Gensokyo history.",

"History of Gensokyo's Incidents","The Great Barrier Disturbance, 1885. This marks the official date that Gensokyo was sealed off from the Outside World, thanks to the creation of the Great Hakurei Barrier. Marks the beginning of the Gensokyo calendar system, with this being Season 0.",

"History of Gensokyo's Incidents","Invasion of the Hakurei Shrine - Spring, Season 116. This incident revolved around the unsealing of the Vengeful Spirit, Mima, which led to the swarm of Youkai and Ghosts invading the Hakurei Shrine.",

"History of Gensokyo's Incidents","The Wish-Granting Ruins Incident - Autumn, Season 116. This incident revolved around the appearance of ruins within Gensokyo that claimed to grant a wish to whoever is able to successfully enter the ruins.",

"History of Gensokyo's Incidents","Invasion of the Hakurei Shrine II - Summer, Season 117. This incident revolved around the second invasion of the Hakurei Shrine, which came as a result of a disturbance emanating within the Fantasy World.",

"History of Gensokyo's Incidents","Makai Invasion - Winter, Season 117. This incident revolved around another invasion of Youkai, this time originating from the realm of Makai. Apparently, this was a result of a Makai-based civilian tourism initiative arranging tours of Gensokyo without the approval of the creator of Makai, nor any inhabitants of Gensokyo.",

"History of Gensokyo's Incidents","Not officially regarded as an incident, during the Spring of Season 118, the Great Hakurei Barrier mysteriously weakened, which allowed an outside world construct to make its way into Gensokyo. This construct claimed to be a \"Robot\" by the name of VIVIT.",

"History of Gensokyo's Incidents","The Vampire Incident - Summer, Season 118. This incident revolved around a vampire attempting to overthrow the societal structure of Gensokyo. This incident is most known for being the one that gave birth to the Spell Card Rule.",

"History of Gensokyo's Incidents","The Scarlet Mist Incident - Summer, Season 118. This incident came about as a result of the previous incident, where the vampire instigator of the previous incident caused a scarlet mist to spread across Gensokyo, preventing sunlight from reaching the realm.",

"History of Gensokyo's Incidents","The Spring Snow Incident - Spring, Season 119. This incident revolved around an unending snowfall, preventing Spring from coming proper. The instigator hailed from the Netherworld, aiming to steal the essence of Spring to revive a powerful Youkai Sakura Tree.",

"History of Gensokyo's Incidents","Night Parade of One Hundred Oni Every Four Days - Summer, Season 119. This incident revolved around a rather strange phenomenon; Every three days, a feast was being held at the Hakurei Shrine for no discernible reason. The instigator of this incident was one of the Four Devas of the Mountain, who was upset that the flower-viewing season lasted a short period thanks to the Spring Snow Incident.",

"History of Gensokyo's Incidents","The Eternal Night Incident - Autumn, Season 119. This incident revolved around the replacement of the Moon with a Fake Moon, which caused Youkai to grow more powerful and active. The perpetrators of this incident were the Lunarians that reside within the Bamboo Forest of the Lost in an effort to avoid being found by the Lunar Capital.",

"History of Gensokyo's Incidents","The Sixty Year Cycle Great Barrier Incident - Spring, Season 120. An incident of happenstance and not of malice; an influx of flowers bloomed across Gensokyo, which were the result of Ghosts waiting to be ferried over to Higan. The Shikigami in charge of ferrying the deceased was not helming their post, which is what resulted in this incident occurring.",

"History of Gensokyo's Incidents","The Abnormal Weather Incident - Summer, Season 123. This incident revolved around the strange weather patterns that were occurring across Gensokyo. This ultimately culminated in the destruction of the Hakurei Shrine. The perpetrator of this incident was a Celestial of Heaven that sought to imitate the Youkai of Gensokyo by causing a catastrophe of her own.",

"History of Gensokyo's Incidents","Underground Spirit Invasion - Winter, Season 123. This incident revolved around the invasion of several earth spirits from the Underground. The perpetrator of this incident was a Kasha that resided in the Underground in an attempt to call the Hakurei Shrine Maiden down to deal with a Hell Raven that had grown too powerful.",

"History of Gensokyo's Incidents","The Unidentified Flying Objects Incident - Spring, Season 124. This incident wasn't so much of an issue as it was a spectacle. Several unidentifiable objects flew across the skies of Gensokyo. The perpetrator of this incident, if it could be called that, was a Nue that disguised objects that other factions were trying to collect while aiming to unseal a human priestess from Makai.",

"History of Gensokyo's Incidents","The Divine Spirits Incident - Spring, Season 126. Similar to the previous incident, this one was more of a spectacle than an issue. Divine Spirits were witnessed showing up all across Gensokyo. The reason for this was to witness the resurrection of the legendary Prince Shoutoku, most known for spreading Buddhism across the Outside World.",

"History of Gensokyo's Incidents","The Great Religion War - Summer, Season 128. As a result of all of the incidents plaguing Gensokyo in recent years, the Human Village fell into pessimism. This prompted action from all of the religious factions in Gensokyo to try and \"save\" the humans by converting them to their religion.",

"History of Gensokyo's Incidents","The Reversal Incident - Autumn, Season 128. This incident revolved around various Youkai uprisings across Gensokyo, as well as the appearance of new tsukumogami everywhere. The instigator of this incident was a Kijin that sought to overthrow the order of Gensokyo, and manipulated an Inchling Princess into assisting her.",

"History of Gensokyo's Incidents","The Urban Legend Incident - Spring, Season 130. This incident revolved around the appearance of Urban Legends within Gensokyo, as well as the ability to control and manifest them. The perpetrator of this incident was a Human from the Outside World that was messing around with Occult Orbs.",

"History of Gensokyo's Incidents","The Urban Legend Incident is, currently, the most recent Incident to have occurred within Gensokyo. It is also the last incident that was revolved under the Spell Card Era, as months after that the Puppet Era began.",
]

# "It's a republished version of the Gensokyo Chronicle, 9th Edition."
# "It's way too large to read all in one sitting... I'll just flip to specific sections."
# > Youkai
# > > Rumia
# > > Nue
# > > Medicine
# > > Yuuka
# > > Yamame
# > > Yukari
# > > Koishi
# > > Nazrin
# > Non-Youkai
# > > Reimu
# > > Marisa
# > > Eirin
# > > Sanae
# > > Byakuren
# > > Keine
# > Divinity
# > > Kanako
# > > Minoriko
# > > Eiki Shiki
# > Locations
# > > Human Village
# > > Hakurei Shrine
# > > Forest of Magic
# > > Scarlet Devil Mansion
# > > Hakugyokurou
# > > Eientei
# > > Lunar Capital
# > Spell Card Rule Draft
# > About the Author
GensokyoChronicle_Rumia = [
"Gensokyo Chronicle - Rumia","<ac>Youkai of the Dusk</ac>\n<ac>Rumia</ac>\nAbility: Manipulation of Darkness\nThreat Level: Medium\nHuman Friendship Level: Low\nMain Place of Activity: Unknown",

"Gensokyo Chronicle - Rumia","Rumia falls into the weaker category of youkai, but she possesses an ability that makes her surroundings dark whether it is night or day. The darkness this youkai emits is a magical darkness that renders even torchlight useless, and humans that wander into this darkness have their field of vision reduced to almost nothing.",

"Gensokyo Chronicle - Rumia","It is simple enough to drag people into the darkness and attack them, but she does not move with a group of other youkai, which is a relief.\nHer appearance is that of a young girl with red eyes and a red ribbon in her blond hair. It is said that she wears dark clothes to blend in with the darkness, but since it is always dark around her this is difficult to confirm.",

"Gensokyo Chronicle - Rumia","Perhaps because she is known as a monster of darkness and is normally feared, people who have directly seen her form and discover her young appearance and are overcome with relief. t is possible that she covers herself in darkness to hide her appearance.",

"Gensokyo Chronicle - Rumia","Also, it is said that her ability to manipulate darkness is only a supporting ability, and that she uses pure power to attack humans. Since she looks like what she looks like you cannot tell if she is really strong or not, but it isn't possible to fight against her in the darkness. Not being able to see a way out is frightening..."
]

GensokyoChronicle_Nue = [
"Gensokyo Chronicle - Nue","<ac>True Form of the Unidentified</ac>\n<ac>Nue Houjuu</ac>\nAblity: The ability to make objects unidentifiable\nThreat level: High\nHuman friendship level: Low\nMain place of activity: Myouren Temple, etc.",

"Gensokyo Chronicle - Nue","A nue, a youkai without a true identifiable form. In the Tale of the Heike, a youkai feared by the Emperor was hunted down, turning out to be a chimera having the head of a monkey, the body of a tanuki, the limbs of a tiger, and the tail of a snake. This description became the image of the nue afterwards, but in actually it was not written that this youkai was a nue.",

"Gensokyo Chronicle - Nue","The truth is that the youkai nue and that monster were completely different beings. A nue is actually a youkai who's real form cannot be established. However, it is said that the sound of its cry is still well-known to people. The saying goes that the nights when a nue's cries can be heard are ill-fated.",

"Gensokyo Chronicle - Nue","Her visible form has inexplicable tentacles that might be wings or tails of some kind. Each of these appendages can be moved freely, which disorients those who see them. Apparently, she had been in the underground world for a while, but it seems that she has moved to the surface with the recent commotion about the geyser. She is supposedly training under Byakuren Hijiri at Myouren Temple for the time being.",

"Gensokyo Chronicle - Nue","While she herself is a youkai with an indeterminate form, it has been discovered that she can also conceal the true nature of other objects. To conceal the true nature means to rob form, sound and smell from objects and living beings, leaving mainly its behavior. For instance, robbing the identity of a bird while it is in flight will leave it as an \"unidentified flying object\". ",

"Gensokyo Chronicle - Nue","The mysterious entity that has lost its identity will be perceived as different forms depending on the observer. It is said the form will settle into something that their mind can accept by completing its figure arbitrarily. Even in the case of the bird turned into a UFO by having its form stolen, it is usually seen as a mere bird after all. In this case though, what people will see would likely be a mirage-like, mutable bird..."
]

GensokyoChronicle_Medicine = [
"Gensokyo Chronicle - Medicine","<ac>Little Sweet Poison</ac>\n<ac>Medicine Melancholy</ac>\nAbility: Manipulation of Poison\nThreat level: High\nHuman friendship level: Poor\nMain place of activity: Nameless Hill",

"Gensokyo Chronicle - Medicine","Even though youkai have long lifespans, naturally, new ones come into being as well. Medicine Melancholy is one of these newborn youkai. She was a discarded doll that over time changed into a youkai. Her form is that of a large doll used in ventriloquism. It is believed that the original doll from which she came was roughly that size. Even after becoming a youkai, her body is still that of a doll.",

"Gensokyo Chronicle - Medicine","It is believed that the ability to manipulate poison was naturally attained by being left on Nameless Hill, where numerous lilies-of-the-valley bloom, for a long time. She puts poison in food. She uses poison to manipulate humans. She's a threat to humans that are easily affected by poison. Being a young youkai, her experience and knowledge is overwhelmingly shallow.",

"Gensokyo Chronicle - Medicine","She possesses even less knowledge than humans. Because of this, whether she's dealing with a human or youkai, she doesn't know the meaning of holding back. She also can't judge how strong her opponent is. Therefore, she is fearsome...",

"Gensokyo Chronicle - Medicine","...She hates humans, but if you skillfully manage your words, you can deceive her easily. You could pretend to be a human that hates humans. The strength of her poison is fearsome, and can leave aftereffects. Poisons that remain latent for a long time and cause delayed effects are also dangerous.\nYou must avoid fighting her at all costs."
]

GensokyoChronicle_Yuuka = [
"Gensokyo Chronicle - Yuuka","<ac>Flower Master of the Four Seasons</ac>\n<ac>Yuuka Kazami</ac>\nAbility:Manipulation of flowers\nThreat level: Very high\nHuman friendship level: Worst\nMain place of activity: Garden of the Sun",

"Gensokyo Chronicle - Yuuka","She lives surrounded by flowers all year round, and if anyone disturbs her, be they youkai or human, she eliminates them with tremendous power no matter what. She's more like a manifestation of nature rather than a flower youkai, but unlike fairies, she is far more dangerous than any of the youkai introduced so far. She is usually active in places surrounded by flowers, and seems peaceful at first glance but is merciless towards other creatures.",

"Gensokyo Chronicle - Yuuka","She wears bright clothes, and her appearance is no different from a human. The ability to manipulate flowers is something to the extent of being able to make flowers bloom, shift sunflowers to face towards the sun, or restore withered flowers. This ability is more of an extra; she possesses extremely high magical power and physical abilities. A youkai-like youkai.",

"Gensokyo Chronicle - Yuuka","She doesn't feel an atom of fear when fighting humans or youkai, and loves rubbing people the wrong way. As youkai live longer, they become less active. There are few that take the initiative to attack humans. It is said that this youkai hasn't moved far from the flowers very often lately...",

"Gensokyo Chronicle - Yuuka","...There are no countermeasures; it's impossible for ordinary humans to exterminate her. They can only be vigilant. Luckily, she isn't interested in boring battles, so as long as you don't attack, set up a trap, or set her field of flowers on fire, you should be fine. If you come across this youkai battling with someone else, do not get involved.",

"Gensokyo Chronicle - Yuuka","However, these fights are based on certain rules, so as long as you do not disturb the fight, she'll be polite. If you can keep your distance, it's also a good idea to watch. Battles between non-humans are full of breathtaking beauty. "
]

GensokyoChronicle_Yamame = [
"Gensokyo Chronicle - Yamame","<ac>The Bright Net in the Dark Cave</ac>\n<ac>Yamame Kurodani</ac>\nAbility: The ability to manipulate illness (mainly infectious disease)\nThreat level: High\nHuman friendship level: Very Low\nMain place of activity: Inside the Dark Blowhole",

"Gensokyo Chronicle - Yamame","A youkai who lurks in dark caves. She's an earth spider who lies in wait for people venturing into the cave. If you encounter this youkai, it is almost certain that you will suffer from a high fever of unknown cause, lose your appetite, and even waste away and die if left untreated. Also, it's possible to contract it by coming in contact with people carrying this disease.",

"Gensokyo Chronicle - Yamame","The blowhole at the foot of Youkai Mountain leads to her dwelling, so you absolutely mustn't enter. Such a careless action could pose trouble for the entire village. Since she knows that she's hated, it looks like she rarely ever shows up in the village. She may be a youkai, but if the entire human population attacked her, she wouldn't be able to put up a fight. That said, that doesn't mean she cares about not causing problems for humans.",

"Gensokyo Chronicle - Yamame","The nature of her personality is uncertain, but according to humans who returned safely, she's a youkai who can be reasoned with.",

"Gensokyo Chronicle - Yamame","Earth spiders specialize in construction, and are said to secretly come above ground at times. They take requests, chiefly from the Oni, kappa and tengu, then emerge topside and construct a building in one night. These unsung heroes may very well be the reason why youkai buildings are completed so much faster than human ones.",

"Gensokyo Chronicle - Yamame","After examining some patients, it was found that all of them share the symptom of a high fever. However, this is the only information available on the disease, which remains unidentified. It may be wise to consult the doctor living at Eientei, as she is apparently developing a wonder drug. However, since the symptoms of the disease change slightly every year, it cannot be treated with ordinary methods.",

"Gensokyo Chronicle - Yamame","Never enter the blowhole. Also, she sometimes appears above ground during the night, so don't let your guard down then. If you contract a high fever of unknown cause, quarantine yourself and call a doctor. Even if you can't afford to pay the bill, it has been agreed that they will proactively (at a low price) offer to cure these types of infectious diseases.",

"Gensokyo Chronicle - Yamame","In the case that the diagnosis for an epidemic disease turns up negative, pay the doctor's fee."
]

GensokyoChronicle_Yukari = [
"Gensokyo Chronicle - Yukari","<ac>Youkai of Boundaries</ac>\n<ac>Yukari Yakumo</ac>\nAbility: Manipulation of boundaries\nThreat level: Unknown\nHuman friendship level: Normal\nMain place of activity: Anywhere and everywhere",

"Gensokyo Chronicle - Yukari","When talking about youkai-like youkai, the first name that comes to mind is probably Yukari Yakumo. To start with, she is a youkai that you do not want to deal with. Even besides the fundamental issue of the danger of her ability, this youkai will appear anywhere unexpectedly, her character is lacking in human compassion, and her behavioral principles are completely different from those of humans, to name a few of her issues.",

"Gensokyo Chronicle - Yukari","Her appearance is not especially different from that of a human. She prefers gaudy clothes, and is often seen with a large parasol. Her main time of activity being at night, she sleeps in the daytime. All in all, she is a typical youkai. Though she claims to hibernate through the winter, we have only her word on it and it's unknown where she lives, so this is unconfirmed.",

"Gensokyo Chronicle - Yukari","There is an article in the Youkai Encyclopedia from Aichi's Gensokyo Chronicle from long ago that seems to describe her. It appears she existed back then as well. ",

"Gensokyo Chronicle - Yukari","The ability to manipulate boundaries is a terrifying ability capable of fundamentally undermining reality. It goes without saying, but everything is built upon the existence of boundaries. If there was no water surface, there could be no lake. If there was no sky line, neither mountain nor sky could exist. Were it not for the Great Barrier, even Gensokyo itself wouldn't exist.",

"Gensokyo Chronicle - Yukari","If there were no boundaries, everything would probably exist as a single enormous object. Thus, the ability to manipulate boundaries is logically an ability of creation and destruction. It logically creates a new existence, or conversely negates some existence. Among the abilities youkai are known to possess, this is one of the most dangerous, comparable even to the power of gods. ",

"Gensokyo Chronicle - Yukari","She is also capable of moving to an entirely separate location between gaps in space, whether it be her entire body or only a part of her. It's said that this ability is not limited to physical space, but also applies to the inside of pictures, others' dreams, and even stories. In addition, she possesses superhuman intellect, especially concerning mathematics. Furthermore, due to her long lifespan, she has a wealth of knowledge and experience...",

"Gensokyo Chronicle - Yukari","...This is a story from over xxxx years ago. It is said that she once invaded the moon by modifying the boundary between truth and falsehood and plunging into the moon's reflection on the lake's surface. Although she went in with an army of impudent youkai, they were crushed by the Moon's advanced weaponry. It is believed because of that incident, youkai usually do not choose to invade beyond the bounds of their territory."
]

GensokyoChronicle_Koishi = [
"Gensokyo Chronicle - Koishi","<ac>The Closed Eyes of Love</ac>\n<ac>Koishi Komeiji</ac>\nAbility: The ability to manipulate the unconscious\nThreat level: Unknown\nHuman friendship level: None\nMain place of activity: Unknown",

"Gensokyo Chronicle - Koishi","A satori like her older sister Satori. However, she is a satori who had closed off her own mind, making herself unable to read other's. Since she cannot read minds, there is no longer any reason for others to hate her, but since her own mind is completely empty, she can no longer be liked by anyone either. Her presence cannot be felt by anyone unless she has entered their direct field of vision.",

"Gensokyo Chronicle - Koishi","And even if one can see her with their eyes, she will still be thought of as non-existent. When she leaves one's sight, she is immediately forgotten. Actually, it seems as if she has been coming above ground for some time, but no one took notice even when they saw her. Now that Satori's existence has been revealed, Koishi finally started to be recognized as well. Unlike her older sister, she is not even liked by animals, nor is she hated.",

"Gensokyo Chronicle - Koishi","Despite Koishi's nature, her older sister does worry about her. Even her older sister can't see her because of her lack of a mind, but nonetheless her sister hasn't forgotten her. As her personality is blank, it's just as difficult to communicate with her as it is with her sister.",

"Gensokyo Chronicle - Koishi","Her threat level is unknown. Even if you catch sight of her, she will not do anything, so it is probably not necessary to take any countermeasures. However, do not do anything to provoke her. If by some slim chance she were to recover her powers as a satori, nobody would benefit."
]

GensokyoChronicle_Nazrin = [
"Gensokyo Chronicle - Nazrin","<ac>The Little Dowser General</ac>\n<ac>Nazrin</ac>\nAbility: The ability to find sought-for items\nThreat level: Medium\nHuman friendship level: Low\nMain place of activity: The whole of Gensokyo",

"Gensokyo Chronicle - Nazrin","She is known as Shou Toramaru's mouse familiar, but is in fact a high-ranking youkai dispatched by Bishamonten himself. Her job is to support and monitor Shou. Nazrin's specialty is dowsing, a type of divination used to locate groundwater. However, she mainly utilizes this ability to locate treasure.",

"Gensokyo Chronicle - Nazrin","There are various ways to dowse. Some use dowsing rods, or a dowsing pendulum. She uses wild mice for the task. Because they live everywhere underground and in small, tight places, she can pinpoint what she's looking for by listening to what they say. They are not useful for finding everything, though. They aren't good at finding overly large objects, food, or living creatures. It is also difficult to use them to search for objects they cannot recognize or understand.",

"Gensokyo Chronicle - Nazrin","In stark contrast to her tiny figure, she has a large ego. This is because she is backed by Bishamonten. However, she herself is actually quite timid. She will run away as soon as she becomes frightened."
]

GensokyoChronicle_Reimu = [
"Gensokyo Chronicle - Reimu","<ac>Shrine Maiden of Paradise</ac>\n<ac>Reimu Hakurei</ac>\nOccupation: Shrine Maiden\nAbility: Flying in the air\nResidence: Hakurei Shrine",

"Gensokyo Chronicle - Reimu","The current shrine maiden at the Hakurei Shrine, which lies on the border of Gensokyo. The Hakurei Shrine exists to watch over the Great Barrier necessary to the present Gensokyo, and the Hakurei shrine maidens resolve incidents for a living, generation after generation. Out of the generations of shrine maidens, her sense of danger is the most lacking and she has meager training, yet her power is considerable.",

"Gensokyo Chronicle - Reimu","She's exterminated multitudes of youkai with her keen intuition and her natural good luck. ",

"Gensokyo Chronicle - Reimu","She's unusually easygoing and lacks any sense of danger. She treats everyone in the same uninterested manner, neither kindly nor harshly. Perhaps as a result of that, strong personalities tend to like her, while weak youkai fear her. However, her opinion regarding youkai is that exterminating them on sight is her job.",

"Gensokyo Chronicle - Reimu","She has the power to defy gravity and fly freely through the sky. Nothing can tie her down. In addition, she has abilities as the Hakurei shrine maiden. The Hakurei shrine maidens manage the Great Hakurei Barrier and watch over Gensokyo. If the Great Barrier were destroyed, either from inside or out, Gensokyo would likely not fare well. Gensokyo relies on the Hakurei Shrine and its shrine maidens to preserve the form it exists as today.",

"Gensokyo Chronicle - Reimu","As a result, no youkai oppose them. Due to her easygoing appearance, it's impossible to tell whether she realizes this or not, but the Hakurei shrine maidens really do have all of Gensokyo under their thumbs.",

"Gensokyo Chronicle - Reimu","When an incident is not occurring, she is a very ordinary human. She lazes about the rarely-visited shrine, pretends to clean it, and drinks tea. She's often seen going out to shop in the human village. If she catches sight of a youkai on the way, she will surely teach them a lesson. In this way, she's different from a usual human.",

"Gensokyo Chronicle - Reimu","She is a specialist in incident resolution. When an incident occurs, her usual carefree attitude vanishes, and she immediately investigates to resolve whatever matter is at hand. Although the Hakurei shrine maiden was initially the only one who resolved incidents, these days, there are many imitators who go out to resolve incidents as well."
]

GensokyoChronicle_Marisa = [
"Gensokyo Chronicle - Marisa","<ac>Ordinary Magician</ac>\n<ac>Marisa Kirisame</ac>\nOccupation: Magician\nAbility: Use of magic\nResidence: Forest of Magic",

"Gensokyo Chronicle - Marisa","A very unusual magician who lives in the Forest of Magic. More specifically, magician is her occupation, but she is human. She's clad in mostly black clothes, wears an enormous black hat and can often be seen visiting the shrine. She usually doesn't appear much in the human village. She is the only daughter of the proprietor of the successful Kirisame General Store in the village, but it appears she's cut off all relations with them.",

"Gensokyo Chronicle - Marisa","The forest isn't her only home; she also runs a general store, the \"Kirisame Magic Shop\". However, due to the difficulty of finding the store in the forest, and the fact that nobody has any idea what she really deals with in the first place, she has rarely been seen actually working. Her personality is condescending as if trying to make fools of others, so it would be hard to exactly call her considerate, but she has a sophisticated side",

"Gensokyo Chronicle - Marisa","to her, and being with her tends to be interesting.",

"Gensokyo Chronicle - Marisa","She has the ability to use magic. She specializes primarily in heat and light magic. She likes to say, \"It ain't magic if it ain't flashy. Danmaku's all about firepower.\" The magic she uses does appear flashy, but their source is relatively simple. First, she has to hunt for monster mushrooms to use as the fuel, which only grow in the wild.",

"Gensokyo Chronicle - Marisa"," Next, she has a peculiar way of preparing them that involves boiling them for several days into a concentrated soup. She'll create blends of many kinds of soups and dry them into a solid mass over the course of a few more days. At that point they're ready for magical experimentation. She will run all sorts of experiments, including throwing the masses, heating them or submerging them in mountain stream water. ",

"Gensokyo Chronicle - Marisa","Very rarely, she'll discover a truly magical reaction in the course of these experiments. She'll record both failures and successes in her records, and then begin gathering mushrooms once again. Her magic is extremely flashy, and indeed quite beautiful, but it's backed up by a considerable amount of her own effort, which she goes to great lengths never to show others. ",

"Gensokyo Chronicle - Marisa","In other words, it's not unlike a gigantic fireworks show. Still, it's quite unusual for a human to be able to use magic to this extent. She says this is also due to the effects of the Forest of Magic.",
]

GensokyoChronicle_Eirin = [
"Gensokyo Chronicle - Eirin","<ac>Hourai Pharmacist</ac>\n<ac>Eirin Yagokoro</ac>\nOccupation: Medicine Master\nAbility: Creating any kind of medicine\nResidence: Eientei",

"Gensokyo Chronicle - Eirin","She is a master pharmacist that prepares medicine at Eientei, and distributes it to both human and youkai. She has only recently started this business. Her medicines are divided into consigned and direct sale varieties. Consignment operates by distributing medicine boxes to each household, and at the turn of the season the usage is checked. Only the price of the consumed medicine is then charged.",

"Gensokyo Chronicle - Eirin","Those are medicines to heal light injuries, colds, etc. Direct sale medicines are purchased in-person at Eientei. There are ones such as short-lasting medicines, medicines for serious illnesses and medicines for special cases. Her medicines have a reputation of working efficiently and without side-effects. However, there is but a single warning. Medicines for youkai and for humans are very different.",

"Gensokyo Chronicle - Eirin","Medicines for youkai are too strong for humans and they will suffer from side-effects. On the other hand, medicines for humans are poisonous to youkai. Also, if you go to Eientei, she can examine you just as a doctor would. It's said that she can provide medicine even for unidentifiable diseases."
]

GensokyoChronicle_Sanae = [
"Gensokyo Chronicle - Sanae","<ac>Deified Human of the Wind</ac>\n<ac>Sanae Kochiya</ac>\nAbility: The ability to cause miracles\nThreat level: Low\nHuman friendship level: High\nMain place of activity: Moriya Shrine, etc.",

"Gensokyo Chronicle - Sanae","A human being who came from the outside world, and is one of the incredibly few that have become accustomed to life in Gensokyo. Although called a human being, she is actually a god as well. One that attains godhood while remaining a human is called a \"living god\" (Arahitogami). So, including Kanako Yasaka and Suwako Moriya, there are a total of three gods residing at the Moriya Shrine.",

"Gensokyo Chronicle - Sanae","Those to be called divine spirits grow their power through gathering faith, but there are no humans that hold faith in her as far as I know. As such, it is thought that her power as a god is faint. Her role at the Moriya Shrine seems to be gathering faith in the human village through advertisement. People wouldn't be terribly wary towards a fellow human, and she would gain considerable popularity if she did miracles in public. ",

"Gensokyo Chronicle - Sanae","Her personality is a lot like an ordinary human, but sometimes she can seem slightly peculiar as well. Maybe it's because she's a human being from the outer world. She is dumb, and her senses are a little different from that of the humans in Gensokyo.",

"Gensokyo Chronicle - Sanae","The ability to create miracles is often confused with fortune. Miracles are ultimately the culmination of chance, and the result is not limited to being wholly positive or negative. It has no relation to good luck or bad luck. Recently there have been miracles such as frogs and tadpoles falling from the sky, but that is also not particularly good fortune. ",

"Gensokyo Chronicle - Sanae","It is said that in order to cause a miracle she needs a long preparation time (for spell casting). The length of preparation differs depending on the magnitude of the miracle. She can cause a simple one with a single word, but to cause a cataclysmic-level miracle she requires several days of continuous casting. That does not seem to be a practical length of time to humans."
]

GensokyoChronicle_Byakuren = [
"Gensokyo Chronicle - Byakuren","<ac>Demonic Chief Priest of the Youkai Temple</ac>\n<ac>Byakuren Hijiri</ac>\nAbility: The ability to use magic (specializing in magic that increases her physical abilities)\nThreat level: Unknown\nHuman friendship level: Medium\nMain place of activity: Myouren Temple, etc.",

"Gensokyo Chronicle - Byakuren","The chief priest of the Myouren Temple. Although she was originally a human, she has already surpassed humanity due to many years of training. Therefore, she is categorized as a magician. Although she has entered the priesthood, for some reason she is beloved by youkai. She does not banish demons with holy incantations like in fairy tales. Although she acts like a saint, the powers she wields are evil.",

"Gensokyo Chronicle - Byakuren","Though never seen as hostile towards humans, ultimately, she's an ally of the youkai. Before she came to Gensokyo, she was sealed in Makai by the hand of humans. The reason may have been related to mankind's fear of other humans with different powers. The seal was also undone by youkai who dearly missed her. With an experience like hers, it's natural to think that she has a hatred for humans.",

"Gensokyo Chronicle - Byakuren","Her daily life seems quite forthright, but because she won't drink alcohol, dislikes killing (she doesn't eat meat) and her other religious precepts, it's difficult for her to befriend humans. As for her work, she manages funerals and the graveyard, teaches the dharma not only to her disciples but anyone willing to listen, and leads an early-to-bed, early-to-rise lifestyle.",

"Gensokyo Chronicle - Byakuren","Part of this lifestyle also includes the \"Overnight sutra-chanting live concert\", where she sings a monotone song while keeping the rhythm with a wooden fish. She holds it once a month, and it attracts attention from both humans and youkai alike. While her placid demeanor can make her come off as unreliable, it's also the reason why she has many followers among the ranks of youkai who choose to avoid conflict.",

"Gensokyo Chronicle - Byakuren","She has never been seen enraged and gives the impression of a good-natured old grandmother. But since many youkai tend to be aggressive, this attitude makes her repulsive instead.",

"Gensokyo Chronicle - Byakuren","It's hard to definitively say whether or not she has any hostility towards humans. However, because she has declared that she follows the religious precept of not killing, it's unlikely that she'll suddenly attack you. Rather than that, you should be worried about her youkai followers. Of the youkai that visit the temple, there are a number that clearly violate the teachings.",

"Gensokyo Chronicle - Byakuren","Apparently, there are youkai that are aiming to obtain power like hers, as well as those that target the humans visiting the graveyard."
]

GensokyoChronicle_Keine = [
"Gensokyo Chronicle - Keine","<ac>History-Eating Half-Beast</ac>\n<ac>Keine Kamishirasawa</ac>\nAbility: Power to consume history (human form) / Power to create history (beast form)\nThreat level: Low\nHuman friendship level: High\nMain place of activity: Human Village",

"Gensokyo Chronicle - Keine","Rich in knowledge, the wisest of the therianthrope is Keine Kamishirasawa. Upon seeing the full moon, she will transform into a hakutaku. A hakutaku is a youkai which appears to virtuous rulers at the beginning of their reign, warning them of future calamities and guiding them on the path of righteousness. She can erase history when human, and when she becomes a hakutaku, she can create history.",

"Gensokyo Chronicle - Keine","Gensokyo's history is one created by her. Regarding history, things do not become history merely by happening. Things do not become history unless someone records it as history. She can fabricate history that didn't happen, or conversely, erase from history incidents which actually did happen. History is reality, seen from a single point of view.",

"Gensokyo Chronicle - Keine","It would not be too much to say the power of the hakutaku is used to create favorable histories for those virtuous rulers. She lives in the human village, where she runs a temple school and records history there every day. Such is her profession. ",

"Gensokyo Chronicle - Keine","Although she's a little stubborn, since she has no ill will towards humans, there's no need to be afraid. However, if you forget your homework, a fearful punishment is waiting. She is often seen, since she normally lives in the human village. At that time, you should greet her. It seems that she dislikes people who are discourteous. ",

"Gensokyo Chronicle - Keine","Also, she becomes a hakutaku on the night of the full moon. As she has a month of work on which to catch up at this time, she is often on edge. Therefore, refrain from visiting her on the night of the full moon.",
]

GensokyoChronicle_Kanako = [
"Gensokyo Chronicle - Kanako","<ac>The Avatar of Mountains and Lakes</ac>\n<ac>Kanako Yasaka</ac>\nAbility: The ability to create heavenliness\nThreat level: Low\nHuman friendship level: High\n Main place of activity: Youkai Mountain, Human Village, Geyser Center, etc",

"Gensokyo Chronicle - Kanako","A god who came from the outside world along with her shrine. Unlike most gods who freely come and go between Gensokyo and the outside world, she is now based entirely in Gensokyo and focuses on gathering strong faith solely from its humans and youkai. She corresponds with the class of divine spirits. Because of this, it is believed she used to be some form of human long ago, but their identity, or even whether they were an ",

"Gensokyo Chronicle - Kanako","individual or a group, is no longer determinable. In the past it seems she was a storm god, but currently she is called a mountain god. Publicly, she has a mutually beneficial relationship with the youkai that have been ruling the mountain so far, but the reality of the situation is unknown. It appears that they are only using each other, so it is necessary to carefully observe them.",

"Gensokyo Chronicle - Kanako","Unlike the Hakurei Shrine, the Moriya Shrine is much more active in its operations. It seems she's fine with anything as long as it wins her faith, and she'll propose all sorts of suspiciously attractive offers. She especially likes technological innovation, and has a tendency to look down on tradition. Her abandoning the outside world for Gensokyo is surely another indication of her personality. And what is a mountain god anyway?",

"Gensokyo Chronicle - Kanako","She has a showy appearance. It seems this is to intimidate those she meets. Incidentally, while divine spirits normally have no form, cases of famous spirits taking on a fixed appearance are common. This is necessary for them to obtain faith, as many humans will not approach things they cannot see or feel uncomfortable with.",

"Gensokyo Chronicle - Kanako","Her personality is oppressive and self-righteous. However, those same qualities can be seen as reliable, which has allowed her to gather faith. However, people with such a personality are often swindlers as well, so please exercise caution.",

"Gensokyo Chronicle - Kanako","There are many mysteries concerning her ability. She has done things like changing the terrain in cooperation with Suwako Moriya, as well as opening holes to the underground. She is also skilled at making roads and erecting large structures. However, for some reason this power is not used in her shrine's blessings.",

"Gensokyo Chronicle - Kanako","Incidentally, she helped to build the Myouren Temple. The details of what triggered this are unknown, but the fact that she completed it in one night was quite memorable.",

"Gensokyo Chronicle - Kanako","Because she has no hostility towards humans, it is believed there is little reason to fear her. While you don't necessarily have to have faith in her, being disrespectful can cause you to be cursed. All gods have two sides to them: faith in one grants blessings while their anger provokes curses. Unfortunately, she seems a bit short-tempered. Be careful not to ruin her mood.",

"Gensokyo Chronicle - Kanako","She is susceptible to gifts, so if you somehow disrespect her it's best to prepare an offering. "
]

GensokyoChronicle_Minoriko = [
"Gensokyo Chronicle - Minoriko","<ac>Symbol of Abundance and Harvest</ac>\n<ac>Minoriko Aki</ac>\nAbility: The ability to create plentiful harvests\nThreat level: Medium\nHuman friendship level: Very High\nMain place of activity: Human Village, fields, etc",

"Gensokyo Chronicle - Minoriko","She is a goddess of Gensokyo's autumn, particularly controlling the harvests of grains, fruits, and so forth. Harvest gods like her are closely intertwined with human life, but because there are so many others, she is unable to acquire strong faith from humans. Her power only affects plants that ripen in the autumn. On top of that, she works hard to cultivate each plant one by one, so there is a limit to how many crops she can accommodate.",

"Gensokyo Chronicle - Minoriko","Despite this, she's still liked by humans, and they express their gratitude by inviting her to harvest festivals. She has an older sister who is a goddess of autumn leaves. Minoriko always gazes at the fall foliage while digging up potatoes or gardening, and envies her sister's aesthetic sense.",

"Gensokyo Chronicle - Minoriko","Her personality is simple-hearted and cheerful. Although she is a goddess, she doesn't give off a very dignified air, so she isn't worshiped enough to have shrines built to her. Nearly all of her faith comes from individual people, but she seems pleased to have a small workload. ",

"Gensokyo Chronicle - Minoriko","She is nearly harmless. However, she can destroy crops at will. If you treat her with contempt or attempt to eliminate her, you may live to regret it. In addition, she prefers natural farming methods, so she avoids excess weeding and soil preparation. Farmers who oppose her preferences seem to be viewed as her enemies."
]

GensokyoChronicle_Eiki = [
"Gensokyo Chronicle - Eiki Shiki","<ac>Supreme Judge of Hell</ac>\n<ac>Eiki Shiki, Yamaxanadu</ac>\nAbility: Distinctly judging things as right or wrong\nThreat level: Very low\nHuman friendship level: Normal\nMain place of activity: Higan",

"Gensokyo Chronicle - Eiki Shiki","One of the many yama. As she is in charge of judging the dead of Gensokyo, she is the yama with the closest ties to us. Since she is very preachy and is never mistaken about anything, she appears a little hard to approach. However, her teachings are fundamentally for the benefit of the humans of Gensokyo, so you should listen earnestly to what she has to say.",

"Gensokyo Chronicle - Eiki Shiki","This Yama is famous in Gensokyo, particularly among long-lived youkai, who have been helped by her at least once. Nevertheless, youkai feel uncomfortable around the Yama, so whenever she comes to Gensokyo, all youkai go into hiding. In this sense, the Yama is an ally of honest humans. ",

"Gensokyo Chronicle - Eiki Shiki","Moreover, whenever a mortal's karma is so bad that it becomes certain that they will go to Hell, she will go directly to warn that person during her work break, and may even urge the person to better themselves."
]

GensokyoChronicle_HumanVillage = [
"Gensokyo Chronicle - Village","<ac>Human Village</ac>\nThreat level: Low\nEncounterable youkai: Were-beasts, fairies, phantoms, etc.\n\nThe place where most of the humans in Gensokyo live. Although various youkai visit the village for the many shops that cater towards them, they are rarely violent, so it is a relatively relaxed place.",

"Gensokyo Chronicle - Village","Everything necessary for human life is supplied here. Moreover, as there are also humans who work as youkai exterminators, it is possible to lead a safe life here. As for why there are no attacks on the human village, the truth is that it is under the protection of the youkai sages. As long as the humans don't leave the village, they won't meet any harm.",

"Gensokyo Chronicle - Village","Even if you were to meet a youkai in the village, you should greet them respectfully as if they were your elder. Moreover, while many shops are kept open surprisingly late at night, that is often when they are for the exclusive use of youkai. Since many youkai are active at night, such stores are quite prosperous. It is said that youkai are good customers.",

"Gensokyo Chronicle - Village","It is also a common occurrence for humans and youkai to enjoy meals together, particularly in places that serve alcohol. "
]

GensokyoChronicle_HakureiShrine = [
"Gensokyo Chronicle - Hakurei Shrine","<ac>Hakurei Shrine</ac>\nThreat Level: Low\nEncounterable youkai: None... supposedly\n\nOn the eastern edge of Gensokyo lies its only shrine. This shrine exists on the border between the outside world and Gensokyo.",

"Gensokyo Chronicle - Hakurei Shrine","All of Gensokyo can be seen from this shrine, and it is famous for having the most beautiful cherry blossom trees. The Hakurei shrine maiden, who specializes in incident resolution, lives here. She watches over Gensokyo from here, and when an incident arises, she will go out immediately and ascertain the cause. It's said that she resolved the recent Scarlet Mist incident.",

"Gensokyo Chronicle - Hakurei Shrine","Although youkai aren't supposed to come near the shrine, recently it's been rumored to have become a den of youkai, and so humans have stopped approaching. Just as in the village, one is ensured safety from attacks by youkai while at the shrine; however, as the path between the shrine and the village is an animal trail with poor visibility, safety cannot be guaranteed. This has always prevented people from visiting the shrine to worship.",

"Gensokyo Chronicle - Hakurei Shrine","Another idiosyncrasy of the shrine is that items and people who have wandered in from the outside world are often discovered nearby. Humans from the outside world will quickly become food if discovered by a youkai, but if they're lucky enough to find the shrine, they can return to their own world. ",

"Gensokyo Chronicle - Hakurei Shrine","Many of the items from the outside world are mysterious, and are popular among humans and youkai alike. For this reason, many collectors like to gather around the shrine. However, it is said that the purpose of most of the discovered objects is unknown."
]

GensokyoChronicle_ForestOfMagic = [
"Gensokyo Chronicle - Forest of Magic","<ac>Forest of Magic</ac>\nThreat level: Medium\nEncounterable youkai: Beasts, magicians etc. \n\nThe most humid place in Gensokyo, this primeval forest that humans rarely step foot into is the Forest of Magic.",

"Gensokyo Chronicle - Forest of Magic","The path from the human village is relatively easy, but the forest's environment is extremely ill-suited to human life. With the spores of monster mushrooms dancing about in midair, even breathing here would be hazardous to the health of a normal human. However, another unique feature of the forest is that even typical youkai find the place discomforting and many refrain from entering. ",

"Gensokyo Chronicle - Forest of Magic","For that reason, if one could stand the noxious miasma that the monstrous mushrooms emit, then on the contrary, it would be both a safe and secretive place to seclude oneself. Almost no sunlight reaches the ground of the forest, making it dark and damp. Therefore, mushrooms grow endlessly there. There are mushrooms here that can be used for food for humans who can withstand them, but they don't look very appealing. ",

"Gensokyo Chronicle - Forest of Magic","Also, there are a relatively high number of mushrooms with hallucinogenic properties. The reason why it is called the Forest of Magic in the first place is because of the wide number of hallucinogenic mushrooms growing there. Simply being near them will make hallucinations appear as if one was entranced by magic. ",

"Gensokyo Chronicle - Forest of Magic","In addition, for the sake of increasing their magical powers with these hallucinogenic mushrooms, many magicians live in this forest."
]

GensokyoChronicle_SDMansion = [
"Gensokyo Chronicle - S.D.Mansion","<ac>Scarlet Devil Mansion</ac>\nThreat level: High\nEncounterable youkai: Vampires, magicians, etc.\n\nA red, European-style mansion with few windows built on a bank of Misty Lake. It is the house where a well-known devil lives. ",

"Gensokyo Chronicle - S.D.Mansion","Since the mansion was moved from the outer world, it clashes badly with the surrounding scenery. The residents of the mansion also have a culture different from that of most humans and youkai, and live bustling, flamboyant lives. A large quantity of maids live and work in the mansion, and although they handle the cleaning, cooking, washing and patrolling, it is said not many of the maids are actually useful.",

"Gensokyo Chronicle - S.D.Mansion","The Scarlet Devil Mansion also has a basement, which is both complex and larger than it appears from the outside. There are also many rooms without windows inside, which complicate it further. In the basement is the great library which is said to be the largest in Gensokyo. But, it is not open to the public, so no one is sure what kind of books are there. On the roof is a large clock tower with a bell, which only rings at night.",

"Gensokyo Chronicle - S.D.Mansion","Because the mansion is only active at night."
]

GensokyoChronicle_Hakugyokurou = [
"Gensokyo Chronicle - Hakugyokurou","<ac>Hakugyokurou</ac>\nThreat level: High\nEncounterable youkai: Phantoms, ghosts, etc. \n\nIn the Netherworld is a manor with a vast garden, called Hakugyokurou. It is the home of the Saigyouji family, and in its garden are planted countless cherry trees. ",

"Gensokyo Chronicle - Hakugyokurou","The garden, which is typically open to the public, is often full of phantoms come to admire its graceful beauty. In the Netherworld, the Saigyoujis are a special family, a distinguished household allowed permanent residence among the Netherworld's cherry trees. Out of Hakugyokurou, the family manages the phantoms of the Netherworld. ",

"Gensokyo Chronicle - Hakugyokurou","As the building itself is typically not open to the public, little is known about it, but the inner sanctuary is said to form the shape of a letter \"U\" to enclose a zen garden courtyard. ",

"Gensokyo Chronicle - Hakugyokurou","From the reception hall, a sliding door opens out onto a courtyard spread with fine gravel and planted with magnificent pines, and further on beyond a short wall, a vast orchard of cherry trees is visible. From the hall, with the floor, walls and ceiling cut out, the view looks like a great folding screen.",

"Gensokyo Chronicle - Hakugyokurou","The view outside from here in the spring is said to be out of this world."
]

GensokyoChronicle_Eientei = [
"Gensokyo Chronicle - Eientei","<ac>Eientei</ac>\nThreat level: High\nEncounterable youkai: Beasts, etc.\n\nHidden deep within the Bamboo Forest of the Lost is built a mysterious mansion. Though its architecture is like that of an ancient Japanese mansion, it somehow shows not the slightest sign of decay. ",

"Gensokyo Chronicle - Eientei","Either it has seen constant maintenance or else time itself has stopped for it. Being in the Bamboo Forest of the Lost, it is not easily found by prospective visitors. Only recently have there been people willing to guide others to the manor. Before then, nobody knew of anything like a mansion in the middle of the forest. The mansion is thus shrouded in much mystery. ",

"Gensokyo Chronicle - Eientei","There is very little publicly-known information about the place. Even basic things like when it was built and the inhabitants themselves are unknown. In particular, the humans and youkai rabbits who live there seem to have no relations with the human village. However, recently, by holding events such as the Lunar Capital Exhibition, it seems this manor may be opening up little by little. "
]

GensokyoChronicle_LunarCapital = [
"Gensokyo Chronicle - Lunar Capital","<ac>Lunar Capital</ac>\nThreat level: Unknown\nEncounterable youkai: Unknown\n\nAlthough it is not a part of Gensokyo, I write of this place due to its close relation to Eientei. The Lunar Capital is an ancient metropolis said to exist on the far side of the moon.",

"Gensokyo Chronicle - Lunar Capital","According to the history of the Gensou-Lunar War, it was into this city that the youkai marched before being soundly defeated. It is known to have had a great society. Although it is nowadays virtually impossible to go there directly, some information about its current state of affairs may be gathered from the Lunar Capital Exhibit held at Eientei.",

"Gensokyo Chronicle - Lunar Capital","Firstly, its firearms far outclass all terrestrial weaponry. Youkai would surely stand no chance against rifles that can release massive amounts of danmaku in an instant, sidearms with rounds that cause great explosions on impact, and pistols with bullets that can be controlled mid-flight.",

"Gensokyo Chronicle - Lunar Capital","With other technologies besides - elixirs that can extend life and cure all ills, sauces that can make dumplings ten times tastier - it is clear that not only their weaponry, but the whole of their society is far more advanced than that of Gensoukyou. How long it has been since the people of the moon first settled there is unknown, but they are said to live forever. ",

"Gensokyo Chronicle - Lunar Capital","To the Lunar Capital, the Earth is a land of exile for the unclean, and it is said that the Lunarians use it as a prison for the perpetrators of grievous crimes. "
]

GensokyoChronicle_SpellCardDraft = [
"Draft of Spell Card Rules","Duels between youkai threaten to destroy the small world of Gensokyo. However, a lifestyle without duels will cause the youkai to lose their power. Accordingly, we would like to permit such duels under the following contract.",

"Draft of Spell Card Rules","One: To make it easier for youkai to cause incidents. \nTwo: To make it easier for humans to resolve incidents. \nThree: To reject a system wherein only the strongest have the right to rule. \nFour: That beauty and thoughtfulness stand above all. ",

"Draft of Spell Card Rules","* Combatants will give names and meanings to the duel for the benefit of beauty.\n* Combatants will declare the number of named duels before beginning.\n* Combatants may not deliver attacks that do not have meaning. The meaning itself becomes the attack's power.",

"Draft of Spell Card Rules","* In the case that a combatant loses a named duel, that combatant will admit defeat, even if he or she has strength remaining. No combatant may kill a human, even upon victory. \n* Combatants will write the duel's name on paper in the format of a contract. By doing so, the above-mentioned rules become absolute. ",

"Draft of Spell Card Rules","These papers will be called spell cards. Specific dueling methods will be discussed with the shrine maiden at a later date."
]

GensokyoChronicle_Colophon = [
"Gensokyo Chronicle - Colophon","<ac>Gensokyo Chronicle</ac>\nPublished in the one hundred twenty-first season.\nAuthor: Hieda no Akyuu\nPrior authors: Hieda no Aya, Hieda no Anana, Hieda no Amu, Hieda no Ago, Hieda no Ayo, Hieda no Ami, Hieda no Ani, Hieda no Aichi\nSupervisor: Hieda no Are\nAnd many other youkai\nAll rights reserved"
]

GrimoireOfMarisa_Reimu = [
"Grimoire of Marisa - Reimu","<fs=30><ac>Dream Sign \"Evil Sealing Circle\"</ac></fs>\n* User: Reimu Hakurei\n* Notes: Often seen, movement stress type\n* Reference level: ★★\nA Spell Card where your movement is restricted by amulets. You're bound in place by the amulets and slowly strangled to death.\nThe fast charms aren't aiming for you, so it's not as difficult as it looks. Why doesn't she just aim them straight at you?",

"Grimoire of Marisa - Reimu","<fs=30><ac>Dream Sign \"Evil Sealing Circle\"</ac></fs>\nBit of a tangent, but the amulets that Reimu uses for evil-sealing are booby-trapped. They look like gift envelopes with \"full house\" written on them, which makes you want to grab 'em, but there's nothing especially interesting in there. It's just a trap. ",

"Grimoire of Marisa - Reimu","<fs=30><ac>Dream Sign \"Duplex Barrier\"</ac></fs>\n* User: Reimu Hakurei\n* Notes: Confirmed during the Eternal Night Incident, theatrical type\n* Reference level: ★★★\nA Spell Card with a mysterious power that turns space inside-out. I'm jealous.\nIf I had an area enclosed in that barrier, my magic's range would also widen.I indirectly asked Reimu about it, but it was pointless.\n",

"Grimoire of Marisa - Reimu","<fs=30><ac>Dream Sign \"Duplex Barrier\"</ac></fs>\nApparently, a barrier is a boundary line between things, and having two barriers on top of each other is equivalent to a world with no boundaries. If you can find the gaps in space that are hiding just about everywhere, you'll be able to set up a duplex barrier.\nIn other words, she's bad at explaining things.",

"Grimoire of Marisa - Reimu","<fs=30><ac>Boundary \"Duplex Danmaku Barrier\"</ac></fs>\n* User: Reimu Hakurei\n* Notes: Confirmed during the Eternal Night Incident, theatrical type\n* Blowhard Level: ★★★★\nA large-scale version of Duplex Barrier. This time I'm trapped in the inside part of the barrier too.\nHonestly, the regular Duplex Barrier is stronger and more scary.",

"Grimoire of Marisa - Reimu","<fs=30><ac>Boundary \"Duplex Danmaku Barrier\"</ac></fs>\nThis is the kind of thing people mean by 'a tactician getting caught up in his own schemes'.",

"Grimoire of Marisa - Reimu","<fs=30><ac>Untitled \"Flying Mysterious Shrine Maiden\"</ac></fs>\n* User: Reimu Hakurei\n* Notes: Rare, theatrical type \n* Reference level: ★\nA desperation Spell Card that Reimu whips out while in an unconscious state. Hardly ever seen.\nShe never looks at you while the spell card is in effect, so you're limited to retreating.\nHer attack is omnidirectional danmaku with no",

"Grimoire of Marisa - Reimu","<fs=30><ac>Untitled \"Flying Mysterious Shrine Maiden\"</ac></fs>\nblind spots, just sprayed everywhere at random. She's not looking, so I guess that's bound to happen.\nY'know, I always think this, but I don't see the benefit of not looking your opponent during a battle. Feels like it'd just be a disadvantage, but...",

"Grimoire of Marisa - Reimu","<fs=30><ac>Divine Spirit \"Dream Seal -Blink-\"</ac></fs>\n* User: Reimu Hakurei\n* Notes: Long distance marathon \n* Reference level: Only Reimu can do it, so it's no good as a reference\nReimu herself only moves in a straight line, but somehow she completely surrounds you. Just as you think she passed behind you, she pops out from in front.",

"Grimoire of Marisa - Reimu","<fs=30><ac>Divine Spirit \"Dream Seal -Blink-\"</ac></fs>\nThe tengu and Sakuya do something similar, but for the tengu, it's just speed, and for Sakuya, it's just teleportation. Reimu's technique isn't something cheap like that. You probably don't get what I'm talking about, but I don't really get it myself.\nReimu says that \"you can't normally see the boundary that this barrier encloses, so it looks like there's countless copies of the",

"Grimoire of Marisa - Reimu","<fs=30><ac>Divine Spirit \"Dream Seal -Blink-\"</ac></fs>\nenemy.\" Is it like a small world that loops around on itself? Or maybe it's something like two mirrors facing each other?\nReimu has lots of Spell Cards like this. They don't aim directly at you, so it's like being made fun of.",

"Grimoire of Marisa - Reimu","<fs=30><ac>Divine Spirit \"Dream Seal\"</ac></fs>\n* User: Reimu Hakurei\n* Notes: Often seen\n* Reference level: ★★★★\nA Spell Card that forcibly seals you with bullets of light that ignore the laws of physics. It can supposedly exterminate any and all youkai, no questions asked. Apparently, it's a wonderful light that youkai hate more than anything, but even for humans",

"Grimoire of Marisa - Reimu","<fs=30><ac>Divine Spirit \"Dream Seal\"</ac></fs>\nit still kinda hurts. But what is \"sealing,\" anyway? Putting stuff in a rice jar?",

"Grimoire of Marisa - Reimu","<fs=30><ac>Holy Relic \"Yin-Yang Kishin Orb\"</ac></fs>\n* User: Reimu Hakurei\n* Notes: Mainly used as a trick at parties \n* Reference level: ★★★★★\nA Spell Card where she throws a giant yin-yang orb that was tucked away who-the-heck-knows-where. Unusually heavy lifting for Reimu.\nGetting hit by the yin-yang orb hurts. Like, physically. 'Cause it's a plain old, hard, heavy",

"Grimoire of Marisa - Reimu","<fs=30><ac>Holy Relic \"Yin-Yang Kishin Orb\"</ac></fs>\nball. The orb she uses in this spell card is particularly hot and heavy, but a human who gets hit with it won't get squashed flat or anything.",

"Grimoire of Marisa - Reimu","<fs=30><ac>Divine Arts \"Omnidirectional Oni-Binding Circle\"</ac></fs>\n* User: Reimu Hakurei\n* Notes: Often used when angry\n* Reference level: ★★★★\nA Spell Card in which mysterious powers take away your freedom of movement. Apparently it's for binding demons, but it binds humans just as well. Once this technique begins, all freedom will be lost until Reimu stops it.",

"Grimoire of Marisa - Reimu","<fs=30><ac>Divine Arts \"Omnidirectional Oni-Binding Circle\"</ac></fs>\nBut because Reimu can't move too, capturing this spell card is easy. All you gotta do is watch from a distance. But do I have the self-restraint to stay still and do nothing while Reimu's sitting there like an idiot? That's the biggest problem.",

"Grimoire of Marisa - Reimu","<fs=30><ac>\"Innate Dream\"</ac></fs>\n* User: Reimu Hakurei\n* Notes: Rare, theatrical type \n* 36th Stratagem Level: ★★★★★★★\nReimu becomes completely impossible to touch. She enters a visible \"invisible man\" state.\nIt's her ultimate secret technique, apparently, but it looks like she just closes her eyes while the danmaku fires itself towards the enemy automatically. ",

"Grimoire of Marisa - Reimu","<fs=30><ac>\"Innate Dream\"</ac></fs>\nBy the way, this wasn't even a Spell Card at first, but I gameified it by giving it a proper Spell Card name. Otherwise, there'd be no way to win.\nThis is the one single Spell Card that can only be used via the innate ability Reimu was born with. Hence the name \"tensei (lit. innate from birth)\".",
]

GrimoireOfMarisa_Rin = [
"Grimoire of Marisa - Rin",
"<fs=30><ac>Cat Sign \"Cat's Walk\"</ac></fs>
* User: Orin
* Notes: Can see it above ground too recently, theatrical type
* Unpleasantness: Prolly got fleas 
A cat scampering around outside in the courtyard. The cat's movements are real hard to read, but the danmaku's movement is easy.
It's no big deal if you just stay calm and dodge, but her movements are more cat-like ",

"Grimoire of Marisa - Rin",
"<fs=30><ac>Cat Sign \"Cat's Walk\"</ac></fs>
than Chen's, so don't let 'er confuse you.",

"Grimoire of Marisa - Rin",
"<fs=30><ac>Malicious Spirit \"Spleen Eater\"</ac></fs>
* User: Orin
* Notes: Feels like I'm gonna get eaten, self-destructing slave-type 
* Reference level: Noooo thank you
She summons a bunch of vengeful spirits that love eating humans' negative emotions, like anger an' hatred. 
The spleen is the organ where humans store their emotions, apparently. ",

"Grimoire of Marisa - Rin",
"<fs=30><ac>Malicious Spirit \"Spleen Eater\"</ac></fs>
If a human with emotions comes, they'll pop outta nowhere and slowly pounce upon 'em. If they beat ya an' eat yer negative emotions, you'll feel... refreshed, maybe?",

"Grimoire of Marisa - Rin",
"<fs=30><ac>Attonment \"Needle Mountain of a Former Hell\"</ac></fs>
* User: Orin
* Notes: Definitely Hell
* Painfulness: ★★★★★
A Spell Card where a bunch of spirits writhe around in pain over a mountain of countless needles. 
The needle mountain hurts like heck, even if you're not a spirit. I feel like this Spell Card",

"Grimoire of Marisa - Rin",
"<fs=30><ac>Attonment \"Needle Mountain of a Former Hell\"</ac></fs>
can give you a taste of a very Hell-esque Hell. That aside, even the pained spirits are pretty painful to get hit by. Is this what the Hell of Needle Mountains is like?",

"Grimoire of Marisa - Rin",
"<fs=30><ac>Cursed Sprite \"Zombie Fairy\"</ac></fs>
* User: Orin
* Notes: The zombies are gonna party it up tonight, slave-type 
* Good cheer: ★★★★★★ 
A Spell Card where it... seems like a bunch of fairy corpses get possessed by vengeful spirits and come back to life.
It's actually just a bunch of fun-loving fairies playing along by pretending to be",

"Grimoire of Marisa - Rin",
"<fs=30><ac>Cursed Sprite \"Zombie Fairy\"</ac></fs>
zombies and attacking you. A typical slave-type. If there aren't any fun-loving fairies around, it won't go anywhere."]

GrimoireOfMarisa_Suwako = [
"Grimoire of Marisa - Suwako",
"<fs=30><ac>Native God \"Lord Long-Arm and Lord Long-Leg\"</ac></fs>
* User: Suwako Moriya
* Notes: Strange-looking gods, movement stress type 
* Strange-Looking Level: ★★★★★★ 
A Spell Card that blocks your escape routes with the power of some long-limbed, youkai-like gods.
\"Native gods\" are basically country bumpkin",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>Native God \"Lord Long-Arm and Lord Long-Leg\"</ac></fs>
gods. I think the gods from those rural areas are so strange-looking because they're actually youkai pretending to be gods.",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>Divine Tool \"Moriya's Iron Ring\"</ac></fs>
* User: Suwako Moriya
* Notes: Big, but thinner than I thought 
* Reference Level: ★★★★ 
A Spell Card that throws super-huge iron rings. 
It's a simple, bold attack; my favorite. They're so big that it freaks me out a little, though. 
When I asked her what the iron rings actually",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>Divine Tool \"Moriya's Iron Ring\"</ac></fs>
are, though, she said that they're hula-hoops. Dang, that's native gods for ya. ",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>Spring Sign \"Jade of the Horrid River\"</ac></fs>
* User: Suwako Moriya
* Notes: You can swim like a fish at the shrine on top of the mountain 
* Reference Level: ★★★★★
There's apparently a place called Itoigawa in the Outside World, where you can harvest a bunch of jade. And it's got a real storied past, too...
This Spell Card is apparently based on that",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>Spring Sign \"Jade of the Horrid River\"</ac></fs>
river's current, but the danmaku doesn't flow like a river. It forces me to either get dragged along by the current or fight against it, which is pretty unique.
Jade isn't very hard, but it has the property of being very hard to break. Even if it hits the ground, it won't shatter. I actually like jade a lot! ",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>Frog Hunt \"The Snake Eats the Croaking Frog\"</ac></fs>
* User: Suwako Moriya
* Notes: At the shrine on top of the mountain, theatrical type 
* Croaking Volume: ★★★★★★★
A Spell Card where a frog strikes back after getting eaten by a snake. Or a big, noisy mass of frogs, I suppose. 
In this Spell Card, when one frog cries out,",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>Frog Hunt \"The Snake Eats the Croaking Frog\"</ac></fs>
they all start croakin' in a chain reaction, and attack whoever's nearby. So you have to get really far away from the frogs before they start making a commotion. Interestingly enough, as you're trying to dodge them, you end up leaping right into Suwako's face. It's a counterattack from the frogs the snake ate, so I s'pose the frogs eat the human in turn? ",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>\"Suwa War - Native Myth vs Central Myth\"</ac></fs>
* User: Suwako Moriya
* Notes: \"Wait, I'm a civilian!\", theatrical type 
* Dragged-Into-It Level: ★★★★★★★ 
A Spell Card that flings you into a battlefield you've never heard of before. Extremely bothersome. 
The battle unfolds with essentially zero concern for you. If you wanna win, you just ",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>\"Suwa War - Native Myth vs Central Myth\"</ac></fs>
have to keep dodging the stray bullets. So it's a Spell Card where you can't do anything but run. 
As for what kind of battlefield it is, there's weeds that spring up one after another, and iron blades that chop them down. Which represents... the drudgery of gardening? Maybe? ",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>Scourge Sign \"Mishaguji-sama\"</ac></fs>
* User: Suwako Moriya
* Notes: At the shrine on top of the mountain
* Reference Level: ★★ 
Another native god, apparently. So a youkai, in my book. 
This particular god mainly seems to govern crops. Visually speaking, I suppose the danmaku represents crops rustling in the breeze. ",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>Scourge Sign \"Mishaguji-sama\"</ac></fs>
Beautiful in its extreme simplicity. It's not particularly strong as a result, but if you mock this god, it apparently changes dramatically. The soil turns barren, and the crops wither in the blink of an eye. I guess that'd make it into a much pricklier Spell Card, huh?
I wanna try makin' her mad so I can see that new spell. May as well, right? Although the",

"Grimoire of Marisa - Suwako",
"<fs=30><ac>Scourge Sign \"Mishaguji-sama\"</ac></fs>
crops withering would be a bit of a problem. ",
]

GrimoireOfMarisa_Cirno = [
"Grimoire of Marisa - Cirno",
"<fs=30><ac>Freeze Sign \"Perfect Freeze\"</ac></fs>
* User: Cirno
* Notes: Seen very frequently, theatrical type
* Temperature: ★
An unexpectedly amazing Spell Card that instantly freezes danmaku of any kind.
After being frozen, the bullets gradually start moving around, like melting ice sliding at random. No one can predict what'll happen",

"Grimoire of Marisa - Cirno",
"<fs=30><ac>Freeze Sign \"Perfect Freeze\"</ac></fs>
after the bullets thaw... including Cirno, of course. 
In other words, it's all up to the ice to decide whether the danmaku becomes more difficult or actually gets easier. It's amazing as heck, but I definitely can't use it. ",

"Grimoire of Marisa - Cirno",
"<fs=30><ac>Freeze Sign \"Minus K\"</ac></fs>
* User: Cirno
* Notes: Sometimes seen above the lake
* Temperature Impossible to measure
A Spell Card where she drastically chills the danmaku, creating a difference in density between the inside and outside of the bullets, which causes them to crack and forcefully explode. 
Using the smallest possible danmaku to make",

"Grimoire of Marisa - Cirno",
"<fs=30><ac>Freeze Sign \"Minus K\"</ac></fs>
the biggest possible attack. Dang, that's good.
The bullets are pretty sparse before they explode, though, so you'll almost never get hit if you stay close to her. Well, she's only a fairy, after all. If you put more thought into the balance between the shooting volume and the density, I think it'd become stronger, but... ",

"Grimoire of Marisa - Cirno",
"<fs=30><ac>Freeze Sign \"Minus K\"</ac></fs>
Maybe I oughta get someone to teach me how to calculate this stuff.",
]

GrimoireOfMarisa_Parsee = [
"Grimoire of Marisa - Parsee",
"<fs=30><ac>Jealousy Sign \"Green-Eyed Monster\"</ac></fs>
* User: Parsee Mizuhashi
* Notes: Saw it on the way to the underworld, slave-type (invisible)
* Jealousy Level: ★★★ 
A spell that hits you with the sheer panic of running from an unidentifiable monster. 
If you look closely, Parsee just sits still and leaves the monster to do everything. Must be nice. ",

"Grimoire of Marisa - Parsee",
"<fs=30><ac>Jealousy Sign \"Green-Eyed Monster\"</ac></fs>
This is an invisible slave-type spell. I feel like I wanna have at least one of this type of Spell Card. If I were to develop a slave-type spell, what should I use as the slave? I wanna live with my eyes peeled for potential slaves.",

"Grimoire of Marisa - Parsee",
"<fs=30><ac>Grandpa Hanasaka \"Shiro's Ashes\"</ac></fs>
* User: Parsee Mizuhashi
* Notes:  One of several party tricks, theatrical type 
* Jealousy Level: ★★★★ 
She sprinkles the burnt ashes of... something, and flowers bloom in its wake. They bloom regardless of the season or the type of tree. 
Everyone's always amazed by the pretty",

"Grimoire of Marisa - Parsee",
"<fs=30><ac>Grandpa Hanasaka \"Shiro's Ashes\"</ac></fs>
flowers, but what's really amazing are the ashes. I wonder where she hides those. I'm jealous. 
The actual attack is nothing special, by the way. I could dodge flower petals in my sleep. ",

"Grimoire of Marisa - Parsee",
"<fs=30><ac>Tongue-Cut Sparrow \"Large Box and Small Box\"</ac></fs>
* User: Parsee Mizuhashi
* Notes: Mostly old folktales, slave-type
* Jealousy Level: ★★
A clone technique that makes a fake Parsee appear.
Even fairies know that the big one is the wrong one.
But, y'know, I'd like to choose the big one on",

"Grimoire of Marisa - Parsee",
"<fs=30><ac>Tongue-Cut Sparrow \"Large Box and Small Box\"</ac></fs>
 purpose. There's just something better about getting youkai from the large box rather than coins from the small box.",

"Grimoire of Marisa - Parsee",
"<fs=30><ac>Malice Sign \"Shrine Visit in the Dead of Night\"</ac></fs>
* User: Parsee Mizuhashi
* Notes: Seen often at shrines and such 
* Jealousy Level: Not jealous of that 
An unfortunate spell that's supposed to be ominous, but actually looks pretty.
The flames of jealousy shooting out from the five-inch nails of spite are, ironically, quite brilliant.",

"Grimoire of Marisa - Parsee",
"<fs=30><ac>Malice Sign \"Shrine Visit in the Dead of Night\"</ac></fs>
Maybe it'd be fun to give that whole \"midnight shrine visit\" thing a try. I wonder who I should have a grudge against? "
]

GrimoireOfMarisa_Letty = [
"Grimoire of Marisa - Letty",
"<fs=30><ac>Cold Sign \"Cold Snap\"</ac></fs>
* User: Letty Whiterock
* Notes: Often seen in late winter 
* Reference Level: ★★ (but limited to winter)
Really cold. The snow on cold days is really small and fine. \"Cold snap\" means a cold wave.
On a cold day like this, you've gotta curl up in the kotatsu while looking sideways at the dog frolicking outside.
But meeting her on a terribly cold day would ",

"Grimoire of Marisa - Letty",
"<fs=30><ac>Cold Sign \"Cold Snap\"</ac></fs>
be the worst. You'd have no choice but to run around like the dog to keep warm.",

"Grimoire of Marisa - Letty",
"<fs=30><ac>Winter Sign \"Flower Wither Away\"</ac></fs>
* User: Letty Whiterock
* Notes: Seen from autumn to winter 
* Reference Level: ★ (but limited to winter)
A Spell Card that's meant to feel like a bunch of flowers all withering at once, apparently. 
This kind of wilted danmaku is no match for me. 
But... I ain't good with the cold. ",
]

GrimoireOfMarisa_Aya = [
"Grimoire of Marisa - Aya",
"<fs=30><ac>Crossroad Sign \"Crossroads of Heaven\"</ac></fs>
* User: Aya Shameimaru
* Notes: Often seen when I get chased away on mountain paths
* Reference Level: ★★★ 
A path that was already treacherous is made even more treacherous by the tengu. 
This danmaku has a pretty strong \"dead end\" vibe to it, but if you look closely, there's a path right in the middle. Guiding people is part",

"Grimoire of Marisa - Aya",
"<fs=30><ac>Crossroad Sign \"Crossroads of Heaven\"</ac></fs>
of a tengu's duty, so that's pretty fitting.
If it were up to me, I'd put a Master Spark through the middle.",

"Grimoire of Marisa - Aya",
"<fs=30><ac>Wind God \"Wind God's Leaf-Veiling\"</ac></fs>
* User: Aya Shameimaru
* Notes: Often used when Aya runs away
* Reference Level: ★★★★
A Spell Card that obscures Aya's form with a massive number of leaves. One of the classic youkai arts. 
But for something that's supposed to be camouflage, I can't help but think that it's just making her position more apparent. She's",

"Grimoire of Marisa - Aya",
"<fs=30><ac>Wind God \"Wind God's Leaf-Veiling\"</ac></fs>
probably a real show-off at heart. 
But for something that's supposed to be camouflage, I can't help but think that it's just making her position more apparent. She's probably a real show-off at heart. 
There's next to no leeway to approach Aya, so you've just gotta dart back and forth between the sharp leaves from a distance.
There's next to no leeway to approach Aya, so",

"Grimoire of Marisa - Aya",
"<fs=30><ac>Wind God \"Wind God's Leaf-Veiling\"</ac></fs>
you've just gotta dart back and forth between the sharp leaves from a distance. ",

"Grimoire of Marisa - Aya",
"<fs=30><ac>\"Illusionary Dominance\"</ac></fs>
* User: Aya Shameimaru
* Notes: Bet she'll get pulled over for speeding, theatrical type
* Speed: ★★★★★★★
Her most befitting Spell Card, where she flies around at ultra-high speeds.
Her speed is just extraordinary; it's downright impossible to land an attack on her. If she can move at this speed without even",

"Grimoire of Marisa - Aya",
"<fs=30><ac>\"Illusionary Dominance\"</ac></fs>
being doped up on anything, then there's practically nothin' she can't do. Dunno why she sits around doing boring stuff like journalism all day.
By the way, this danmaku is totally useless as a reference for my magic, and there's obviously no particular trick to dodging it besides \"try real hard\" either. ",
]

GrimoireOfMarisa_Suika = [
"Grimoire of Marisa - Suika",
"<fs=30><ac>Kishin \"Missing Purple Power\"</ac></fs>
* User: Suika Ibuki
* Notes: Usually seen at parties, doping type (alcohol)
* Reference Level: As if 
She gets bigger, usually when she's drunk at parties. I mean, she's always drunk, but y'know.
This sorta thing ain't danmaku. Totally useless as a reference. She really is just a monster.",

"Grimoire of Marisa - Suika",
"<fs=30><ac>Oni Sign \"Complete Massacre on Mt.Ooe\"</ac></fs>
* User: Suika Ibuki
* Notes: Usually seen at parties, a real spicy drunk
* Reference Level: Won't
She catches and throws you, usually when she's drunk at parties.
Again: not danmaku. Hurts a ton, too.",

"Grimoire of Marisa - Suika",
"<fs=30><ac>Ghastly Air \"Deep Fog Labyrinth\"</ac></fs>
* User: Suika Ibuki
* Notes: Usually seen at parties
* Reference Level: Doesn't seem likely 
She shows off a trick where she disperses her body like mist, usually when she's drunk at parties. 
A monstrously crafty Spell Card where you can't touch her at all, but she can attack all she wants. ",

"Grimoire of Marisa - Suika",
"<fs=30><ac>Ghastly Air \"Deep Fog Labyrinth\"</ac></fs>
I wonder how the world looks to her while she's in mist form?
As always, I can't use this as a reference. ",

"Grimoire of Marisa - Suika",
"<fs=30><ac>\"Night Parade of a Million Demons\"</ac></fs>
* User: Suika Ibuki
* Notes: Usually seen at parties
* Reference Level: ★★★ 
Suika's only danmaku-like danmaku.
Even though it's her only one, it attacks with nothing but projectile quantity, making it the most danmaku-like danmaku in Gensokyo.
It just flattens you with pure power, so forget tryin' to strategize your way through",

"Grimoire of Marisa - Suika",
"<fs=30><ac>\"Night Parade of a Million Demons\"</ac></fs>
it. It's pretty difficult to imitate, too.
She hardly uses any Spell-Card-like Spell Cards, but when she does decide to use one once in a while, she throws out this sort of overpowered mess. Oni really are behind the times. They don't understand these newfangled pastimes of ours at all."
]

GrimoireOfMarisa_Iku = [
"Grimoire of Marisa - Iku",
"<fs=30><ac>Thorn Sign \"Thundercloud Stickleback\"</ac></fs>
* User: Iku Nagae
* Notes: Saw it in the clouds, \"I personally\" type
* Reference Level: ★★★
A Spell Card where she turns herself into a giant bullet and bodyslams ya. 
She ignores all your attacks an' just charges straight at ya. Simple, but surprisingly strong.",

"Grimoire of Marisa - Iku",
"<fs=30><ac>Thorn Sign \"Thundercloud Stickleback\"</ac></fs>
This one reaffirmed to me that even a single bullet can be plenty strong enough.",

"Grimoire of Marisa - Iku",
"<fs=30><ac>Light Orb \"Dragon's Gleaming Eyes\"</ac></fs>
* User: Iku Nagae
* Notes: Saw it in the clouds 
* Reference Level: ★
A Spell Card based on the image of a dragon flying through thunderclouds, its eyes gleaming.
...So do dragons spin while they fly?",

"Grimoire of Marisa - Iku",
"<fs=30><ac>Cloud Realm \"Thunder Court in the Sea of Abstruse Clouds\"</ac></fs>
* User: Iku Nagae
* Notes: It's all up to the lightning
* Reference Level: ★★★
A Spell Card where it feels like you've plunged into a thundercloud.
You're forced to fight while lightning bolts streak around ya in every direction. 
Lightning strikes high places, apparently. In",

"Grimoire of Marisa - Iku",
"<fs=30><ac>Cloud Realm \"Thunder Court in the Sea of Abstruse Clouds\"</ac></fs>
other words, the nail that sticks out gets hammered down (by lightning).",

"Grimoire of Marisa - Iku",
"<fs=30><ac>Dragon Fish \"Oarfish's Swimming Shot\"</ac></fs>
* User: Iku Nagae
* Notes: Electrifyin' 
* Shoulder Relief Level: None 
A Spell Card that shoots rotating light bullets in all directions. Probably meant to feel like fish leisurely swimmin' around. 
It's a Spell Card with no blind spots, but since it's slow, it's not especially scary. 
Lightning's still pretty scary, though. I",

"Grimoire of Marisa - Iku",
"<fs=30><ac>Dragon Fish \"Oarfish's Swimming Shot\"</ac></fs>
wanna avoid gettin' hit with this as much as possible. "
]

GrimoireOfMarisa_Kisume = [
"Grimoire of Marisa - Kisume",
"<fs=30><ac>Horror \"Tsurube-Otoshi Apparition\"</ac></fs>
* User: Kisume
* Notes: Seen in the evening from fall to winter
* Reference Level: It's only a jerk-in-the-box
A Spell Card where she just suddenly lunges at you from somewhere like the top of a tree, or the ceiling of a cave. As long as she doesn't catch you by surprise, there's absolutely nothing to be frightened of. ",
]

GrimoireOfMarisa_Marisa = [
"Grimoire of Marisa - Marisa",
"<fs=30><ac>Magic Sign \"Milky Way\"</ac></fs>
* User: Me
* Notes: Not that tiring 
* Usage: ★★★★★ 
A Spell Card where I leave everything up to the star pieces floatin' around. 
Everyone else seems to hate this Spell Card, but it's actually got a flaw: its strength varies wildly depending on the concentration of star particles in the atmosphere. ",

"Grimoire of Marisa - Marisa",
"<fs=30><ac>Magic Sign \"Milky Way\"</ac></fs>
It's no good as a finishin' move.",

"Grimoire of Marisa - Marisa",
"<fs=30><ac>Black Magic \"Event Horizon\"</ac></fs>
* User: Me
* Notes: Tiring, slave-type 
* Usage: ★★★
My slave-type. Seems like I'm only capable of handlin' slaves that just go around me in circles.
This Spell Card is the result of me takin' those slaves with limited movement, and trying my darnedest to make it as hard as possible. 
Still got a long way to go.",

"Grimoire of Marisa - Marisa",
"<fs=30><ac>Love Sign \"Master Spark\"</ac></fs>
* User: Me
* Notes: Fun
* Usage: ★★★★★★★ 
A Spell Card where I shoot through the opponent with super-high firepower. It feels great, so I use it most often. But in spite of how good it feels, it leaves me wide open, so I can't manage to make it very difficult. That's a flaw it has. 
",

"Grimoire of Marisa - Marisa",
"<fs=30><ac>Love Sign \"Master Spark\"</ac></fs>
But in spite of how good it feels, it leaves me wide open, so I can't manage to make it very difficult. That's a flaw it has. 
Incidentally, I'm using the mini-Hakkero to create the laser, but I'm researchin' how to modify it to shoot a diffusional Master Spark.
Even if it doesn't hit as hard, scattered is more powerful. That's what danmaku is, after all. ",

"Grimoire of Marisa - Marisa",
"<fs=30><ac>Light Blast \"Shoot the Moon\"</ac></fs>
* User: Me
* Notes: So-so
* Usage: ★★ 
A Spell Card where I toss bullets that emit light in straight lines, which shoot lasers up at the sky upon impact. 
I crammed magic energy into the light bullets, using Alice's exploding-doll attack as a reference. 
",

"Grimoire of Marisa - Marisa",
"<fs=30><ac>Light Blast \"Shoot the Moon\"</ac></fs>
I'm not a monster, though, so there's no need to make 'em shaped like people. 
",

"Grimoire of Marisa - Marisa",
"<fs=30><ac>\"Blazing Star\"</ac></fs>
* User: Me
* Notes: Ride like the wind, \"I personally\" type
* Usage: ★★★★★
A Spell Card where I fire a Master Spark backwards, using the thrust from it to soar through the sky.
Flyin' at extreme speed feels great. I wonder if tengu feel like this, too.
The thought of bodyslammin' something at",

"Grimoire of Marisa - Marisa",
"<fs=30><ac>\"Blazing Star\"</ac></fs>
that speed is a little scary, though... 'specially in forests or buildings.
",


"Grimoire of Marisa - Marisa",
"<fs=30><ac>Star Sign \"Dragon Meteor\"</ac></fs>
* User: Me
* Notes: And to the stars!
* Usage: ★★
A Spell Card where I fire a Master Spark downwards, using it to hover in midair. 
Shooting from a position of absolute safety is WAY too much fun. 
It's hard to score a hit with the laser, of course, but that doesn't matter one bit. 
",

"Grimoire of Marisa - Marisa",
"<fs=30><ac>Star Sign \"Dragon Meteor\"</ac></fs>
Even if you lose a Spell Card battle, you win as long as it feels fun. It's a game, after all. Games aren't something that you sit and wait to be entertained by; they're something you go out of your way to enjoy.
Maybe when you reach the point when you can enjoy anything, that's when you see the true appeal of Spell Cards for the first time. ",
]

Books = [
	GensouKyouEdict,                    # 0
	HistoryOfGensokyo,                  # 1
	HakureiClanHistory,                 # 2
	IncidentHistory,                    # 3
	GensokyoChronicle_Rumia,            # 4
	GensokyoChronicle_Nue,              # 5
	GensokyoChronicle_Medicine,         # 6
	GensokyoChronicle_Yuuka,            # 7
	GensokyoChronicle_Yamame,           # 8
	GensokyoChronicle_Yukari,           # 9
	GensokyoChronicle_Koishi,           # 10
	GensokyoChronicle_Nazrin,           # 11
	GensokyoChronicle_Reimu,            # 12
	GensokyoChronicle_Marisa,           # 13
	GensokyoChronicle_Eirin,            # 14
	GensokyoChronicle_Sanae,            # 15
	GensokyoChronicle_Byakuren,         # 16
	GensokyoChronicle_Keine,            # 17
	GensokyoChronicle_Kanako,           # 18
	GensokyoChronicle_Minoriko,         # 19
	GensokyoChronicle_Eiki,             # 20
	GensokyoChronicle_HumanVillage,     # 21
	GensokyoChronicle_HakureiShrine,    # 22
	GensokyoChronicle_ForestOfMagic,    # 23
	GensokyoChronicle_SDMansion,        # 24
	GensokyoChronicle_Hakugyokurou,     # 25
	GensokyoChronicle_Eientei,          # 26
	GensokyoChronicle_LunarCapital,     # 27
	GensokyoChronicle_SpellCardDraft,   # 28
	GensokyoChronicle_Colophon,         # 29
	GrimoireOfMarisa_Reimu,             # 30
	GrimoireOfMarisa_Rin,               # 31
	GrimoireOfMarisa_Suwako,            # 32
	GrimoireOfMarisa_Cirno,             # 33
	GrimoireOfMarisa_Parsee,            # 34
	GrimoireOfMarisa_Letty,             # 35
	GrimoireOfMarisa_Aya,               # 36
	GrimoireOfMarisa_Suika,             # 37
	GrimoireOfMarisa_Iku,               # 38
	GrimoireOfMarisa_Kisume,            # 39
	GrimoireOfMarisa_Marisa             # 40
]

class Textbook_Scene
DEFAULT_BG = "textbookbg"

  def pbUpdate
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartTextbookScene(book)
    @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999
    @page = 0
    @book = book
    @bookarray= Books[book]
    @max=Books[book].length
    @sprites = {}
    @sprites["background"] = IconSprite.new(0,0,@viewport)
    @sprites["overlay"] = BitmapSprite.new(Graphics.width,Graphics.height,@viewport)
    pbSetSystemFont(@sprites["overlay"].bitmap)
    @sprites["leftarrow"] = AnimatedSprite.new("Graphics/UI/left_arrow",8,40,28,2,@viewport)
    @sprites["leftarrow"].x       = -4
    @sprites["leftarrow"].y       = 10
    @sprites["leftarrow"].play
    @sprites["rightarrow"] = AnimatedSprite.new("Graphics/UI/right_arrow",8,40,28,2,@viewport)
    @sprites["rightarrow"].x       = (Graphics.width)-36
    @sprites["rightarrow"].y       = 10
    @sprites["rightarrow"].visible = (!@choosing || numfilledpockets>1)
    @sprites["rightarrow"].play
    drawTextbookPage(@page)
    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites) { pbUpdate }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end

  def drawTextbookPage(page)
    book   = @book
	background = "Graphics/UI/Book/Book_#{@book}/TBbg_#{@page}.png"
	defaultbg = "Graphics/UI/Book/#{DEFAULT_BG}"
    @sprites["leftarrow"].visible = (@page>0)
    @sprites["rightarrow"].visible = (@page+3<@max)
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    base   = Color.new(0,0,0)
    #base = Color.new(255,255,255)
    # Set background image
    if File.exist?(background)
      #echoln "Using custom background: #{background}"
	  @sprites["background"].setBitmap(background)
    else
	  #echoln "No custom background found. Using default."
      @sprites["background"].setBitmap(defaultbg)
    end
    imagepos=[]
    # Write various bits of text
    pagename = @bookarray[page]
    textpos = [
       [pagename,Graphics.width/2,11,2,base]#,shadow]
    ]
    #For title size
    @sprites["overlay"].bitmap.font.size=32
    pbDrawTextPositions(overlay,textpos)
    @sprites["overlay"].bitmap.font.size=26
    text=@bookarray[page+1]
    drawFormattedTextEx(overlay,25,45,Graphics.width-40,text,base)#,shadow)
  end


  def pbTextbookScene
    loop do
      Graphics.update
      Input.update
      pbUpdate
      dorefresh = false
      if Input.trigger?(Input::B)
        pbPlayCloseMenuSE
        break
      elsif Input.trigger?(Input::LEFT)
        oldpage = @page
        @page -= 2
        @page = 0 if @page<0
        if @page!=oldpage   # Move to next page
          pbSEPlay("Page Turn")
          dorefresh = true
        end
      elsif Input.trigger?(Input::RIGHT)
        oldpage = @page
        @page += 2
        @page = @max-2 if @page+3>@max
        if @page!=oldpage   # Move to next page
          pbSEPlay("Page Turn")
          dorefresh = true
        end
      end
      if dorefresh
        drawTextbookPage(@page)
      end
    end
  end
end

#########################################