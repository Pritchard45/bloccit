require 'random_data'

50.times do

  Post.create!(

    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )

end
posts = Post.all

100.times do
  Comment.create!(

    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

post_new = Post.find_or_create_by!(
  title: "New Post New Title",
  body: "New body New Post"
)

Comment.find_or_create_by!(post: post_new, body: "Unqiue comment")

50.times do
  Advertisement.create!(
    title: RandomData.random_sentence,
    copy: RandomData.random_paragraph,
    price: RandomData.random_integer
  )
end
advertisements = Advertisement.all

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created."
