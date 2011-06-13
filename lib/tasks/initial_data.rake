namespace :db do
  desc 'Creates 20 games'
task :initial => :environment do
  puts "Creating 20 games."
    Game.delete_all
   if Game.create(:name => "Dinner town detective agency",
                  :description => 
                  "Something's not right in DinerTown! Help Bernie the Bookworm become a real detective as you hunt for clues in mysteries like 
                   who stuck their finger in all the jelly donuts? and who's been partying like a rock star with the zoo animals?
                   ID the culprits as you search out the fun in this lighthearted spoof on traditional Hidden
                   Object games.",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [1,2],
                   :age_category_id => "#{(1..3).to_a.rand}",:quantity => "#{rand(4)}",:image => "" 
                )
      puts "Created \"#{Game.last.name}\""
    else
      puts "Can't create \"Dinner town detective agency\""
    end
    
   if Game.create(:name => "Game quest Bundle",
                  :description => "Jewel Quest 2 and Jewel Quest 3 in one executable file at a great low price! ",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [1,3],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\""
    else
      puts "Can't create \"Game quest Bundley\""  
    end
      
   if Game.create(:name => "Bejeweled 2",:description => "Take the classic game of gem-swapping to euphoric new heights! Adapted 
                      from its predecessor, Bejeweled 2 features four unique ways to play.",
                      :platform_id => "#{(1..2).to_a.rand}",:category_ids => [4,2],
                      :age_category_id => "#{(1..3).to_a.rand}",:quantity => "#{rand(4)}",:image => ""
                      ) 
     puts "Created \"#{Game.last.name}\""
   else
      puts "Can't create \"Bejeweled 2\""
   end
     
   if Game.create(:name => "Monopoly",
                  :description => "Own it all with this amazing version of the best-known and 
                  loved Monopoly game that brings this timeless family treat to vivid life like never before. Roll the dice and watch the cleverly animated tokens bounce around the board. Challenge your friends and family to exciting Monopoly fun, or play against an advanced AI with multiple difficulty settings. Even change the rules to suit your own tastes and styles! A stirring update to a game that's been a family favorite for more than 70 years, Monopoly is a must-have 
                  for any game library.",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [2,5],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\""  
     else
          puts "Can't create \"Monopoly\"" 
    end
    
         
   if Game.create(:name => "Secrets of Great Art",
                  :description => "Secrets slither within the canvas in Secrets of Great Art. Only you can uncover the truth behind the brush strokes! Help your amnesia stricken hero recover his lost memory and solve the mystery hidden within antique paintings. Explore 60 unique levels of beautiful paintings and put your perception skills to the test.",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [1,4],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\"" 
     else
       puts "Can't create \"Secrets of Great Art\"" 
   end
   
   if Game.create(:name => "CLUE Accusations and Alibis",
                  :description => "Use your powers of perception and ace detective skills to solve a riveting mystery in CLUE Accusations and Alibis, an original new hidden object game inspired by everyone's favorite board game. Featuring fashionable updates to your favorite CLUE characters, addictive hidden object gameplay, an all-new mansion to search, and more than 400 unique cases to solve, you'll want to return to the scene of the crime again and again. Accept your invitation to murder today!",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [2,5],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\"" 
      else
       puts "Can't create \"CLUE Accusations and Alibist\"" 
   end
   
   if Game.create(:name => "Elf Bowling 7",
                  :description => "Lace up your best pair of bowling shoes and polish your shiny Christmas ball for the wackiest adventure yet! The elves are up to no good and Santa needs your help to show those crazy elves what the true meaning of 'strike' is. It's quirky, hilarious
                   bowling fun just in time for the holiday season!",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [4,5],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\""
          else
       puts "Can't create \"Elf Bowling 7\"" 
   end
   
     
   if Game.create(:name => "Super Collapse! 1",
                  :description => "Super Collapse is back again -- and you won't believe the fun! The third installment of this highly addictive series holds more action and surprise than ever before. Adventure awaits as you explore 10 fun and unique lands in our all-new Quest mode. Earn coins along the way to purchase strategic items in the Shop, or take a breather and try your luck at one of 10 mini-games in the Casino. And for the true Collapse aficionado, new variations and classic favorites in our Quick Play mode deliver endless, back-to-back challenges! Whether you're already a fan of Collapse or new to the frenzied fun, once you start
                   clicking you won't be able to stop!",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [3,4],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
                
       puts "Created \"#{Game.last.name}\""
        else
       puts "Can't create \"Super Collapse! 1\"" 
      end
        
       
   if Game.create(:name => "Little Shop of Treasures",
                  :description => "Welcome to Huntington, a charming little town where if you look close enough, your dreams will come true. Help Huntington's shop owners find more than 1,200 unique, and cleverly hidden, items for their customers and earn enough cash to open a shop of your own! Featuring two great ways to play, an innovative hint feature",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [1,5],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        puts "Created \"#{Game.last.name}\""     
          else
       puts "Can't create \"Little Shop of Treasures\"" 
      end
        
       
          
   if Game.create(:name => "Magic Academy 2",
                  :description => "Once again trouble is brewing in the world of magic. A priceless treatise has gone missing and if it falls into the wrong hands, a demon that was banished long ago could be summoned from exile.",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [4,3],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        puts "Created \"#{Game.last.name}\""
      else
       puts "Can't create \"Magic Academy 2\"" 
      end
        
    
   if Game.create(:name => "Wedding Dash: Ready, Aim, Love!",
                  :description => "Love is in the air as Cupid visits DinerTown and Quinn starts planning her OWN wedding. With the magic of Cupid's love arrows, any!",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [1,4],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
       puts "Created \"#{Game.last.name}\""
         else
       puts "Can't create \"Wedding Dash: Ready, Aim, Love!\"" 
      end
        
 
       
   if Game.create(:name => "Artist Colony",
                  :description => "Unveil the drama in this casual Sim masterpiece of love, betrayal and creative genius. Inspire artists, sculptors, dancers & musicians to become masters of their craft.!",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [1,2,4],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\""
       
        else
       puts "Can't create \"Artist Colony\"" 
   end
   
   if Game.create(:name => "Dream Chronicles: The Chosen Child",
                  :description => "Unlock the secrets of the mysterious fairy realm in the third installment of the award-winning Dream Chronicles series. Discover hidden clues and solve challenging puzzles as you join Faye on her quest to save her daughter from the clutches of the Fairy Queen Lilith and reveal the secret prophecy of The Chosen Child",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [2,4],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\""
       
        else
       puts "Can't create \"Dream Chronicles: The Chosen Child\"" 
   end
   
   if Game.create(:name => "Womens Murder Club: Twice in a Blue Moon",
                  :description => "Reveal a criminal's murderous clues as he leads you and the Women's Murder Club on a shocking seek and find chase through San Francisco. Unravel a vicious tribute to the past by deciphering cryptic messages, uncovering facts and finding a killer before he strikes again.!",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [1,5],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\""
          else
       puts "Can't create \"Womens Murder Club: Twice in a Blue Moon\"" 
   end
   
   if Game.create(:name => "Alabama Smith in the Quest of Fate",
                  :description => "Alabama Smith is back in an all-new time-twisting adventure involving powerful relics that could alter the destiny of mankind! Join him as he hunts for the elusive Crystals of Fortune using the Amulet of Tim",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [1,2,4,5],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\""
          else
       puts "Can't create \"Alabama Smith in the Quest of Fate\"" 
   end
   
   if Game.create(:name => "Avenue Flote",
                  :description => "Mysterious events are threatening DinerTown's biggest wedding in history. As Flo, you will explore the town, interacting with neighbors that help you solve puzzles, collect missing items, and complete activities to set things right. Can you help Quinn save the wedding?",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [5,2],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\""
          else
       puts "Can't create \"Avenue Flote\"" 
   end
     
   if Game.create(:name => "Dinner detective agency",
                  :description => 
                  "Something's not right in DinerTown! Help Bernie the Bookworm become a real detective as you hunt for clues in mysteries like 
                   who stuck their finger in all the jelly donuts? and who's been partying like a rock star with the zoo animals?
                   ID the culprits as you search out the fun in this lighthearted spoof on traditional Hidden
                   Object games.",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [4,2,3],
                   :age_category_id => "#{(1..3).to_a.rand}",:quantity => "#{rand(4)}",:image => "" 
                )
      puts "Created \"#{Game.last.name}\""
    else
      puts "Can't create \"Dinner  detective agency\""
    end
    
   if Game.create(:name => "Game Bundle",
                  :description => "Jewel Quest 2 and Jewel Quest 3 in one executable file at a great low price! ",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [5,4,2],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\""
    else
      puts "Can't create \"Game  Bundley\""  
  end
  
   if Game.create(:name => "Monopoly unique",
                  :description => "Own it all with this amazing version of the best-known and 
                  loved Monopoly game that brings this timeless family treat to vivid life like never before. Roll the dice and watch the cleverly animated tokens bounce around the board. Challenge your friends and family to exciting Monopoly fun, or play against an advanced AI with multiple difficulty settings. Even change the rules to suit your own tastes and styles! A stirring update to a game that's been a family favorite for more than 70 years, Monopoly is a must-have 
                  for any game library.",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [1,4,5],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\""  
     else
          puts "Can't create \"Monopoly unique\"" 
    end
    
         
   if Game.create(:name => "Secrets of good Art",
                  :description => "Secrets slither within the canvas in Secrets of Great Art. Only you can uncover the truth behind the brush strokes! Help your amnesia stricken hero recover his lost memory and solve the mystery hidden within antique paintings. Explore 60 unique levels of beautiful paintings and put your perception skills to the test.",:platform_id => "#{(1..2).to_a.rand}",:category_ids => [3,4],
                  :age_category_id => "#{(1..3).to_a.rand}" ,:quantity => "#{rand(4)}",:image => ""
                ) 
        
       puts "Created \"#{Game.last.name}\"" 
     else
       puts "Can't create \"Secrets of good Art\"" 
   end
 end
end
