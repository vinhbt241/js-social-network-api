main_user = User.create(name: "Vinh")

main_post_one = Post.new(content: "What a beautiful day! Hope everyone is happy like me!")
main_post_one.user = main_user
main_post_one.save

main_post_two = Post.new(content: "Gonna have a brunch today, anyone wanna join?")
main_post_two.user = main_user
main_post_two.save
