# Clear existing data
puts "Clearing existing data..."
Favorite.destroy_all
Step.destroy_all
Ingredient.destroy_all
Recipe.destroy_all
User.destroy_all

# Create users
puts "Creating users..."
admin = User.create!(
  username: "admin",
  email: "admin@example.com",
  password: "password",
  bio: "Website administrator who loves trying all kinds of food."
)

user1 = User.create!(
  username: "chef_wang",
  email: "wang@example.com",
  password: "password",
  bio: "Professional Chinese chef specializing in Sichuan cuisine."
)

user2 = User.create!(
  username: "baker_li",
  email: "li@example.com",
  password: "password",
  bio: "Dessert enthusiast who loves baking cakes and cookies."
)

# Create recipes
puts "Creating recipes..."
recipe1 = Recipe.create!(
  title: "Kung Pao Chicken",
  description: "Kung Pao Chicken is a classic Sichuan dish featuring chicken, peanuts, and chili peppers with a spicy, savory flavor.",
  cook_time: 30,
  user: user1
)

recipe2 = Recipe.create!(
  title: "Tomato Egg Stir-fry",
  description: "Tomato Egg Stir-fry is a simple and delicious home-style dish with a sweet and sour taste that goes perfectly with rice.",
  cook_time: 15,
  user: admin
)

recipe3 = Recipe.create!(
  title: "Chocolate Chip Cookies",
  description: "Crispy, delicious chocolate chip cookies with a rich flavor that's sweet but not overwhelming.",
  cook_time: 45,
  user: user2
)

# Add ingredients
puts "Adding ingredients..."
# Kung Pao Chicken ingredients
recipe1.ingredients.create!([
  { name: "Chicken breast", quantity: "300g" },
  { name: "Peanuts", quantity: "50g" },
  { name: "Dried chili peppers", quantity: "10" },
  { name: "Green onions", quantity: "3" },
  { name: "Ginger", quantity: "1 small piece" },
  { name: "Garlic", quantity: "3 cloves" },
  { name: "Soy sauce", quantity: "2 tbsp" },
  { name: "Sugar", quantity: "1 tbsp" },
  { name: "Vinegar", quantity: "1 tbsp" },
  { name: "Cornstarch", quantity: "1 tbsp" }
])

# Tomato Egg Stir-fry ingredients
recipe2.ingredients.create!([
  { name: "Tomatoes", quantity: "3" },
  { name: "Eggs", quantity: "4" },
  { name: "Green onion", quantity: "1" },
  { name: "Salt", quantity: "1 tsp" },
  { name: "Sugar", quantity: "1 tsp" },
  { name: "Cooking oil", quantity: "2 tbsp" }
])

# Chocolate Chip Cookies ingredients
recipe3.ingredients.create!([
  { name: "Butter", quantity: "125g" },
  { name: "White sugar", quantity: "100g" },
  { name: "Egg", quantity: "1" },
  { name: "Vanilla extract", quantity: "1 tsp" },
  { name: "All-purpose flour", quantity: "175g" },
  { name: "Cocoa powder", quantity: "25g" },
  { name: "Baking powder", quantity: "1/2 tsp" },
  { name: "Chocolate chips", quantity: "100g" }
])

# Add cooking steps
puts "Adding cooking steps..."
# Kung Pao Chicken steps
recipe1.steps.create!([
  { position: 1, instructions: "Cut chicken breast into 1cm cubes, marinate with salt, cornstarch, and cooking wine for 10 minutes." },
  { position: 2, instructions: "Fry peanuts in oil until golden brown, remove and set aside." },
  { position: 3, instructions: "Heat oil in a wok, add dried chili peppers and Sichuan peppercorns, stir-fry until fragrant." },
  { position: 4, instructions: "Add ginger, garlic, and green onions, stir-fry until aromatic, then add chicken cubes and stir-fry until they change color." },
  { position: 5, instructions: "Add soy sauce, sugar, and vinegar, stir well, then add peanuts and green onion segments, stir-fry until evenly mixed." }
])

# Tomato Egg Stir-fry steps
recipe2.steps.create!([
  { position: 1, instructions: "Wash and cut tomatoes into chunks, cut green onion into segments." },
  { position: 2, instructions: "Beat eggs, add a pinch of salt and mix well." },
  { position: 3, instructions: "Heat oil in a wok, pour in the egg mixture and stir-fry until set but still soft, remove and set aside." },
  { position: 4, instructions: "Add a little more oil to the wok, add tomatoes and stir-fry, adding salt and sugar to taste." },
  { position: 5, instructions: "When tomatoes are soft and juicy, add the cooked eggs back in, stir-fry quickly over high heat until well mixed." }
])

# Chocolate Chip Cookies steps
# Chocolate Chip Cookies steps
recipe3.steps.create!([
  { position: 1, instructions: "Preheat the oven to 180°C (350°F)." },
  { position: 2, instructions: "Soften butter at room temperature, add white sugar and beat until the mixture increases in volume and becomes lighter in color." },
  { position: 3, instructions: "Add egg and vanilla extract, continue mixing until well combined." },
  { position: 4, instructions: "Sift in all-purpose flour, cocoa powder, and baking powder, fold in with a spatula until well mixed." },
  { position: 5, instructions: "Add chocolate chips and mix well." },
  { position: 6, instructions: "Use a spoon to scoop the dough onto a baking sheet lined with parchment paper, leaving space between each cookie." },
  { position: 7, instructions: "Bake in the preheated oven for about 12-15 minutes." },
  { position: 8, instructions: "Let the cookies cool on the baking sheet for 5 minutes, then transfer to a cooling rack to cool completely." }
])

# Add favorite relationships
puts "Adding favorite relationships..."
user1.favorites.create!(recipe: recipe3)
user2.favorites.create!(recipe: recipe1)
admin.favorites.create!(recipe: recipe2)

puts "Seed data creation complete!"
