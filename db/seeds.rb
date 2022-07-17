main_user = User.create(name: "Vinh", is_online: true)

main_post_one = Post.new(content: "What a beautiful day! Hope everyone is happy like me!")
main_post_one.user = main_user
main_post_one.save

main_post_two = Post.new(content: "Gonna have a brunch today, anyone wanna join?")
main_post_two.user = main_user
main_post_two.save

friend_one = User.create(name: "Viktor", is_online: true)
friend_two = User.create(name: "John", is_online: false)
friend_three = User.create(name: "Julia", is_online: false)

main_user.friends.push(friend_one, friend_two, friend_three)

friend_one.friends.push(main_user)
friend_two.friends.push(main_user)
friend_three.friends.push(main_user)
