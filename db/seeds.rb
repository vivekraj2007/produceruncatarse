# coding: utf-8

puts 'Seeding the database...'

[
  { en: 'Bundles' },
  { en: 'Produce' },
  { en: 'Eggs & Dairy' },
  { en: 'Meat & Fish' },
  { en: 'Bakery' },
  { en: 'Pantry' },
  { en: 'Snacks' },
  { en: 'Drinks' },
  { en: 'Floral & Home' },
  { en: 'Prepared Foods' },
  { en: 'CSA' },
  { en: 'Misc' },
  { en: '' },

].each do |name|
   category = Category.find_or_initialize_by(name_pt: name[:pt])
   category.update_attributes({
     name_en: name[:en]
   })
 end

{
  company_name: 'ProduceRun',
  company_logo: 'http://www.producerun.com/wp-content/uploads/2014/11/rsz_producerun-green.png',
  host: 'producerun.com',
  base_url: "http://www.producerun.com",

  email_contact: 'info+contact@producerun.com',
  email_payments: 'info+finance@producerun.com',
  email_projects: 'info+projects@producerun.com',
  email_system: 'info+system@producerun.com',
  email_no_reply: 'info+no-reply@producerun.com',
  facebook_url: "https://www.facebook.com/producerun",
  facebook_app_id: '173747042661491',
  twitter_url: 'http://twitter.com/producerun',
  twitter_username: "producerun",
  mailchimp_url: "http://catarse.us5.list-manage.com/subscribe/post?u=ebfcd0d16dbb0001a0bea3639&amp;id=149c39709e",
  catarse_fee: '0.10',
  support_forum: 'http://suport.producerun.com/',
  base_domain: 'producerun.com',
  uservoice_secret_gadget: 'change_this',
  uservoice_key: 'uservoice_key',
  faq_url: 'http://suport.producerun.com/',
  feedback_url: 'http://suport.producerun.com/',
  terms_url: 'http://suport.producerun.com/',
  privacy_url: 'http://suport.producerun.com/',
  about_channel_url: 'http://blog.producerun.com',
  instagram_url: 'http://instagram.com/producerun_',
  blog_url: "http://blog.producerun.com",
  blog_url: "http://farmers.producerun.com",
  github_url: 'http://github.com/producerun',
  contato_url: 'http://suport.producerun.com/',
  mixpanel_token: 'e0e80f9f416708ba621aaf3d6aff3b85',
}.each do |name, value|
   conf = CatarseSettings.find_or_initialize_by(name: name)
   conf.update_attributes({
     value: value
   }) if conf.new_record?
end


Channel.find_or_create_by!(name: "Channel name") do |c|
  c.permalink = "sample-permalink"
  c.description = "Lorem Ipsum"
end


OauthProvider.find_or_create_by!(name: 'facebook') do |o|
  o.key = '39410167937'
  o.secret = 'e55126b947fccbff9a86d9716c179860'
  o.path = 'facebook'
end

puts
puts '============================================='
puts ' Showing all Authentication Providers'
puts '---------------------------------------------'

OauthProvider.all.each do |conf|
  a = conf.attributes
  puts "  name #{a['name']}"
  puts "     key: #{a['key']}"
  puts "     secret: #{a['secret']}"
  puts "     path: #{a['path']}"
  puts
end


puts
puts '============================================='
puts ' Showing all entries in Configuration Table...'
puts '---------------------------------------------'

CatarseSettings.all.each do |conf|
  a = conf.attributes
  puts "  #{a['name']}: #{a['value']}"
end


user = User.first_or_initialize( name: 'Asd Name', email: 'asd@asd.asd') do |user|
  user.password = 'asdasd'
  user.admin = true
  user.save!
end

user.projects.where(name: "Example project name", category: Category.first, goal: 100, about: "This is about text", video_url: 'https://www.youtube.com/watch?v=IexoJu3TMWM', permalink: 'example_permalink', online_days: 30, headline: 'Example headline').first_or_create do |p|
  puts  "example project created"
  p.send_to_analysis!
  p.approve!
end

Rails.cache.clear

puts '---------------------------------------------'
puts 'Done!'
