Platform.create(:name => "PS3") unless Platform.find_by_name("PS3")
Platform.create(:name => "Xbox360") unless Platform.find_by_name("Xbox360")
Category.create(:name => "Action") unless Category.find_by_name("Action")
Category.create(:name => "Adventure") unless Category.find_by_name("Adventure")
Category.create(:name => "Simulation") unless Category.find_by_name("Simulation")
Category.create(:name => "Role Playing") unless Category.find_by_name("Role Playing")
Category.create(:name => "Strategy") unless Category.find_by_name("Strategy")
AgeCategory.create(:name => "General") unless AgeCategory.find_by_name("General")
AgeCategory.create(:name => "Above 18") unless AgeCategory.find_by_name("Above 18")
AgeCategory.create(:name => "Parental") unless AgeCategory.find_by_name("Parental")