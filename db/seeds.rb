main_user = User.create(name: "Vinh", is_online: true)

Post.create(content: "What a beautiful day! Hope everyone is happy like me!", user_id: 1)
Post.create(content: "Gonna have a brunch today, anyone wanna join?", user_id: 1)

#Create friends
friend_one = User.create(name: "Viktor", is_online: true)
friend_two = User.create(name: "John", is_online: false)
friend_three = User.create(name: "Julia", is_online: false)

main_user.friends.push(friend_one, friend_two, friend_three)

friend_one.friends.push(main_user)
friend_two.friends.push(main_user)
friend_three.friends.push(main_user)

#Test friend posts
Post.create(content: "Hello, I'm Viktor, Vinh definitely can see this post!", user_id: 2)
Post.create(content: "Second post of Viktor haha!", user_id: 2)
Post.create(content: "Hello, I'm John, Vinh definitely can see this post!", user_id: 3)
Post.create(content: "Hello, I'm Julia, Vinh definitely can see this post!", user_id: 4)

#Test comments
Comment.create(content: "Almost forgot, remember to stop by my house today for your gift card!", post_id: 1, user_id: 4)
Comment.create(content: "You have a nice day too, Vinh <3", post_id: 1, user_id: 4)
Comment.create(content: "That is WHOLESOME, thanks Vinh!", post_id: 1, user_id: 2)


#Test likes
Like.create(post_id: 1, user_id: 1)
Like.create(post_id: 1, user_id: 2)
Like.create(post_id: 1, user_id: 3)
Like.create(post_id: 1, user_id: 4)

Like.create(post_id: 2, user_id: 1)
Like.create(post_id: 2, user_id: 2)
Like.create(post_id: 2, user_id: 3)

Like.create(post_id: 3, user_id: 1)
Like.create(post_id: 3, user_id: 2)

Like.create(post_id: 4, user_id: 1)


