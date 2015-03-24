class Intro < Tale::Chapter

  sequence 0

  at :tavern do

    event do
      detail "The tavern looks like a pile of wood and stone blew into place in the last storm."
    end

    event do
      detail "... probably blow out of place in the next."
    end

    event do
      detail "A tattered sign hangs from a leaning post."
    end

    event do
      detail "Wo ld's End T v rn"
    end

    event do
      detail "Guess this is it..."
    end

    event do
      detail "You tie your horse to the post out front. She doesn't look much better than the tavern..."
    end

    event do
      character :protagonist
      dialogue "All right, Cam. Done for the night."
      action :pat, label: "Give her mane a brush"
    end

    event do
      detail "Cam's eyes fleet nervously. Something's up."
    end

    event do
      detail "You notice it too."
    end

    event do
      detail "That familiar din of conversation and song typically found eminating from such an establishment is replaced with something different..."
    end

    event do
      detail "Something louder, more ruckus."
    end

    event do
      detail "Also familiar."
    end

    event do
      detail "You let out a long sigh as you pull your pack off the horse."
    end

    event do
      character :protagonist
      dialogue "Not what I was looking for tonight..."
    end

    event do
      detail "You weigh your options, looking around."
    end

    event do
      detail "Pitch black outside the shallow light coming from the tavern windows."
    end

    event do
      detail "Not much around here. You didn't expect much this far out."
    end

    event do
      detail "You turn back the way you just rode in..."
    end

    event do
      detail "A handful of weeks since the last town."
    end

    event do
      detail "More importantly, a lot of debt of the worst kind that way."
    end

    event do
      detail "Supposed to meet a man named Ranger at World's End Tavern, or so the job said."
    end

    event do
      detail "You turn back to the tavern. Only one option really..."
    end

    event do
      detail "You walk up to the tavern door, placing a hand on your sword hilt, and pull the iron handle."
    end

    event do
      detail "The muffled roar of yelling, crashing and combat pushing through walls elevates tenfold as the door opens."
    end

    event do
      detail "You catch a flash from the corner of your eye..."
    end

    event do
      detail "Chair! In the air, careening towards you."
      action :duck, label: "Duck!"
      action :swing, label: "Slash it with your sword"
    end

    event from: :swing do
      detail "You attempt to draw your sword, but the chair is faster."
      consequence :defend, attack_rating: 10..20
    end

    event from: :duck do
      detail "You quickly duck your head, but the chair is faster."
      consequence :defend, attack_rating: 10..20
    end

    event do
      detail "Damnit! All right. Now you're mad"
    end

    event do
      detail "You quickly scan the room"
    end

    event do
      detail "About 12 men and women are scattered around a haphazard arrangement of benches and tables"
    end

    event do
      detail "A tavernkeep behind the bar"
    end

    event do
      detail "... all in various states of ducking, hiding, or stunned fright"
    end

    event do
      detail "... all facing a large dark haired man in the center of the room."
    end

    event do
      detail "Damn that guy is big. And mad."
    end

  end

end