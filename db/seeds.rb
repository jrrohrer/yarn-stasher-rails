# SEED DATA FOR TESTING

#Creating some users:

jessie = User.create(username: 'Jessie', email: 'jessie@jessie.com', password: 'password')
evelyn = User.create(username: 'Evelyn', email: 'evie@evie.com', password: 'password')

# Creating some projects:

shawl = Project.create(title: "Mamaw's Shawl", pattern_name: 'Dara', designer: 'Ksenia Naidyon', craft: 'knitting', tool_size: 'US 4, US 6', user_id: jessie.id)

hat = Project.create(title: 'Winter Hat', pattern_name: 'Barley', designer: 'Tin Can Knits', craft: 'knitting', tool_size: 'US 6', user_id: evelyn.id)

# Creating some yarn:

Yarn.create(brand_name: 'Lolabean', colorway: 'Olive Green', weight: 'DK', fiber: 'wool', yardage: 350, quantity: 2, user_id: jessie.id, project_id: shawl.id)
Yarn.create(brand_name: 'KnitPicks Stroll Gradient', colorway: 'Spacewalk', weight: 'Fingering', fiber: 'Wool/Nylon', yardage: 458, quantity: 1, user_id: jessie.id)
Yarn.create(brand_name: 'KnitPicks Stroll Gradient', colorway: 'Velvet Painting', weight: 'Fingering', fiber: 'Wool/Nylon', yardage: 458, quantity: 1, user_id: evelyn.id, project_id: hat.id)
Yarn.create(brand_name: 'Red Heart Amigurumi', colorway: 'Llama', weight: 'Fingering', fiber: 'Acrylic', yardage: 239, quantity: 1, user_id: evelyn.id)


# Creating some comments:

# jessie comments on evelyn's project:
Comment.create(content: 'This is a nice hat!', user_id: jessie.id, project_id: hat.id)
# evelyn comments on her own project:
Comment.create(content: 'I had trouble with the ribbing, but it turned out OK.', user_id: evelyn.id, project_id: hat.id)
# evelyn comments on jessie's project:
Comment.create(content: 'Mamaw will love this shawl!', user_id: evelyn.id, project_id: shawl.id)
# jessie comments on her own project:
Comment.create(content: 'The cables on this shaw are looking great.', user_id: jessie.id, project_id: shawl.id)

