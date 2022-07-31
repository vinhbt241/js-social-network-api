usernames = [
  "Amanda", "Braham", "Colin", "Dante", "Edward", 
  "Francis", "Gabriel", "Harper", "Isaac", "Julia", 
  "Kyrie", "Leo", "Marry", "Noah", "Omar", 
  "Peter", "Quinton", "Ryder", "UserTest"
]

post_contents = [
  "The journey of a thousand miles begins with one step.",
  "That which does not kill us makes us stronger.",
  "Life is what happens when you're busy making other plans.",
  "When the going gets tough, the tough get going.",
  "You must be the change you wish to see in the world.",
  "You only live once, but if you do it right, once is enough.",
  "Tough times never last but tough people do.",
  "Get busy living or get busy dying.",
  "Whether you think you can or you think you can't, you're right.",
  "Tis better to have loved and lost than to have never loved at all.",
  "A man is but what he knows.",
  "You miss 100 percent of the shots you never take.",
  "If you're going through hell, keep going.",
  "Strive not to be a success, but rather to be of value.",
  "Twenty years from now you will be more disappointed by the things that you didn't do than by the ones you did do."
]

usernames.each do |name|
  User.create(
    name: name,
    is_online: [true, false].sample ,
    email: "#{name.downcase}@gmail.com",
    password: "123456#{name}",
    password_confirmation: "123456#{name}"
  )
end

for i in 1..15 
  current_post = Post.create(
    content: post_contents[i - 1],
    user_id: i
  )

  current_post.image.attach(
    io: File.open("#{Dir.home}/Downloads/post_images/post_#{i}.jpg"),
    filename: "post_#{i}.jpg",
    content_type: 'image/jpg'
  )
end

user_test = User.find(19)

for i in 1..7 do 
  new_friend = User.find(i)
  Friendship.request(new_friend, user_test)
  Friendship.accept(new_friend, user_test)
end

for i in 8..15 do 
  new_friend_request = User.find(i)   
  Friendship.request(new_friend_request, user_test)
end
