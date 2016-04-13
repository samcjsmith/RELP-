###
# Ruby REPL game DSL
#  methods useful for any REPL-based game
###

# get input from the user
def get_input
  print "💰 "
  gets.chomp.capitalize.strip
end

def show_line
  puts "🎌" * 70
end

def format_text(text)
  puts
  show_line
  puts text
  show_line
  puts
end

# output spoken words to the screen
def say(person, message)
  # check for nil person
  person = "#{person}: " unless person.nil?

  # format spoken text output
  format_text "# #{person}#{message}"
end

def ask_question(question, options)
  say nil, question
  say nil, "Options: #{options}"
end

# yes or no question
def yes_or_no?
  choice = get_input
  case choice
  when "Yes", 'Y', 'True', '1' # multiple option support in case/when
    true
  when "No", 'N', 'False', '0'
    false
  else
    # default yes
    true
  end
end

# end REPL game DSL
################

####
# Batman REPL game DSL
#  Batman-specific REPL game methods
####

# pick an ally and process it
def pick_ally
  ask_question("Do you want to rescue him?", "Yes or No")
  ally = get_input

  # this can be refactored to case/when
  if ally == "Yes"
    say "Yes", "Alright, here we go again!"
  elsif ally == "No"
    say "No", "You're right, go on... Netflix & Chill."
  else
    say nil, "Fine, I'll pick on for you."
    ally = "Yes"
  end

  ally
end

# pick a weapon and process it
def pick_weapon(ally)
  ask_question(
    "Awesome! Let's hire someone for the Job.",
    "Sopranos, Crenshaw Mafia, Girls Scout")

  weapon = get_input
  case weapon
  when "Sapranos"
    say ally, "Got it. No bodies left behind."
  when "Crewshaw Mafia"
    say ally, "No diggity, No doubt. We'll keep it trill."
  when "Girls Scout"
    say ally, "Uh... we can try to plead with cookies..."
  else
    say ally, "I'll pick one for you!"
    weapon = "Sopranos"
  end

  weapon
end

# pick an enemy and process it
def pick_enemy
  enemy = validate_enemy

  case enemy
  when "Work It Out"
    say enemy, "Welp, good luck!"
  when "Rehab"
    say enemy, "Great choice!"
  when "Divorce"
    say enemy, "Tinder is trill."
  else
    say nil, "This should never happen."
  end

  enemy
end

# validate the enemy selection
def validate_enemy
  puts "Tarzan is home, what do you want to do?"
  valid_enemies = ["Work It Out", "Rehab", "Divorce"]
  enemy = nil
  # you shall not pass!
  # ... until you give me a valid answer
  until valid_enemies.include?(enemy)
    say nil, "Options: #{valid_enemies.join(', ')}"
    enemy = get_input
  end

  # a verified enemy selection
  enemy
end

def intro
  say nil, "Tarzan gambling issues has caught up with him. He owe's $500k."
end

def continue?
  ask_question("Continue?", "Yes, No")
  result = yes_or_no?
  # command line code to speak words
  puts `say Goodbye!` unless result
  result
end

# end Batman REPL game DSL
####

def start_game_loop
  game_over = false
  until game_over
    intro
    sidekick = pick_ally
    weapon = pick_weapon(sidekick)
    pick_enemy
    game_over = !continue?
  end
end

start_game_loop
