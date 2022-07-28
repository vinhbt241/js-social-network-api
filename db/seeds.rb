main_user = User.create(
  name: "Vinh", 
  is_online: true, 
  email: "vinh@gmail.com",
  password: "123456Vinh",
  password_confirmation: "123456Vinh"
)
main_user.avatar.attach(
  io: File.open("#{Dir.home}/Downloads/avatar.png"),
  filename: "avatar.png",
  content_type: 'image/png'
)
main_user.background_image.attach(
  io: File.open("#{Dir.home}/Downloads/background_image.png"),
  filename: "background_image.png",
  content_type: 'image/png'
)

user_post_one = Post.create(content: "What a beautiful day! Hope everyone is happy like me!", user_id: 1)
user_post_one.image.attach(
  io: File.open("#{Dir.home}/Downloads/example_one.png"),
  filename: "example_one.png",
  content_type: 'image/png'
)

user_post_two = Post.create(content: "Gonna have a brunch today, anyone wanna join?", user_id: 1)
user_post_two.image.attach(
  io: File.open("#{Dir.home}/Downloads/example_two.png"),
  filename: "example_two.png",
  content_type: 'image/png'
)

#Create friends
friend_one = User.create(
  name: "Viktor", 
  is_online: true,
  email: "viktor@gmail.com",
  password: "123456Viktor",
  password_confirmation: "123456Viktor"
)
friend_two = User.create(
  name: "John", 
  is_online: false,
  email: "john@gmail.com",
  password: "123456John",
  password_confirmation: "123456John"
)
friend_three = User.create(
  name: "Julia", 
  is_online: false,
  email: "julia@gmail.com",
  password: "123456Julia",
  password_confirmation: "123456Julia"
)
friend_four = User.create(
  name: "Viola",
  is_online: true,
  email: "viola@gmail.com",
  password: "123456Viola",
  password_confirmation: "123456Viola"
)

Friendship.request(main_user, friend_one)

Friendship.request(main_user, friend_two)
Friendship.accept(main_user, friend_two)

Friendship.request(friend_three, main_user)

Friendship.request(main_user, friend_four)
Friendship.decline(main_user, friend_four)


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


