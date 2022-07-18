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

# Test friend posts
friend_one_post_one = Post.new(content: "Hello, I'm Viktor, Vinh definitely can see this post!")
friend_one_post_one.user = friend_one
friend_one_post_one.save

friend_one_post_two = Post.new(content: "Second post of Viktor haha!")
friend_one_post_two.user = friend_one
friend_one_post_two.save

friend_two_post_one = Post.new(content: "Hello, I'm John, Vinh definitely can see this post!")
friend_two_post_one.user = friend_two
friend_two_post_one.save

friend_three_post_one = Post.new(content: "Hello, I'm Julia, Vinh definitely can see this post!")
friend_three_post_one.user = friend_three
friend_three_post_one.save

comment_one = Comment.create(content: "That is WHOLESOME, thanks Vinh!", post_id: 1, user_id: 2)
comment_two = Comment.create(content: "You have a nice day too, Vinh <3", post_id: 1, user_id: 4)
comment_three = Comment.create(content: "Almost forgot, remember to stop by my house today for your gift card!", post_id: 1, user_id: 4)

